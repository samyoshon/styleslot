class PostsController < ApplicationController

	before_action :authenticate_company!, except: [:index, :show, :home]

    def home
        @search = Post.search(params[:q])
    end

    def index
        @search = Post.search(params[:q])
        @posts = @search.result.paginate(page: params[:page], per_page: 5).where(["created_at > ?", 30.days.ago]).order("created_at DESC")

        @posts_uniq = ["Accounting/Finance", "Administrative", "Buyer", "Design", "Digital/eCommerce",  "Fit Model", "Human Resources", "IT", "Logistics/Supply Chain", "Marketing", "Merchandising", "Operations", "Pattern Making", "Photography", "Production", "Retail Store", "Sales", "Social Media", "Sourcing", "Stylist", "Other"]   
    end

    def new
      	@post = current_company.posts.build 
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

        # comment this part out when adding stripe (start)
        if current_company.posts.all.length < 3
            @post.save
            redirect_to posts_path
        # comment this part out when adding stripe (end)
        else 
            charge_error = nil

            if @post.valid? 
                begin
                    customer =  if current_user.stripe_id?
                                    Stripe::Customer.retrieve(current_user.stripe_id)
                                else
                                    Stripe::Customer.create(
                                        email: current_user.email,
                                        source: params[:stripeToken],
                                        description: "Standard Charge Customer"
                                    )                 
                                end

                    current_user.update(
                        stripe_id: customer.id,
                        stripe_subscription_id: nil,
                        card_last4: params[:card_last4],
                        card_exp_month: params[:card_exp_month],
                        card_exp_year: params[:card_exp_year],
                        card_brand: params[:card_brand]
                    )

                    Stripe::Charge.create(
                        amount: 1600, # amount in cents, again
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

    end

    def update
        @post=Post.find(params[:id])

    end

  private 

  	def post_params
  		params.require(:post).permit(:company_id, :title, :description, :city, :state, :zip, :job_type, :qualifications, :benefits, :how_to, :how_to_link)
  	end

    def authenticate!
        if @current_user == current_company
            :authenticate_company!
        elsif @current_user == current_user
            :authenticate_user!
        end
    end

end
