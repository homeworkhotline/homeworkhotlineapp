class HomeController < ApplicationController
	before_action :authenticate_user!, except: [:sessioninfo]
  layout 'report', only: [:statistics]

  def statistics
    unless current_user.administrator? || current_user.specialist?
      redirect_to root_path
    end
    @sessions = 0
    @prevsessions = 0
    @images = 0
    @previmages = 0
    @stoodle = 0
    @prevstoodle = 0
    @complete = 0
    @prevcomplete = 0
    @master = 0
    @prevmaster = 0
    @sessions = CallLog.where.not(duration: nil).where('date BETWEEN ? AND ?', 28.days.ago.beginning_of_day, Date.today.end_of_day).size
    @prevsessions = CallLog.where.not(duration: nil).where('date BETWEEN ? AND ?', 56.days.ago.beginning_of_day, 28.days.ago.end_of_day).size
    @images = CallLog.where.not(duration: nil, image_share: false).where('date BETWEEN ? AND ?', 28.days.ago.beginning_of_day, Date.today.end_of_day).size
    @previmages = CallLog.where.not(duration: nil, image_share: false).where('date BETWEEN ? AND ?', 56.days.ago.beginning_of_day, 28.days.ago.end_of_day).size
    @stoodle = CallLog.where.not(duration: nil, stoodle: false).where('date BETWEEN ? AND ?', 28.days.ago.beginning_of_day, Date.today.end_of_day).size
    @prevstoodle = CallLog.where.not(duration: nil, stoodle: false).where('date BETWEEN ? AND ?', 56.days.ago.beginning_of_day, 28.days.ago.end_of_day).size
    @complete = (CallLog.where.not(duration: nil, endknow: 0).where('date BETWEEN ? AND ?', 28.days.ago.beginning_of_day, Date.today.end_of_day).size.to_d / @sessions.to_d)
    @prevcomplete = (CallLog.where.not(duration: nil, endknow: 0).where('date BETWEEN ? AND ?', 56.days.ago.beginning_of_day, 28.days.ago.end_of_day).size.to_d / @prevsessions.to_d)
    @master = (CallLog.where.not(duration: nil).where(endknow: 2).where('date BETWEEN ? AND ?', 28.days.ago.beginning_of_day, Date.today.end_of_day).size.to_d / @sessions.to_d)
    @prevmaster = (CallLog.where.not(duration: nil).where(endknow: 2).where('date BETWEEN ? AND ?', 56.days.ago.beginning_of_day, 28.days.ago.end_of_day).size.to_d / @prevsessions.to_d)
    @hours = 0
    CallLog.where.not(duration: nil).where('date BETWEEN ? AND ?', 28.days.ago.beginning_of_day, Date.today.end_of_day).each do |time|
      @hours += time.duration.to_d
    end
    @prevhours = 0
    CallLog.where.not(duration: nil).where('date BETWEEN ? AND ?', 56.days.ago.beginning_of_day,  28.days.ago.end_of_day).each do |time|
      @prevhours += time.duration.to_d
    end
    if @master.nan? then @master = 0 end
    if @prevmaster.nan? then @prevmaster = 0 end
    if @complete.nan? then @complete = 0 end
    if @prevcomplete.nan? then @prevcomplete = 0 end
  end

  def sessioninfo
    @user = User.find(params[:id])
    @time_clock = @user.time_clocks.order('updated_at').last
      render :layout => 'report'
  end

  def employees
    unless current_user.administrator?
      redirect_to root_path
    end
    @users = User.all
    @report = MnpsReport.new
  end

  def devstats
    @users = User.all
    unless current_user.specialist?
      redirect_to root_path
    end
    if current_user.specialist?
      @calllogs = CallLog.all
    @activecalls = @calllogs.where(endtime: nil).size
    @onlineusers = @users.joins(:time_clocks).where(time_clocks: {clock_out: nil}).size
  end
    end
    def genschools
      sql = (['INSERT INTO "schools" ("name", "address", "city", "state", "zip", "sizey", "phone", "principal", "principalemail",
                       "sonic", "peds", "census", "ptgs", "appalreg", "titlei", "sbdistrict", "ccdistrict", "created_at",
                   "updated_at") VALUES ("Trousdale sizey Elementary School","115 Lock Six Road ","Hartsville","TN",37074,"Test","615-374-3752","Demetrice Badru","demetricebadru@tcschools.org",0,79,600,90,0,0,1,1,"2017-07-13 10:42:35","2017-07-13 10:42:35")',
'INSERT INTO "schools" ("name", "address", "city", "state", "zip", "sizey", "phone", "principal", "principalemail",
                       "sonic", "peds", "census", "ptgs", "appalreg", "titlei", "sbdistrict", "ccdistrict", "created_at",
                   "updated_at") VALUES ("Jim Satterfield Middles School","110 Damascus Street","Hartsville","TN",37074,"Test","615-374-2748","JBrim McCall","jmccall@tcschools.org ",0,46,300,0,0,0,1,1,"2017-07-13 10:42:35","2017-07-13 10:42:35")',
'INSERT INTO "schools" ("name", "address", "city", "state", "zip", "sizey", "phone", "principal", "principalemail",
                       "sonic", "peds", "census", "ptgs", "appalreg", "titlei", "sbdistrict", "ccdistrict", "created_at",
                   "updated_at") VALUES ("Trousdale sizey High School","262 W McMurry Blvd","Hartsville","TN",37074,"Test","615-374-2201","Teresa Dickerson","teresadickerson@tcschools.org",0,46,400,0,0,0,1,1,"2017-07-13 10:42:35","2017-07-13 10:42:35")'])
      sql.each do |osql|
        ActiveRecord::Base.connection.execute(osql.to_s)
      end
      ActionCable.server.broadcast "call_log_channel",{calllogs: CallLog.all.size, user: User.all.size, reports: MnpsReport.all.size,schools: School.all.size, principals: Principal.all.size, searches: Search.all.size, students:Student.all.size, timesheets: TimeClock.all.size}
    end
  end
