module Admin
  class LeadershipExperiencesController < BaseController
    before_action :set_leadership_experience, only: %i[ show edit update destroy ]

    def index
      @leadership_experiences = LeadershipExperience.ordered
    end

    def show; end
    def new; @leadership_experience = LeadershipExperience.new; end
    def edit; end

    def create
      @leadership_experience = LeadershipExperience.new(leadership_experience_params)
      if @leadership_experience.save
        redirect_to admin_leadership_experience_path(@leadership_experience), notice: "Leadership experience was successfully created.", status: :see_other
      else
        render :new, status: :unprocessable_content
      end
    end

    def update
      if @leadership_experience.update(leadership_experience_params)
        redirect_to admin_leadership_experience_path(@leadership_experience), notice: "Leadership experience was successfully updated.", status: :see_other
      else
        render :edit, status: :unprocessable_content
      end
    end

    def destroy
      @leadership_experience.destroy!
      redirect_to admin_leadership_experiences_path, notice: "Leadership experience was successfully destroyed.", status: :see_other
    end

    private

    def set_leadership_experience
      @leadership_experience = LeadershipExperience.find(params.expect(:id))
    end

    def leadership_experience_params
      params.fetch(:leadership_experience, {}).permit(
        :role, :organization, :position, highlights: []
      )
    end
  end
end
