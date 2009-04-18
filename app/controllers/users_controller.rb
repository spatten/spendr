class UsersController < ApplicationController
  before_filter :login_required, :except => [:new, :create]

  def index
    @users = [current_user]
    respond_to do |format|
      format.fxml {render :fxml => @users}
    end
  end

  # GET /users/1
  # GET /users/1.xml
  # GET /users/1.fxml
  def show
    @user = User.find(params[:id])
    @user = nil unless @user == current_user
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
      format.fxml  { render :fxml => @user.to_fxml(
                                    :methods => [:avatar_thumb, :avatar_small],
                                    :include => {:categories => {:methods => [:expenditure_sum, :expenditure_count]}, 
                                                 :expenditures => {}})}
    end
  end
  
  # render new.rhtml
  def new
    @user = User.new
  end
 
  def create
    logout_keeping_session!
    @user = User.new(params[:user])
    success = @user && @user.save
    if success && @user.errors.empty?
            # Protects against session fixation attacks, causes request forgery
      # protection if visitor resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset session
      self.current_user = @user # !! now logged in
      redirect_back_or_default('/')
      flash[:notice] = "Thanks for signing up!  We're sending you an email with your activation code."
    else
      flash[:error]  = "We couldn't set up that account, sorry.  Please try again, or contact an admin (link is above)."
      render :action => 'new'
    end
  end
  
  # PUT /users/1
  # PUT /users/1.xml
  # PUT /users/1.fxml
  def update
    @user = User.find(params[:id])
    @user = nil unless @user == current_user
    @saved = @user.update_attributes(params[:user])

    respond_to do |format|
      if @saved
        flash[:notice] = 'User was successfully updated.'
        format.html { redirect_to(@user) }
        format.xml  { head :ok }
        format.fxml  { render :fxml => @user }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
        format.fxml  { render :fxml => @user.errors }
      end
    end
  end
  
end
