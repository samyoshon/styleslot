class Company < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :posts

 #  attr_accessor :country_code

	# def country_name
	#     country = ISO3166::Country[country_code]
	#     country.translations[I18n.locale.to_s] || country.name
 # 	end

  has_attached_file :logo, :styles => { :large => "600x600>", :medium => "250x250>", :small => "150x150#",
  :thumb => "75x75#" }

  validates_attachment_content_type :logo, content_type: /\Aimage\/.*\Z/

end
