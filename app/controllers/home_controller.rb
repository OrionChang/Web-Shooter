class HomeController < ApplicationController
  def index



  	@webshots = Webshot.where(:saved => true).order('created_at DESC').limit(10)

  	#display all webshots
  end

  #display webshots found by username

  
end
