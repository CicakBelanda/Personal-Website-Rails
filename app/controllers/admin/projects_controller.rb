module Admin
  class ProjectsController < BaseController
    before_action :set_project, only: %i[ show edit update destroy ]

    def index
      @projects = Project.ordered
    end

    def show; end

    def new
      @project = Project.new
    end

    def edit; end

    def create
      @project = Project.new(project_params)
      @project.metrics = parse_metrics(params[:project][:metrics])
      if @project.save
        redirect_to admin_project_path(@project), notice: "Project was successfully created.", status: :see_other
      else
        render :new, status: :unprocessable_content
      end
    end

    def update
      if @project.update(project_params)
        @project.update(metrics: parse_metrics(params[:project][:metrics]))
        redirect_to admin_project_path(@project), notice: "Project was successfully updated.", status: :see_other
      else
        render :edit, status: :unprocessable_content
      end
    end

    def destroy
      @project.destroy!
      redirect_to admin_projects_path, notice: "Project was successfully destroyed.", status: :see_other
    end

    private

    def set_project
      @project = Project.find(params.expect(:id))
    end

    def project_params
      params.fetch(:project, {}).permit(
        :title, :short_description, :description, :category, :category_label,
        :role, :location, :client, :status, :problem, :solution, :tech_details,
        :project_date, :demo_url, :github_url, :cover_image, :featured, :position,
        tech_stack: [], key_features: [], gallery_images: []
      )
    end

    # Form format: "value|label" per line -> JSON array of { value:, label: }
    def parse_metrics(raw)
      return nil if raw.nil? || raw.to_s.strip.empty?
      raw.to_s.split(/\r?\n/).map(&:strip).reject(&:empty?).map do |line|
        value, label = line.split("|", 2)
        { value: value.to_s.strip, label: label.to_s.strip }
      end
    end
  end
end
