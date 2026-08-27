module Admin
  class CertificationsController < BaseController
    before_action :set_certification, only: %i[ show edit update destroy ]

    def index
      @certifications = Certification.ordered
    end

    def show; end
    def new; @certification = Certification.new; end
    def edit; end

    def create
      @certification = Certification.new(certification_params)
      if @certification.save
        redirect_to admin_certification_path(@certification), notice: "Certification was successfully created.", status: :see_other
      else
        render :new, status: :unprocessable_content
      end
    end

    def update
      if @certification.update(certification_params)
        redirect_to admin_certification_path(@certification), notice: "Certification was successfully updated.", status: :see_other
      else
        render :edit, status: :unprocessable_content
      end
    end

    def destroy
      @certification.destroy!
      redirect_to admin_certifications_path, notice: "Certification was successfully destroyed.", status: :see_other
    end

    private

    def set_certification
      @certification = Certification.find(params.expect(:id))
    end

    def certification_params
      params.fetch(:certification, {}).permit(:name, :issuer, :position)
    end
  end
end
