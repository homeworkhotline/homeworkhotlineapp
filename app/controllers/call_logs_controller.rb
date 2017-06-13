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
  end

  # POST /call_logs
  # POST /call_logs.json
  def create
    @call_log = CallLog.new(call_log_params)
    @students = Student.all
    @schools = School.all
    respond_to do |format|
      if @call_log.save
        format.html { redirect_to edit_call_log_path(@call_log), notice: 'Call log was successfully created.' }
        format.json { render :show, status: :created, location: @call_log }
        format.js
      else
        format.html { render :new }
        format.json { render json: @call_log.errors, status: :unprocessable_entity }
      end
    end
    unless Student.exists?(codename: @call_log.codename)
    @student = Student.new(codename: @call_log.codename)
    @student.save!
  end
    @students.where(codename: @call_log.codename).each do |student|
      @call_log.student_id = student.id
      @call_log.save!
    end
    @call_log.entered_by = "#{@call_log.user.firstname} #{@call_log.user.lastname}"
    @call_log.save!
  end

  # PATCH/PUT /call_logs/1
  # PATCH/PUT /call_logs/1.json
  def update
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
      @call_log.endtime = Time.now - 5.hours
      @call_log.save!
  end

  # DELETE /call_logs/1
  # DELETE /call_logs/1.json
  def destroy
    @call_log.destroy
    respond_to do |format|
      format.html { redirect_to call_logs_url, notice: 'Call log was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_call_log
      @call_log = CallLog.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def call_log_params
      params.require(:call_log).permit(:entered_by, :date, :starttime, :endtime, :user_id, :math, :worksheet, :stoodle, :image_share, :textbook, :page, :chaptitle, :notes, :skill, :startknow, :endknow, :codename, :student_id)
    end
end
