class SearchesController < ApplicationController
  before_action :set_search, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /searches
  # GET /searches.json
  def index
    @searches = Search.all
  end

  # GET /searches/1
  # GET /searches/1.json
  def show
    @principals = Principal.all
    @reports = MnpsReport.all
    @search = Search.find(params[:id])
    @model = @search.model.constantize
    @param = @search.select
      @results = @model.where("#{@param}": @search.search)
    if @param.include?("titlei") || @search.select.include?("sonicpartner") || @search.select.include?("appalachain")
    @results = @model.where("#{@param}": @search.search.to_b)
    elsif @param.instance_of?(String) && @search.model != "MnpsReport"
      if @search.search.include?(">")
        @gsearch = @search.search.tr(">","")
        @results = @model.where("#{@param} > ?", @gsearch.to_i)
        if @model.find_by("#{@param} > ?", @gsearch.to_i).present?
          @search.search = @model.first.id
          @param = "id"
          @search.save!
        end
      elsif @search.search.include?("<")
        @gsearch = @search.search.tr("<","")
        @results = @model.where("#{@param} < ?", @gsearch.to_i)
        if @model.find_by("#{@param} < ?", @gsearch.to_i).present?
          @search.search = @model.first.id
          @param = "id"
          @search.save!
        end
      else
      @results = @model.where("#{@param}": @search.search)
      end
    elsif @search.model == "MnpsReport"
      @results = User.where(role: @search.search)
    end
  end

  # GET /searches/new
  def new
    @search = Search.new
  end

  # GET /searches/1/edit
  def edit
  end

  # POST /searches
  # POST /searches.json
  def create
    @search = Search.new(search_params)

    respond_to do |format|
      if @search.save
        format.html { redirect_to edit_search_path(@search), notice: 'Search was successfully created.' }
        format.json { render :show, status: :created, location: @search }
        format.js
      else
        format.html { render :new }
        format.json { render json: @search.errors, status: :unprocessable_entity }
      end
    end
    ActionCable.server.broadcast "call_log_channel",{calllogs: CallLog.all.size, user: User.all.size, reports: MnpsReport.all.size,schools: School.all.size, principals: Principal.all.size, searches: Search.all.size, students:Student.all.size, timesheets: TimeClock.all.size}
  end

  # PATCH/PUT /searches/1
  # PATCH/PUT /searches/1.json
  def update
    respond_to do |format|
      if @search.update(search_params)
        format.html { redirect_to @search, notice: 'Search Results:' }
        format.json { render :show, status: :ok, location: @search }
      else
        format.html { render :edit }
        format.json { render json: @search.errors, status: :unprocessable_entity }
      end
      if @search.select.include?("titlei") || @search.select.include?("sonicpartner")
        if @search.search.include?("yes")
          @search.search = true
          @search.save!
        else
          @search.search = false
          @search.save!
        end
      end
    end
  end

  # DELETE /searches/1
  # DELETE /searches/1.json
  def destroy
    @search.destroy
    respond_to do |format|
      format.html { redirect_to searches_url, notice: 'Search was successfully destroyed.' }
      format.json { head :no_content }
    end
    ActionCable.server.broadcast "call_log_channel",{calllogs: CallLog.all.size, user: User.all.size, reports: MnpsReport.all.size,schools: School.all.size, principals: Principal.all.size, searches: Search.all.size, students:Student.all.size, timesheets: TimeClock.all.size}
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_search
      @search = Search.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def search_params
      params.require(:search).permit(:model, :select, :search)
    end
end
