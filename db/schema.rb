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

ActiveRecord::Schema[8.1].define(version: 2026_08_27_000001) do
  create_table "projects", force: :cascade do |t|
    t.string "category", null: false
    t.string "category_label"
    t.string "cover_image"
    t.datetime "created_at", null: false
    t.string "demo_url"
    t.text "description", null: false
    t.boolean "featured", default: false
    t.string "github_url"
    t.integer "position", default: 0
    t.text "problem"
    t.string "project_date"
    t.string "role"
    t.text "solution"
    t.text "tech_details"
    t.text "tech_stack"
    t.string "title", null: false
    t.datetime "updated_at", null: false
    t.index ["category"], name: "index_projects_on_category"
    t.index ["featured"], name: "index_projects_on_featured"
    t.index ["position"], name: "index_projects_on_position"
  end
end
