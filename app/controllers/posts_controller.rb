class PostsController < ApplicationController

	before_action :authenticate_company!, except: [:index, :show, :home]

    def home
        @search = Post.ransack(params[:q])
    end

    def index
        @search = Post.ransack(params[:q])

        @posts = @search.result.paginate(page: params[:page], per_page: 30)
        # @posts = @search.result.paginate(page: params[:page], per_page: 30).where(["created_at > ?", 30.days.ago]).order("created_at DESC")

        ### Find Countries That Have Job Posts - Used for filter option
        @posts_all = Post.where(["created_at > ?", 30.days.ago]).order("created_at DESC")

        @countries = []
        @posts_all.each do |post|
            @countries << post.country
        end
        @countries_uniq = @countries.uniq.sort_by!{|e| e.downcase}
        
        ### Related to Original Idea of Job Types
        # @posts_uniq = ["Accounting/Finance", "Administrative", "Buyer", "Design", "Digital/eCommerce",  "Fit Model", "Human Resources", "IT", "Logistics/Supply Chain", "Marketing", "Merchandising", "Operations", "Pattern Making", "Photography", "Production", "Retail Store", "Sales", "Social Media", "Sourcing", "Stylist", "Other"]   
    end

    def new
      	@post = current_company.posts.build 

        @posts_count = current_company.posts.all.length
    end

    def show
      	@post = Post.find(params[:id])

        if params[:like]
            @post.post_view_count=@post.post_view_count+1
        end

        Post.increment_counter(:post_view_count, @post.id)

        @instagram_user = Post.find(params[:id]).company

        @instagram = HTTParty.get("https://api.instagram.com/v1/users/search?q=samyoshon&access_token=12670140.d5cff46.6ce5a5be8f934e93937a29e8a62caf16")

        @photos = Instagram.user_recent_media("12670140", {:count => 4})
    end

    def create
        @post = current_company.posts.build(post_params)
        
        # ||||| (start) this part is in the stripe function below|||||
    # @post.save
    # redirect_to posts_path
    # end
        # ||||| (end) this part is in the stripe function below|||||
    
        # ||||| (start) comment this part out when adding stripe |||||
        # if current_company.posts.all.length < 3
        #     @post.save
        #     redirect_to posts_path
        # else
        # ||||| (end) comment this part out when adding stripe |||||

        charge_error = nil

        if @post.valid? 
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
        
        else
            flash[:alert] = 'One or more errors in your order'
            render :new
        end
    end

    def update
        @post=Post.find(params[:id])

    end

  private 

  	def post_params
  		params.require(:post).permit(:company_id, :title, :description, :city, :state, :zip, :job_type, :qualifications, :benefits, :how_to, :how_to_link, :salary, :airfare, :housing, :university, :tefl, :vacation, :insurance, :country)
  	end

    def authenticate!
        if @current_user == current_company
            :authenticate_company!
        elsif @current_user == current_user
            :authenticate_user!
        end
    end

end
