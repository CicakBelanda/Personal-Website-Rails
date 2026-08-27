module Admin
  class PublicationsController < BaseController
    before_action :set_publication, only: %i[ show edit update destroy ]

    def index
      @publications = Publication.ordered
    end

    def show; end
    def new; @publication = Publication.new; end
    def edit; end

    def create
      @publication = Publication.new(publication_params)
      if @publication.save
        redirect_to admin_publication_path(@publication), notice: "Publication was successfully created.", status: :see_other
      else
        render :new, status: :unprocessable_content
      end
    end

    def update
      if @publication.update(publication_params)
        redirect_to admin_publication_path(@publication), notice: "Publication was successfully updated.", status: :see_other
      else
        render :edit, status: :unprocessable_content
      end
    end

    def destroy
      @publication.destroy!
      redirect_to admin_publications_path, notice: "Publication was successfully destroyed.", status: :see_other
    end

    private

    def set_publication
      @publication = Publication.find(params.expect(:id))
    end

    def publication_params
      params.fetch(:publication, {}).permit(
        :title, :publisher, :publication_date, :description, :methods, :doi_url, :position
      )
    end
  end
end
