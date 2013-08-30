class SharesController < ApplicationController

  before_filter :authenticate_user!

  before_filter :authenticate_user_profile!

  # before_action :set_webshot, only: [:show, :edit, :update, :destroy]

  # # GET /webshots
  # # GET /webshots.json
  # def index
  #   @webshots = current_user.webshots.all
  # end

  # # GET /webshots/1
  # # GET /webshots/1.json
  # def show

  #   if request.path != webshot_path(@webshot)
  #     redirect_to @webshot, status: :moved_permanently
  #   end
  # end

  # # GET /webshots/new
  # def new
  #   @webshot = Webshot.new
  # end

  # # GET /webshots/1/edit
  # def edit
  # end

  # # POST /webshots
  # # POST /webshots.json
  # def create

  #   @webshot = Webshot.new(webshot_params)
  #   @webshot.user = current_user   


  #   command = "phantomjs lib/rasterize.js '" + @webshot.url + "' #{Rails.root}/tmp/temp.png"
  #   make_log, s = Open3.capture2e(command)

  #   @webshot.store_temp("#{Rails.root}/tmp/temp.png")

  #   respond_to do |format|
  #     if @webshot.save
  #       format.html { redirect_to edit_webshot_path(:id => @webshot), notice: 'Webshot was successfully created.' }
  #       format.json { render action: 'edit', status: :created, location: @webshot }
  #     else
  #       format.html { render action: 'new' }
  #       format.json { render json: @webshot.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # # PATCH/PUT /webshots/1
  # # PATCH/PUT /webshots/1.json
  # def update

  #   @webshot.saved = true
    
  #   respond_to do |format|
  #     if @webshot.update(webshot_params)
  #       format.html { redirect_to @webshot, notice: 'Webshot was successfully updated.' }
  #       format.json { head :no_content }
  #     else
  #       format.html { render action: 'edit' }
  #       format.json { render json: @webshot.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # # DELETE /webshots/1
  # # DELETE /webshots/1.json
  # def destroy
  #   @webshot.destroy
  #   respond_to do |format|
  #     format.html { redirect_to webshots_url }
  #     format.json { head :no_content }
  #   end
  # end

  def share_by_email


  	user = current_user

  	webshot = Webshot.find(params[:id])

    email = params[:email]

    begin
      ShareMailer.share_with_email(user, email, webshot).deliver
      status = 200
      json = {:message => "Successfully send email."}.to_json

      webshot.shares = webshot.shares + 1
      webshot.save
      
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

#   private
#     # Use callbacks to share common setup or constraints between actions.
#     def set_webshot
#       @webshot = Webshot.find(params[:id])
#     end

#     # Never trust parameters from the scary internet, only allow the white list through.
    def share_by_email_params
      params.permit(:id, :email)
  	end


end
