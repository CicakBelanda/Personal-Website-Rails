module Admin
  class AwardsController < BaseController
    before_action :set_award, only: %i[ show edit update destroy ]

    def index
      @awards = Award.ordered
    end

    def show; end
    def new; @award = Award.new; end
    def edit; end

    def create
      @award = Award.new(award_params)
      if @award.save
        redirect_to admin_award_path(@award), notice: "Award was successfully created.", status: :see_other
      else
        render :new, status: :unprocessable_content
      end
    end

    def update
      if @award.update(award_params)
        redirect_to admin_award_path(@award), notice: "Award was successfully updated.", status: :see_other
      else
        render :edit, status: :unprocessable_content
      end
    end

    def destroy
      @award.destroy!
      redirect_to admin_awards_path, notice: "Award was successfully destroyed.", status: :see_other
    end

    private

    def set_award
      @award = Award.find(params.expect(:id))
    end

    def award_params
      params.fetch(:award, {}).permit(:name, :issuer, :year, :position)
    end
  end
end
