class Post < ActiveRecord::Base

	belongs_to :company

	def self.search(search)
		if search
  			where('title LIKE ? OR description LIKE ?', "%#{search}%", "%#{search}%") || where('city LIKE ? OR state LIKE ?', "%#{search}%", "%#{search}%")
		else
  			where(nil)
		end
	end

	 def to_param
    	"#{id}-#{name}"
  	end

end
