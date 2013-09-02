class HomeController < ApplicationController




  def index
  	
  	@webshots = Webshot.where(:saved => true).order('created_at DESC').limit(10)

  end



  
end
