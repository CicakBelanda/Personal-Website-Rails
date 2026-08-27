# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_08_28_000001) do
  create_table "awards", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "issuer"
    t.string "name", null: false
    t.integer "position", default: 0
    t.datetime "updated_at", null: false
    t.string "year"
  end

  create_table "certifications", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "issuer"
    t.string "name", null: false
    t.integer "position", default: 0
    t.datetime "updated_at", null: false
  end

  create_table "educations", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "degree", null: false
    t.string "end_date"
    t.string "expected_graduation"
    t.string "gpa"
    t.string "location"
    t.integer "position", default: 0
    t.string "school", null: false
    t.string "start_date"
    t.datetime "updated_at", null: false
  end

  create_table "experiences", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.boolean "current", default: false
    t.string "end_date"
    t.text "highlights"
    t.string "organization", null: false
    t.integer "position", default: 0
    t.string "start_date"
    t.string "title", null: false
    t.datetime "updated_at", null: false
  end

  create_table "leadership_experiences", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "highlights"
    t.string "organization"
    t.integer "position", default: 0
    t.string "role", null: false
    t.datetime "updated_at", null: false
  end

  create_table "projects", force: :cascade do |t|
    t.string "category", null: false
    t.string "category_label"
    t.string "client"
    t.string "cover_image"
    t.datetime "created_at", null: false
    t.string "demo_url"
    t.text "description", null: false
    t.boolean "featured", default: false
    t.text "gallery_images"
    t.string "github_url"
    t.text "key_features"
    t.string "location"
    t.text "metrics"
    t.integer "position", default: 0
    t.text "problem"
    t.string "project_date"
    t.string "role"
    t.text "short_description"
    t.text "solution"
    t.string "status"
    t.text "tech_details"
    t.text "tech_stack"
    t.string "title", null: false
    t.datetime "updated_at", null: false
    t.index ["category"], name: "index_projects_on_category"
    t.index ["featured"], name: "index_projects_on_featured"
    t.index ["position"], name: "index_projects_on_position"
  end

  create_table "publications", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "description"
    t.string "doi_url"
    t.text "methods"
    t.integer "position", default: 0
    t.string "publication_date"
    t.string "publisher"
    t.string "title", null: false
    t.datetime "updated_at", null: false
  end
end
