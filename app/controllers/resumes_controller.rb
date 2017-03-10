class ResumesController < ApplicationController

	# before_action :authenticate_company! 
	# , except: [:index, :show, :home]

    def index
        @q = User.ransack(params[:q])

        @users = @q.result.paginate(page: params[:page], per_page: 30).where(["updated_at > ?", 360.days.ago]).order("updated_at DESC")

        ## Find Countries That Have Job Posts - Used for filter option
        @resumes = User.where(["updated_at > ?", 360.days.ago]).order("created_at DESC")

        @top_countries = []
        @resumes.each do |resume|
            if resume.countrya?
                @top_countries << resume.countrya
            end
            if resume.countryb?
                @top_countries << resume.countryb
            end
            if resume.countryc?
                @top_countries << resume.countryc
            end
        end
        @top_countries_uniq = @top_countries.uniq.sort!{|x,y| x <=> y }
        # .sort_by!{|e| e.downcase}
    end

    def show
        @user = User.find(params[:id])

        @date = Date.today
    end

    def subscription
        @current = current_company
    end 

    def subscribe
        @current = current_company.id

        charge_error = nil

            begin
                customer =  if current_company.stripe_id?
                                Stripe::Customer.retrieve(current_company.stripe_id)
                            else
                                Stripe::Customer.create(
                                    email: current_company.email,
                                    source: params[:stripeToken],
                                    description: "Standard Charge Customer"
                                )                 
                            end

                current_company.update(
                    stripe_id: customer.id,
                    stripe_subscription_id: nil,
                    card_last4: params[:card_last4],
                    card_exp_month: params[:card_exp_month],
                    card_exp_year: params[:card_exp_year],
                    card_brand: params[:card_brand]
                )

                Stripe::Charge.create(
                    amount: params[:company][:amount], #amount in cents, again
                    currency: "usd",
                    customer: customer.id,
                    description: "Standard job posting"
                )

                flash[:notice] = 'You now have access to contact teachers!'

            rescue Stripe::StripeError => e
                    charge_error = e.message
            end

            if charge_error
                flash[:alert] = charge_error
                debug(params)
                # redirect_to posts_path
                # render :new
            else
                current_company.monthly = Date.today() + (params[:company][:monthly]).to_i
                # add date as variable
                current_company.save
                redirect_to posts_path
            end
    end

    def update
        @current = current_company.id
    end

private 
    def resume_params
        params.require(:resume).permit(:name, :first_name, :email, :lastname, :citizenship)
    end


end
