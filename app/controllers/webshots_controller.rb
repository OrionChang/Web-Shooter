class WebshotsController < ApplicationController
  require "open3"

  before_filter :authenticate_user!, only: [:edit, :new, :create, :update, :destroy]
  before_filter :authenticate_user_profile!, only: [:edit, :new, :create, :update, :destroy]
  before_filter :authorize_user!, only: [:edit, :update, :destroy]

  before_action :set_webshot, only: [:show, :edit, :update, :destroy, :show_full]
  before_action :set_user, only: [:index]



  # GET /webshots
  # GET /webshots.json
  def index
    @webshots = @user.webshots.where(:saved => true).order('created_at DESC')
  end

  # GET /webshots/1
  # GET /webshots/1.json
  def show

    if request.path != webshot_path(@webshot)
      redirect_to @webshot, status: :moved_permanently
    end
  end

  def show_full
    
  end

  # GET /webshots/new
  def new
    @webshot = Webshot.new
  end

  # GET /webshots/1/edit
  def edit
  end

  # POST /webshots
  # POST /webshots.json
  def create

    @webshot = Webshot.new(webshot_params)
    @webshot.user = current_user   


    command = "phantomjs lib/rasterize.js '" + @webshot.url + "' #{Rails.root}/tmp/#{@webshot.id}.png"
    make_log, s = Open3.capture2e(command)
    
    if make_log == "success
"
      @webshot.store_temp("#{Rails.root}/tmp/#{@webshot.id}.png")
    end  

    respond_to do |format|
      if make_log == "success
"
        if @webshot.save 
          format.html { redirect_to edit_webshot_path(:id => @webshot), notice: 'Webshot was successfully created.' }
          format.json { render action: 'edit', status: :created, location: @webshot }
        else
          format.html { render action: 'new' }
          format.json { render json: @webshot.errors, status: :unprocessable_entity }
        end
      else
        flash[:alert] = "Sorry, we are unable to process this url at this time. Please try again later."
        format.html { render action: 'new' }
        format.json { render json: session[:alert], status: :unprocessable_entity }
      end

    end
  end

  # PATCH/PUT /webshots/1
  # PATCH/PUT /webshots/1.json
  def update
    
    if @webshot.saved != true
      @webshot.saved = true
      @webshot.profile.webshots_count += 1   
    end
    
    
    respond_to do |format|
      if @webshot.update(webshot_params)

        @webshot.profile.save
        format.html { redirect_to @webshot, notice: 'Webshot was successfully updated.' }
        format.json { head :no_content }
      else

        format.html { render action: 'edit' }
        format.json { render json: @webshot.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /webshots/1
  # DELETE /webshots/1.json
  def destroy
    @webshot.destroy
    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_webshot
      @webshot = Webshot.find(params[:id])
    end

    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def webshot_params
      params.require(:webshot).permit(:user_id, :title, :url, :desc, :photo)
    end




    def authorize_user!
      if current_user != set_webshot.user
        redirect_to @webshot
      end
    end
end
