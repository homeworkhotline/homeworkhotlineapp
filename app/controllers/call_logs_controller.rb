class CallLogsController < ApplicationController
  before_action :set_call_log, only: [:show, :edit, :update, :destroy]

  # GET /call_logs
  # GET /call_logs.json
  def index
    @call_logs = CallLog.all
  end

  # GET /call_logs/1
  # GET /call_logs/1.json
  def show
  end

  # GET /call_logs/new
  def new
    @call_log = CallLog.new
  end

  # GET /call_logs/1/edit
  def edit
    @call_log = CallLog.find(params[:id])
    @students = Student.all
    @schools = School.all
    @student = @call_log.student
    @school = School.find_by_id(@student.school_id)
  end

  # POST /call_logs
  # POST /call_logs.json
  def create
    @call_log = CallLog.new(call_log_params)
    @students = Student.all
    @schools = School.all
    @call_log.codename = @call_log.codename.upcase
    unless Student.exists?(codename: @call_log.codename)
    @student = Student.new(codename: @call_log.codename)
    @student.save!
  end
        @students.where(codename: @call_log.codename.upcase).each do |student|
      @call_log.student_id = student.id
      @call_log.save!
    end
    respond_to do |format|
      if @call_log.save
        if Student.where(codename: @call_log.codename).last.school_id.nil?
        format.html { redirect_to edit_student_path(@call_log.student_id), notice: 'Please create a student' }
        else
        format.html { redirect_to edit_call_log_path(@call_log), notice: 'Call log was successfully created.' }
      end
        format.json { render :show, status: :created, location: @call_log }
      else
        format.html { render :new }
        format.json { render json: @call_log.errors, status: :unprocessable_entity }
      end
    @call_log.entered_by = "#{@call_log.user.firstname} #{@call_log.user.lastname}"
    @call_log.save!
    end
    @call_log.starttime = DateTime.now.strftime("%k:%M:%S")
    @call_log.save!
    ActionCable.server.broadcast "active_log_channel",{activelogs: CallLog.all.where(endtime: nil).count}
    ActionCable.server.broadcast "call_log_channel",{calllogs: CallLog.all.size, user: User.all.size, reports: MnpsReport.all.size,schools: School.all.size, principals: Principal.all.size, searches: Search.all.size, students:Student.all.size, timesheets: TimeClock.all.size, images: ImageShare.all.size}
  end

  # PATCH/PUT /call_logs/1
  # PATCH/PUT /call_logs/1.json
  def update
    @student = @call_log.student
    respond_to do |format|
      if @call_log.update(call_log_params)
        format.html { redirect_to root_path, notice: 'Call log was successfully updated.' }
        format.json { render :show, status: :ok, location: @call_log }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @call_log.errors, status: :unprocessable_entity }
      end
    end
      @call_log.endtime = DateTime.now.strftime("%k:%M:%S")
      @call_log.save!
      @call_log.duration = time_diff(@call_log.starttime, @call_log.endtime).to_d
      @call_log.save!
  ActionCable.server.broadcast "stats_channel", {
    sessions: CallLog.where.not(duration: nil).where('date BETWEEN ? AND ?', 28.days.ago.beginning_of_day, Date.today.end_of_day).size,
    prevsessions: CallLog.where.not(duration: nil).where('date BETWEEN ? AND ?', 56.days.ago.beginning_of_day, 28.days.ago.end_of_day).size,
    sessiongraph: CallLog.where.not(duration: nil).where('date BETWEEN ? AND ?', 28.days.ago.beginning_of_day, Date.today.end_of_day)
  }
  ActionCable.server.broadcast "active_log_channel",{activelogs: CallLog.all.where(endtime: nil).count}
  end

  # DELETE /call_logs/1
  # DELETE /call_logs/1.json
  def destroy
    @call_log.destroy
    respond_to do |format|
      format.html { redirect_to call_logs_url, notice: 'Call log was successfully destroyed.' }
      format.json { head :no_content }
    end
    ActionCable.server.broadcast "call_log_channel",{calllogs: CallLog.all.size, user: User.all.size, reports: MnpsReport.all.size,schools: School.all.size, principals: Principal.all.size, searches: Search.all.size, students:Student.all.size, timesheets: TimeClock.all.size}
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_call_log
      @call_log = CallLog.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def call_log_params
      params.require(:call_log).permit(:entered_by, :date, :starttime, :endtime, :user_id, :math, :worksheet, :stoodle, :image_share, :textbook, :page, :chaptitle, :notes, :skill, :startknow, :endknow, :codename, :student_id, :parent, :lang, :duration, :teacher_name, :prize_sent, :prize_type, :name, :skillsassessed, :referral_prize, :prize_given)
    end
end
