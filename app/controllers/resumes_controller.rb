class ResumesController < ApplicationController

	# before_action :authenticate_company! 
	# , except: [:index, :show, :home]

    def index
        @q = User.ransack(params[:q])

        @users = @q.result.paginate(page: params[:page], per_page: 30).where(["updated_at > ?", 30.days.ago]).order("updated_at DESC")

        ## Find Countries That Have Job Posts - Used for filter option
        @resumes = User.where(["updated_at > ?", 30.days.ago]).order("created_at DESC")

        @top_countries = []
        @resumes.each do |resume|
            @top_countries << resume.countrya
            @top_countries << resume.countryb
            @top_countries << resume.countryc
        end
        @top_countries_uniq = @top_countries.uniq.sort!
        # _by!{|e| e.downcase}
        
        ### Related to Original Idea of Job Types
        # @posts_uniq = ["Accounting/Finance", "Administrative", "Buyer", "Design", "Digital/eCommerce",  "Fit Model", "Human Resources", "IT", "Logistics/Supply Chain", "Marketing", "Merchandising", "Operations", "Pattern Making", "Photography", "Production", "Retail Store", "Sales", "Social Media", "Sourcing", "Stylist", "Other"]   
    end

    def show
        @user = User.find(params[:id])

        @date = Date.today - 30
    end

    def subscribe
        # @post = current_company.posts.build(post_params)

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
                    amount: 10000, # amount in cents, again
                    currency: "usd",
                    customer: customer.id,
                    description: "Standard job posting"
                )

                flash[:notice] = 'Post has been successfully posted!'

            rescue Stripe::StripeError => e
                    charge_error = e.message
            end

            if charge_error
                flash[:alert] = charge_error
                render :new
            else
                @post.save
                redirect_to posts_path
            end
    end

private 
    def resume_params
        params.require(:resume).permit(:name, :first_name, :email, :lastname, :citizenship)
    end


end