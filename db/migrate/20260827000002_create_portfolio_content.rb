class CreatePortfolioContent < ActiveRecord::Migration[8.1]
  def change
    create_table :experiences do |t|
      t.string :title, null: false
      t.string :organization, null: false
      t.string :start_date
      t.string :end_date
      t.boolean :current, default: false
      t.text :highlights
      t.integer :position, default: 0
      t.timestamps
    end

    create_table :educations do |t|
      t.string :school, null: false
      t.string :degree, null: false
      t.string :location
      t.string :start_date
      t.string :end_date
      t.string :expected_graduation
      t.string :gpa
      t.integer :position, default: 0
      t.timestamps
    end

    create_table :publications do |t|
      t.string :title, null: false
      t.string :publisher
      t.string :publication_date
      t.text :description
      t.text :methods
      t.string :doi_url
      t.integer :position, default: 0
      t.timestamps
    end

    create_table :leadership_experiences do |t|
      t.string :role, null: false
      t.string :organization
      t.text :highlights
      t.integer :position, default: 0
      t.timestamps
    end

    create_table :certifications do |t|
      t.string :name, null: false
      t.string :issuer
      t.integer :position, default: 0
      t.timestamps
    end

    create_table :awards do |t|
      t.string :name, null: false
      t.string :issuer
      t.string :year
      t.integer :position, default: 0
      t.timestamps
    end
  end
end
