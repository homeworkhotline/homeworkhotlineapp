class PrincipalsController < ApplicationController
  before_action :set_principal, only: [:show, :edit, :update, :destroy]

  # GET /principals
  # GET /principals.json
  def index
    unless current_user && current_user
      redirect_to root_path
    end
    @principals = Principal.all
  end

  # GET /principals/1
  # GET /principals/1.json
  def show
    @principal = Principal.find(params[:id])
  end

  def sendmail
    @principal = Principal.find(params[:id])
    PrincipalMailer.email(@principal).deliver
  end

  def dlnab
    unless current_user && current_user.administrator?
      redirect_to root_path
    else
    @principal = Principal.find(params[:id])
    send_data(@principal.nab_contents,
            type: @principal.nab_content_type,
            filename: @principal.nab_filename)
  end
  end

  def dlsnl
    unless current_user && current_user.administrator?
      redirect_to root_path
    else
    @principal = Principal.find(params[:id])
    send_data(@principal.snl_contents,
            type: @principal.snl_content_type,
            filename: @principal.snl_filename)
  end
  end
    def dlnice
    unless current_user && current_user.administrator?
      redirect_to root_path
    else
    @principal = Principal.find(params[:id])
    send_data(@principal.nice_content,
            type: @principal.nice_type,
            filename: @principal.nice_name)
  end
  end

  # GET /principals/new
  def new
    @principal = Principal.new
  end

  # GET /principals/1/edit
  def edit
    unless current_user.administrator?
      redirect_to root_path
    end
  end

  # POST /principals
  # POST /principals.json
  def create
    @principal = Principal.new(principal_params)

    respond_to do |format|
      if @principal.save
       PrincipalMailer.email(@principal).deliver
        format.html { redirect_to @principal, notice: 'Principal was successfully created.' }
        format.json { render :show, status: :created, location: @principal }
      else
        format.html { render :new }
        format.json { render json: @principal.errors, status: :unprocessable_entity }
      end
    end
    ActionCable.server.broadcast "call_log_channel",{calllogs: CallLog.all.size, user: User.all.size, reports: MnpsReport.all.size,schools: School.all.size, principals: Principal.all.size, searches: Search.all.size, students:Student.all.size, timesheets: TimeClock.all.size}
  end

  # PATCH/PUT /principals/1
  # PATCH/PUT /principals/1.json
  def update
    respond_to do |format|
      if @principal.update(principal_params)
        format.html { redirect_to @principal, notice: 'Principal was successfully updated.' }
        format.json { render :show, status: :ok, location: @principal }
      else
        format.html { render :edit }
        format.json { render json: @principal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /principals/1
  # DELETE /principals/1.json
  def destroy
    @principal.destroy
    respond_to do |format|
      format.html { redirect_to principals_url, notice: 'Principal was successfully destroyed.' }
      format.json { head :no_content }
    end
    ActionCable.server.broadcast "call_log_channel",{calllogs: CallLog.all.size, user: User.all.size, reports: MnpsReport.all.size,schools: School.all.size, principals: Principal.all.size, searches: Search.all.size, students:Student.all.size, timesheets: TimeClock.all.size}
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_principal
      @principal = Principal.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def principal_params
      params.require(:principal).permit(:ccontactfirst, :ccontactlast, :ccontacttitle, :schoolsystem, :mailaddress, :csz, :phonenumb, :email, :textcontactfirst, :textcontactlast, :textcontactemail, :mone, :mtwo, :completedbyfirst, :completedbylast, :completedbytitle, :schooltype, :peds, :census, :ptgs, :sonicpartner, :titlei, :appalachain, :districtnumb, :nab, :nab_content_type, :nab_filename, :nab_contents, :snl, :snl_content_type, :snl_filename, :snl_contents, :city, :zip, :d1, :d2, :d3, :c1, :c2, :c3, :nice, :nice_name, :nice_contents, :nice_type, :de1, :de2, :de3)
    end
end
