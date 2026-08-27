module Admin
  class EducationsController < BaseController
    before_action :set_education, only: %i[ show edit update destroy ]

    def index
      @educations = Education.ordered
    end

    def show; end
    def new; @education = Education.new; end
    def edit; end

    def create
      @education = Education.new(education_params)
      if @education.save
        redirect_to admin_education_path(@education), notice: "Education was successfully created.", status: :see_other
      else
        render :new, status: :unprocessable_content
      end
    end

    def update
      if @education.update(education_params)
        redirect_to admin_education_path(@education), notice: "Education was successfully updated.", status: :see_other
      else
        render :edit, status: :unprocessable_content
      end
    end

    def destroy
      @education.destroy!
      redirect_to admin_educations_path, notice: "Education was successfully destroyed.", status: :see_other
    end

    private

    def set_education
      @education = Education.find(params.expect(:id))
    end

    def education_params
      params.fetch(:education, {}).permit(
        :school, :degree, :location, :start_date, :end_date,
        :expected_graduation, :gpa, :position
      )
    end
  end
end
