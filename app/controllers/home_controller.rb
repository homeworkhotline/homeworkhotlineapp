class HomeController < ApplicationController
	before_action :authenticate_user!, except: [:sessioninfo]

  def statistics
    unless current_user.administrator? || current_user.specialist?
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
    @activecalls = @calllogs.where(endtime: nil).count
    @onlineusers = @users.joins(:time_clocks).where(time_clocks: {clock_out: nil}).count
  end
    end
    def genschools
      sql = (['INSERT INTO "schools" ("name", "address", "city", "state", "zip", "county", "phone", "principal", "principalemail",
                       "sonic", "peds", "census", "ptgs", "appalreg", "titlei", "sbdistrict", "ccdistrict", "created_at",
                   "updated_at") VALUES ("Trousdale County Elementary School","115 Lock Six Road ","Hartsville","TN",37074,"Test","615-374-3752","Demetrice Badru","demetricebadru@tcschools.org",0,79,600,90,0,0,1,1,"2017-07-13 10:42:35","2017-07-13 10:42:35")',
'INSERT INTO "schools" ("name", "address", "city", "state", "zip", "county", "phone", "principal", "principalemail",
                       "sonic", "peds", "census", "ptgs", "appalreg", "titlei", "sbdistrict", "ccdistrict", "created_at",
                   "updated_at") VALUES ("Jim Satterfield Middles School","110 Damascus Street","Hartsville","TN",37074,"Test","615-374-2748","JBrim McCall","jmccall@tcschools.org ",0,46,300,0,0,0,1,1,"2017-07-13 10:42:35","2017-07-13 10:42:35")',
'INSERT INTO "schools" ("name", "address", "city", "state", "zip", "county", "phone", "principal", "principalemail",
                       "sonic", "peds", "census", "ptgs", "appalreg", "titlei", "sbdistrict", "ccdistrict", "created_at",
                   "updated_at") VALUES ("Trousdale County High School","262 W McMurry Blvd","Hartsville","TN",37074,"Test","615-374-2201","Teresa Dickerson","teresadickerson@tcschools.org",0,46,400,0,0,0,1,1,"2017-07-13 10:42:35","2017-07-13 10:42:35")'])
      sql.each do |osql|
        ActiveRecord::Base.connection.execute(osql.to_s)
      end
      ActionCable.server.broadcast "call_log_channel",{calllogs: CallLog.all.size, user: User.all.size, reports: MnpsReport.all.size,schools: School.all.size, principals: Principal.all.size, searches: Search.all.size, students:Student.all.size, timesheets: TimeClock.all.size}
    end
  end
