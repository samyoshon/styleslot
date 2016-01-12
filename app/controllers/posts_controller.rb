class PostsController < ApplicationController

	# before_action :authenticate_user!, except: [:index, :show, :home]

    def home
        @search = Post.search(params[:q])
    end

    def index
        @search = Post.search(params[:q])
        @posts = @search.result
            # if params[:search]
            #     @posts = Post.search(params[:search]).order("created_at DESC")
            # else
            #     @posts = Post.all.order('created_at DESC')
            # end
        # @posts = Post.all
            # if params[:q] && params[:l]
            #     @posts = Post.search(params[:q][:l]).paginate(page: params[:page], per_page: 30).order("created_at DESC")
            # # # elsif params[:q]

            # # elsif params[:l]
            # #     @posts = Post.where()
            # else
            #     @posts = Post.all.paginate(page: params[:page], per_page: 30).order("created_at DESC")
            # end

        # @search = Post.search(params[:q])
        # @posts = @search.result.paginate(page: params[:page], per_page: 30).order("created_at DESC")

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
      	@post = current_user.posts.build 
    end

    def show
      	@post = Post.find(params[:id])
    end

    def create
        @post = current_user.posts.build(post_params)
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
  		params.require(:post).permit(:company_id, :title, :description, :city, :state)
  	end

end
