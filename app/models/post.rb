class Post < ActiveRecord::Base

	belongs_to :company

	attr_accessor :country_code

	def country_name
	    country = ISO3166::Country[country_code]
	    country
	    # country.translations[I18n.locale.to_s] || country.name
 	end

	def to_param
		"#{id} #{company.name} #{title}".parameterize
	end
end
