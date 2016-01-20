class Post < ActiveRecord::Base

	belongs_to :company

	def to_param
		"#{id} #{company.name} #{title}".parameterize
	end
end
