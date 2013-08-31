class SharesController < ApplicationController

  before_filter :authenticate_user!

  before_filter :authenticate_user_profile!


  def share_by_email


  	user = current_user

  	webshot = Webshot.find(params[:id])

    email = params[:email]

    begin
      ShareMailer.share_with_email(user, email, webshot).deliver
      status = 200
      json = {:message => "Successfully send email."}.to_json

      webshot.shares_count = webshot.shares_count + 1
      webshot.save

      p = webshot.profile

      p.shares_count += 1
      p.save

      
    rescue Net::SMTPAuthenticationError, Net::SMTPServerBusy, Net::SMTPSyntaxError, Net::SMTPFatalError, Net::SMTPUnknownError => e
      status = 400
      json = {:message => "Sorry. Unable to send email. Please try again later."}.to_json

    end

    respond_to do |format|


      format.json do
        render :status => status, :json => json
      end
    end 




  end

  private

  def share_by_email_params
    params.permit(:id, :email)
  end


end
