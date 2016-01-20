class NewslettersController < ApplicationController

	def new
		@newsletter = Newsletter.new
	end

	def create
		@newsletter = Newsletter.new(newsletter_params)
		if @newsletter.save
			flash[:notice] = 'Email received. We\'ll keep you updated!'
			redirect_to root_path
		else
			render :new
		end
	end

private 
	def newsletter_params
     	params.require(:newsletter).permit(:first_name, :email)
	end

end