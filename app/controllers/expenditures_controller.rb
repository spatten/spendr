class ExpendituresController < ApplicationController
  before_filter :login_required
  # GET /expenditures
  # GET /expenditures.xml
  # GET /expenditures.fxml
  def index
    @expenditures = current_user.expenditures.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @expenditures }
      format.fxml  { render :fxml => @expenditures }
    end
  end

  # GET /expenditures/1
  # GET /expenditures/1.xml
  # GET /expenditures/1.fxml
  def show
    @expenditure = Expenditure.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @expenditure }
      format.fxml  { render :fxml => @expenditure }
    end
  end

  # GET /expenditures/new
  # GET /expenditures/new.xml
  def new
    @expenditure = Expenditure.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @expenditure }
    end
  end

  # GET /expenditures/1/edit
  def edit
    @expenditure = Expenditure.find(params[:id])
  end

  # POST /expenditures
  # POST /expenditures.xml
  # POST /expenditures.fxml
  def create
    @expenditure = Expenditure.new(params[:expenditure])

    respond_to do |format|
      if @expenditure.save
        flash[:notice] = 'Expenditure was successfully created.'
        format.html { redirect_to(@expenditure) }
        format.xml  { render :xml => @expenditure, :status => :created, :location => @expenditure }
        format.fxml  { render :fxml => @expenditure }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @expenditure.errors, :status => :unprocessable_entity }
        format.fxml  { render :fxml => @expenditure.errors }
      end
    end
  end

  # PUT /expenditures/1
  # PUT /expenditures/1.xml
  # PUT /expenditures/1.fxml
  def update
    @expenditure = Expenditure.find(params[:id])
    @saved = @expenditure.update_attributes(params[:expenditure])

    respond_to do |format|
      if @saved
        flash[:notice] = 'Expenditure was successfully updated.'
        format.html { redirect_to(@expenditure) }
        format.xml  { head :ok }
        format.fxml  { render :fxml => @expenditure }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @expenditure.errors, :status => :unprocessable_entity }
        format.fxml  { render :fxml => @expenditure.errors }
      end
    end
  end

  # DELETE /expenditures/1
  # DELETE /expenditures/1.xml
  # DELETE /expenditures/1.fxml
  def destroy
    @expenditure = Expenditure.find(params[:id])
    @expenditure.destroy

    respond_to do |format|
      format.html { redirect_to(expenditures_url) }
      format.xml  { head :ok }
      format.fxml  { render :fxml => @expenditure }
    end
  end
end