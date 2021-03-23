# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_03_23_002824) do

  create_table "characters", force: :cascade do |t|
    t.string "name"
    t.string "thumbnail"
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "uuid"
  end

  create_table "characters_comics", id: false, force: :cascade do |t|
    t.integer "character_id", null: false
    t.integer "comic_id", null: false
    t.index ["character_id", "comic_id"], name: "index_characters_comics_on_character_id_and_comic_id"
    t.index ["comic_id", "character_id"], name: "index_characters_comics_on_comic_id_and_character_id"
  end

  create_table "comics", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.string "variantDescription"
    t.integer "pageCount"
    t.string "cover"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
