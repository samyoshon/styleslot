class ResumesController < ApplicationController

	before_action :authenticate_company!, except: [:index, :show, :home]

    def index
        @search = Resume.search(params[:q])

        @resumes = @search.result.paginate(page: params[:page], per_page: 30).where(["created_at > ?", 30.days.ago]).order("created_at DESC")

        ### Find Countries That Have Job Resumes - Used for filter option
        @resumes_all = Resume.where(["created_at > ?", 30.days.ago]).order("created_at DESC")

        @countries_choice = []
        @resumes_all.each do |resume|
            @countries_choice << resume.countrya
            @countries_choice << resume.countryb
            @countries_choice << resume.countryc
        end
        @countries__choice_uniq = @countries_choice.uniq.sort_by!{|e| e.downcase}
        
        ### Related to Original Idea of Job Types
        # @resumes_uniq = ["Accounting/Finance", "Administrative", "Buyer", "Design", "Digital/eCommerce",  "Fit Model", "Human Resources", "IT", "Logistics/Supply Chain", "Marketing", "Merchandising", "Operations", "Pattern Making", "Photography", "Production", "Retail Store", "Sales", "Social Media", "Sourcing", "Stylist", "Other"]   


    end

    def new
      	@resume = current_user.resumes.build 

        @resumes_count = current_user.resumes.all.length
    end

    def show
      	@resume = Resume.find(params[:id])

        if params[:like]
            @resume.resume_view_count=@resume.resume_view_count+1
        end

        Resume.increment_counter(:resume_view_count, @resume.id)
    end

    def create
        @resume = current_user.resumes.build(resume_params)

        @resume.save
        redirect_to resumes_path
        
        # ||||| (start) this part is in the stripe function below|||||
        # @resume.save
        # redirect_to resumes_path
        # end
        # ||||| (end) this part is in the stripe function below|||||
    
        # ||||| (start) comment this part out when adding stripe |||||
        # if current_company.resumes.all.length < 3
        #     @resume.save
        #     redirect_to resumes_path
        # else
        # ||||| (end) comment this part out when adding stripe |||||

        # charge_error = nil

        # if @resume.valid? 
        #     begin
        #         customer =  if current_company.stripe_id?
        #                         Stripe::Customer.retrieve(current_company.stripe_id)
        #                     else
        #                         Stripe::Customer.create(
        #                             email: current_company.email,
        #                             source: params[:stripeToken],
        #                             description: "Standard Charge Customer"
        #                         )                 
        #                     end

        #         current_company.update(
        #             stripe_id: customer.id,
        #             stripe_subscription_id: nil,
        #             card_last4: params[:card_last4],
        #             card_exp_month: params[:card_exp_month],
        #             card_exp_year: params[:card_exp_year],
        #             card_brand: params[:card_brand]
        #         )

        #         Stripe::Charge.create(
        #             amount: 1600, # amount in cents, again
        #             currency: "usd",
        #             customer: customer.id,
        #             description: "Standard job resumeing"
        #         )

        #         flash[:notice] = 'Resume has been successfully resumeed!'

        #     rescue Stripe::StripeError => e
        #             charge_error = e.message
        #     end

        #     if charge_error
        #         flash[:alert] = charge_error
        #         render :new
        #     else
        #         @resume.save
        #         redirect_to resumes_path
        #     end
        
        # else
        #     flash[:alert] = 'One or more errors in your order'
        #     render :new
        # end
    end

    def update
        @resume=Resume.find(params[:id])

    end

  private 

  	def resume_params
  		params.require(:resume).permit(:user_id, :firstname, :lastname, :email, :dob, :citizenship, :expertise, :experience, :residence, :education, :skills, :languages, :facebook, :linkedin)
  	end

    def authenticate!
        if @current_user == current_company
            :authenticate_company!
        elsif @current_user == current_user
            :authenticate_user!
        end
    end

end
