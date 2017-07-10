class HomeController < ApplicationController
	before_action :authenticate_user!

  def statistics
    unless current_user.administrator? || current_user.developer?
      redirect_to root_path
    end
    @prevtutored = 0
    @hourstutored = 0
    @calllogs = CallLog.all
    @sessions = @calllogs.where.not(duration: nil).created_between(28.days.ago, Date.today)
    @prevsessions = @calllogs.where.not(duration: nil).created_between(56.days.ago, 28.days.ago)
    @sessions.each do |session|
      @hourstutored += session.duration.to_d.round(2)
    end
    @prevsessions.each do |prev|
      @prevtutored += prev.duration.to_d.round(2)
    end
    @students = @sessions.distinct.pluck(:codename).count
    @prevstudents = @prevsessions.distinct.pluck(:codename).count
  end

  def timesheets
    unless current_user.administrator?
      redirect_to root_path
    end
    @users = User.all
  end

  def index
    @users = User.all
    unless current_user.administrator? || current_user.developer?
      redirect_to time_clocks_path
    end
    if current_user.developer?
      @calllogs = CallLog.all
    @activecalls = @calllogs.where(endtime: nil).count
    @onlineusers = @users.joins(:time_clocks).where(time_clocks: {clock_out: nil}).count
  end
    @search = Search.new
    @mnps_report = MnpsReport.new
    if current_user.administrator? && current_user.district != "null"
      @user = User.where(id: current_user.district).first
      @user.role = 6
      @user.token = "5h43bf3ff2azce43"
      @user.district = "null"
      @user.save!
      current_user.district  = "null"
      current_user.save!
    end
  end
end
