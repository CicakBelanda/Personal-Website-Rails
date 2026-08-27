class AddPortfolioFieldsToProjects < ActiveRecord::Migration[8.1]
  def change
    add_column :projects, :short_description, :text
    add_column :projects, :location, :string
    add_column :projects, :key_features, :text
    add_column :projects, :gallery_images, :text
    add_column :projects, :status, :string
    add_column :projects, :client, :string
    add_column :projects, :metrics, :text
  end
end
