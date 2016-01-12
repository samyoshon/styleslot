class Post < ActiveRecord::Base

	belongs_to :company

	# ransack_alias :title, :post_title_or_post_description
	# ransack_alias :location, :post_city_or_post_state

end
