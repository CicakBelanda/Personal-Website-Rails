class CreateProjects < ActiveRecord::Migration[8.1]
  def change
    create_table :projects do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.string :category, null: false
      t.text :tech_stack
      t.string :github_url
      t.string :demo_url
      t.string :cover_image
      t.boolean :featured, default: false
      t.integer :position, default: 0

      t.timestamps
    end
    
    add_index :projects, :category
    add_index :projects, :featured
    add_index :projects, :position
  end
end