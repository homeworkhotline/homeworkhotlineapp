class TimeClocksController < ApplicationController
  before_action :set_time_clock, only: [ :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /time_clocks
  # GET /time_clocks.json
  def index
    @time_clocks = current_user.time_clocks
    @total_hours = 0
    @unpaid_hours = 0
    @time_clocks.each do |time|
      unless time.clock_out.nil?
        @total_hours += time.hours
      end
    end
    @time_clocks.where(billed: false).each do |time|
      unless time.hours.nil?
        @unpaid_hours += time.hours
      end
    end
  end

  # GET /time_clocks/1
  # GET /time_clocks/1.json
  def show
    @time_clock = TimeClock.find(params[:id])
  end

  # GET /time_clocks/new
  def new
    @delete = current_user.time_clocks.where(clock_out: nil)
    @delete.delete_all
    @time_clock = TimeClock.new
    render :layout => 'report'
  end

  # GET /time_clocks/1/edit
  def edit
  end

  # POST /time_clocks
  # POST /time_clocks.json
  def create
    @time_clock = TimeClock.new(time_clock_params)
    if (current_user.time_clocks.last && current_user.time_clocks.last.clock_out.nil?) &! (current_user.administrator? || current_user.specialist?)
      redirect_to root_path
    else
      if @time_clock.user_id.nil?
    @time_clock.user_id = current_user.id
    @time_clock.save!
  end
    if current_user.mnps_teacher?
      @time_clock.clock_in = round_time(DateTime.now)
      @time_clock.save!
    else
      @time_clock.clock_in = (DateTime.now)
      @time_clock.save!
  end
    if @time_clock.date != Date.today
    respond_to do |format|
      if @time_clock.save
        format.html { redirect_to edit_time_clock_path(@time_clock), notice: 'Time clock was successfully created.' }
        format.json { render :show, status: :created, location: @time_clock }
      else
        format.html { render :new }
        format.json { render json: @time_clock.errors, status: :unprocessable_entity }
      end
    end
  else
    respond_to do |format|
      if @time_clock.save
        format.html { redirect_to root_path, notice: 'Time clock was successfully created.' }
        format.json { render :show, status: :created, location: @time_clock }
      else
        format.html { render :new }
        format.json { render json: @time_clock.errors, status: :unprocessable_entity }
      end
    end
  end
  end
  @users = User.all.joins(:time_clocks).where(time_clocks: {clock_out: nil}).count
     ActionCable.server.broadcast "online_channel",{users: @users}
     ActionCable.server.broadcast "call_log_channel",{calllogs: CallLog.all.size, user: User.all.size, reports: MnpsReport.all.size,schools: School.all.size, principals: Principal.all.size, searches: Search.all.size, students:Student.all.size, timesheets: TimeClock.all.size}
  end

  # PATCH/PUT /time_clocks/1
  # PATCH/PUT /time_clocks/1.json
  def update
    @time_clock = TimeClock.find(params[:id])
    if current_user.hotline_teacher? || current_user.mnps_teacher?
      @time_clock.clock_out = round_time(DateTime.now)
      @time_clock.save!
    else
      @time_clock.clock_out = DateTime.now
      @time_clock.save!
    end
    respond_to do |format|
      if @time_clock.update(time_clock_params)
        format.html { redirect_to @time_clock.user }
        format.json { render :show, status: :ok, location: @time_clock }
    @time_clock.billed = 0
    @time_clock.save!
      else
        format.html { render :edit }
        format.json { render json: @time_clock.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /time_clocks/1
  # DELETE /time_clocks/1.json
  def destroy
    @time_clock.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Time clock was successfully destroyed.' }
      format.json { head :no_content }
    end
    ActionCable.server.broadcast "call_log_channel",{calllogs: CallLog.all.size, user: User.all.size, reports: MnpsReport.all.size,schools: School.all.size, principals: Principal.all.size, searches: Search.all.size, students:Student.all.size, timesheets: TimeClock.all.size}
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_time_clock
      @time_clock = TimeClock.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def time_clock_params
      params.require(:time_clock).permit(:clock_in, :clock_out, :date, :hours, :billed, :mnps_report_id, :user_id, :clockinhour, :clockinmin, :clockinmeridiem, :clockouthour, :clockoutmin, :clockoutmeridiem)
    end
end
