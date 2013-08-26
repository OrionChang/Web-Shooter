class Profile < ActiveRecord::Base

	has_attached_file :photo,
					  :path => "profiles/:id/:style.:extension",
                  	  :styles => { :thumbnail => "57x57", :original => "100x100" }

	belongs_to :user
end
