class StudentsController < ApplicationController
	def edit
    @student = Student.find(params[:id])
    @schools = School.all
	end

	def update
		@student = Student.find(params[:id])
    @call_log = CallLog.where(student_id: @student.id).last
    respond_to do |format|
      if @student.update(student_params)
        format.html { redirect_to edit_call_log_path(@call_log), notice: 'Student was successfully updated.' }
        format.json { render :show, status: :ok, location: @student }
      else
        format.html { render :edit }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end
	  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def student_params
      params.require(:student).permit(:grade, :codename, :internet, :homelang, :school_id)
    end
end