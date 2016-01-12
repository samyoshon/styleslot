class Post < ActiveRecord::Base

	belongs_to :company

	def to_param
		"#{id} post #{company.email} #{title}".parameterize
	end

	# extend FriendlyId
 #  	friendly_id :description, use: [:slugged, :finders]
	# ransack_alias :title, :post_title_or_post_description
	# ransack_alias :location, :post_city_or_post_state

end
