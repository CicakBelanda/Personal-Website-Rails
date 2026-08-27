module Admin
  class ExperiencesController < BaseController
    before_action :set_experience, only: %i[ show edit update destroy ]

    def index
      @experiences = Experience.ordered
    end

    def show; end
    def new; @experience = Experience.new; end
    def edit; end

    def create
      @experience = Experience.new(experience_params)
      if @experience.save
        redirect_to admin_experience_path(@experience), notice: "Experience was successfully created.", status: :see_other
      else
        render :new, status: :unprocessable_content
      end
    end

    def update
      if @experience.update(experience_params)
        redirect_to admin_experience_path(@experience), notice: "Experience was successfully updated.", status: :see_other
      else
        render :edit, status: :unprocessable_content
      end
    end

    def destroy
      @experience.destroy!
      redirect_to admin_experiences_path, notice: "Experience was successfully destroyed.", status: :see_other
    end

    private

    def set_experience
      @experience = Experience.find(params.expect(:id))
    end

    def experience_params
      params.fetch(:experience, {}).permit(
        :title, :organization, :start_date, :end_date, :current, :position, highlights: []
      )
    end
  end
end
