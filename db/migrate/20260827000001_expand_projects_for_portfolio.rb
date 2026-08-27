class ExpandProjectsForPortfolio < ActiveRecord::Migration[8.1]
  def change
    add_column :projects, :role, :string
    add_column :projects, :problem, :text
    add_column :projects, :solution, :text
    add_column :projects, :tech_details, :text
    add_column :projects, :project_date, :string
    add_column :projects, :category_label, :string
  end
end
