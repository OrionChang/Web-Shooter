class Profile < ActiveRecord::Base

	has_attached_file :photo,
					  :path => "profiles/:id/:style.:extension",
                  	  :styles => { :thumb => "57x57^", :original => "200x200^" },
                  	  :convert_options => {
						:thumb => "-resize '57x57^' -gravity north -crop '57x57+0+0'",
						:original => "-resize '200x200^' -gravity north -crop '200x200+0+0'"
					  }

	belongs_to :user
	has_many :webshots, through: :user


	validates_presence_of :nickname
end
