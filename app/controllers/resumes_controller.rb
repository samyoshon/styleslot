class ResumesController < ApplicationController

	# before_action :authenticate_company! 
	# , except: [:index, :show, :home]

    def index
        @user = User.search(params[:q])

        @users = @user.result.paginate(page: params[:page], per_page: 30).where(["updated_at > ?", 30.days.ago]).order("updated_at DESC")

        ### Find Countries That Have Job Posts - Used for filter option
        # @posts_all = Post.where(["created_at > ?", 30.days.ago]).order("created_at DESC")

        # @countries = []
        # @posts_all.each do |post|
        #     @countries << post.state
        # end
        # @countries_uniq = @countries.uniq.sort_by!{|e| e.downcase}
        
        ### Related to Original Idea of Job Types
        # @posts_uniq = ["Accounting/Finance", "Administrative", "Buyer", "Design", "Digital/eCommerce",  "Fit Model", "Human Resources", "IT", "Logistics/Supply Chain", "Marketing", "Merchandising", "Operations", "Pattern Making", "Photography", "Production", "Retail Store", "Sales", "Social Media", "Sourcing", "Stylist", "Other"]   
    end

    def show
        @user = User.find(params[:id])
    end

    def create
    end


private 
    def resume_params
        params.require(:resume).permit(:name, :first_name, :email, :lastname, :citizenship)
    end


end