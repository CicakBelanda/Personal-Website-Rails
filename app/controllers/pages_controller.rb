class PagesController < ApplicationController
  def home
    @projects = Project.ordered
    @featured_projects = Project.featured.limit(3)
  end
end