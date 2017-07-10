class MnpsReportsController < ApplicationController
  before_action :set_mnps_report, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /mnps_reports
  # GET /mnps_reports.json
  def index
    @mnps_reports = MnpsReport.all
  end

  # GET /mnps_reports/1
  # GET /mnps_reports/1.json
  def show
    @user = @mnps_report.user
    @timeclocks = @mnps_report.time_clocks
    @thisyear = Date.today.strftime("%Y").to_i
    @yearwork = @timeclocks.find_by_date(@thisyear)
    @totalhours = 0 
    @user.mnps_reports.each do |report|
      @totalhours += report.hours
    end
    @prevbill = @totalhours - @mnps_report.hours
    render :layout => 'report'

  end

  def all_reports
    @mnps_report = MnpsReport.find(params[:id])
    @mnps_reports = MnpsReport.where(var: @mnps_report.id, billdate: @mnps_report.billdate).joins(:user).where.not(users: {role: :admin})
    @thisyear = Date.today.strftime("%Y").to_i
    @totalhours = 0
    render :layout => 'report'
  end


  # GET /mnps_reports/new
  def new
    @mnps_report = MnpsReport.new
  end

  # GET /mnps_reports/1/edit
  def edit
  end

  # POST /mnps_reports
  # POST /mnps_reports.json
  def create
    @mnps_report = MnpsReport.new(mnps_report_params)
    @user = @mnps_report.user
    respond_to do |format|
      if @mnps_report.save && !@user.administrator?
        @user.time_clocks.where(billed: false).each do |time|
          time.mnps_report_id = @mnps_report.id
          time.billed = true
          time.save!
        end
        format.html { redirect_to mnps_report_path(@mnps_report, format: 'pdf'), notice: 'Mnps report was successfully created.' }
        format.json { render :show, status: :created, location: @mnps_report }
      elsif @mnps_report.save && @user.administrator?
          @users = User.all
          @unpaid_hours = 0
          @users.each do |user|
      user.time_clocks.where(billed: false).each do |time|
        @unpaid_hours += time.hours
      end
      MnpsReport.create(user_id: user.id, billdate: Date.today, var: @mnps_report.id, hours: @unpaid_hours)
        user.time_clocks.where(billed: false).each do |time|
          time.mnps_report_id = user.mnps_reports.last.id
          time.billed = true
          time.save!
        end
    end
        format.html { redirect_to all_mnps_reports_path(@mnps_report, format: 'pdf'), notice: 'Mnps report was successfully created.' }
        format.json { render :show, status: :created, location: @mnps_report }
      else
        format.html { render :new }
        format.json { render json: @mnps_report.errors, status: :unprocessable_entity }
      end
    end
    ActionCable.server.broadcast "call_log_channel",{calllogs: CallLog.all.size, user: User.all.size, reports: MnpsReport.all.size,schools: School.all.size, principals: Principal.all.size, searches: Search.all.size, students:Student.all.size, timesheets: TimeClock.all.size}
  end

  # PATCH/PUT /mnps_reports/1
  # PATCH/PUT /mnps_reports/1.json
  def update
    respond_to do |format|
      if @mnps_report.update(mnps_report_params)
        format.html { redirect_to @mnps_report, notice: 'Mnps report was successfully updated.' }
        format.json { render :show, status: :ok, location: @mnps_report }
      else
        format.html { render :edit }
        format.json { render json: @mnps_report.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mnps_reports/1
  # DELETE /mnps_reports/1.json
  def destroy
    @mnps_report.destroy
    respond_to do |format|
      format.html { redirect_to mnps_reports_url, notice: 'Mnps report was successfully destroyed.' }
      format.json { head :no_content }
    end
    ActionCable.server.broadcast "call_log_channel",{calllogs: CallLog.all.size, user: User.all.size, reports: MnpsReport.all.size,schools: School.all.size, principals: Principal.all.size, searches: Search.all.size, students:Student.all.size, timesheets: TimeClock.all.size}
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mnps_report
      @mnps_report = MnpsReport.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mnps_report_params
      params.require(:mnps_report).permit(:hours, :billdate, :user_id, :var)
    end
end
