class Company < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :posts

  has_attached_file :logo, :styles => { :large => "600x600>", :medium => "300x300>", :thumb => "100x100#" }

  validates_attachment_content_type :logo, content_type: /\Aimage\/.*\Z/

end
