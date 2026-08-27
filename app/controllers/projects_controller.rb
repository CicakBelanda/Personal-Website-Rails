class ProjectsController < ApplicationController
  def show
    @project = Project.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: "Project not found."
  end
end
