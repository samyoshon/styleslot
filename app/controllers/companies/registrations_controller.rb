class Companies::RegistrationsController < Devise::RegistrationsController

private 
	def update_resource(resource, params)
    	resource.update_without_password(params)
  	end

  	def registration_params
  		params.require(:company).permit(:email, :name, :description, :website, :facebook, :instagram, :twitter, :logo)
	end
end
