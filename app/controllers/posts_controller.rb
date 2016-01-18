class PostsController < ApplicationController

	before_action :authenticate_company!, except: [:index, :show, :home]

    def home
        @search = Post.search(params[:q])
    end

    def index
        @search = Post.search(params[:q])
        @posts = @search.result.paginate(page: params[:page], per_page: 5).where(["created_at > ?", 30.days.ago]).order("created_at DESC")

        @posts_uniq = ["Lorem", "Hello", "hello"]
        ###Find Countries That Have Job Posts - Used for filter option
  	    # @posts_all = Post.where(["created_at > ?", 30.days.ago]).order("created_at DESC")

       #  @countries = []
       #  @posts_all.each do |post|
       #      @countries << post.country_id
       #  end
       #  @countries_uniq = @countries.uniq.sort_by!{|e| e.downcase}
    end

    def new
        # @post = Post.new
      	@post = current_company.posts.build 
    end

    def show
      	@post = Post.find(params[:id])

        @instagram_user = Post.find(params[:id]).company

        @instagram = HTTParty.get("https://api.instagram.com/v1/users/search?q=samyoshon&access_token=12670140.d5cff46.6ce5a5be8f934e93937a29e8a62caf16")

        @photos = Instagram.user_recent_media("12670140", {:count => 4})
    end

    def create
        @post = current_company.posts.build(post_params)
        # @post = Post.new(post_params)
        @post.save
        redirect_to posts_path
        # charge_error = nil

        # if @post.valid? 
        #     begin
        #         customer =  if current_user.stripe_id?
        #                         Stripe::Customer.retrieve(current_user.stripe_id)
        #                     else
        #                         Stripe::Customer.create(
        #                             email: current_user.email,
        #                             source: params[:stripeToken],
        #                             description: "Standard Charge Customer"
        #                         )                 
        #                     end

        #         current_user.update(
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
        #             description: "Standard job posting"
        #         )

        #         flash[:notice] = 'Post has been successfully posted!'

        #     rescue Stripe::StripeError => e
        #             charge_error = e.message
        #     end

        #     if charge_error
        #         flash[:alert] = charge_error
        #         render :new
        #     else
        #         @post.save
        #         redirect_to posts_path
        #     end
        
        # else
        #     flash[:alert] = 'One or more errors in your order'
        #     render :new
        # end

    end

  ####### PRIVATE ######

  private 

  	def post_params
  		params.require(:post).permit(:company_id, :title, :description, :city, :state, :zip, :type, :qualifications, :benefits, :how_to, :how_to_link)
  	end

    def authenticate!
        if @current_user == current_company
            :authenticate_company!
        elsif @current_user == current_user
            :authenticate_user!
        end
    end

end
