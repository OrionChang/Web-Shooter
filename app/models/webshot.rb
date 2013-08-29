class Webshot < ActiveRecord::Base
	extend FriendlyId
	require "open-uri"


	belongs_to :user

	friendly_id :slug_candidates, use: [:slugged, :finders, :history]

	


	has_attached_file :photo,
	:styles => { :medium => "600x600^", :thumb => "200x200^" }, 
	:url => "screenshots/:id/:style.:extension",
	:path => "screenshots/:id/:style.:extension",
	:convert_options => {
		:thumb => "-resize '200x200^' -gravity north -crop '200x200+0+0'",
		:medium => "-resize '600x600^' -gravity north -crop '600x600+0+0'"
	}


	
	validates_presence_of :url
	validates_presence_of :photo
	validates_presence_of :title, :if => :webshot_saved?
	validates_length_of :title, :minimum => 5, :maximum => 100, :allow_blank => true
	validates_length_of :desc, :minimum => 5, :maximum => 1000, :allow_blank => true




	def webshot_saved?
		saved == true
	end


	def store_temp(url)
		self.photo = open(url)
	end

	def slug_candidates
		[
			[:title, "-by-", :get_nickname],
			[:title, "-by-", :get_nickname, "-v2"],
			[:title, "-by-", :get_nickname, "-v3"],
			[:title, "-by-", :get_nickname, "-v4"],
			[:title, "-by-", :get_nickname, "-v5"],
			[:title, "-by-", :get_nickname, "-v6"],
			[:title, "-by-", :get_nickname, "-v7"],
			[:title, "-by-", :get_nickname, "-v8"],
			[:title, "-by-", :get_nickname, "-v9"],
			[:title, "-by-", :get_nickname, "-v10"],
			[:url, "-at-", :created_at]

		]
		
	end

	def get_nickname
		self.user.profile.nickname
	end

	def should_generate_new_friendly_id?
		title_changed?
	end
end
