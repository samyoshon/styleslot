class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def to_param
	"#{id} #{name} #{lastname}".parameterize
  end	

  has_many :resumes

  has_attached_file :logo, :styles => { :large => "600x600>", :medium => "250x250>", :small => "150x150#",
  :thumb => "75x75#" }

  validates_attachment_content_type :logo, 
  content_type: /\Aimage\/.*\Z/,
  size: {in: 1000.kilobytes}      
end
