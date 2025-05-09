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

ActiveRecord::Schema[8.0].define(version: 2025_03_27_163826) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "albedos", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_session_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_session_id"], name: "index_albedos_on_user_session_id"
  end

  create_table "exports", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_session_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_session_id"], name: "index_exports_on_user_session_id"
  end

  create_table "gradient_noise_layers", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.string "blend_mode", null: false
    t.decimal "opacity", precision: 3, scale: 2, default: "1.0", null: false
    t.integer "octaves", default: 16, null: false
    t.integer "seed", default: 1234, null: false
    t.integer "offset_x", default: 0, null: false
    t.integer "offset_y", default: 0, null: false
    t.decimal "scale_height", precision: 4, scale: 4, default: "0.3", null: false
    t.decimal "scale_width", precision: 4, scale: 4, default: "0.3", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "layers", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_session_id", null: false
    t.string "layerable_type", null: false
    t.uuid "layerable_id", null: false
    t.integer "position", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["layerable_type", "layerable_id"], name: "index_layers_on_layerable"
    t.index ["user_session_id", "position"], name: "index_layers_on_user_session_id_and_position", unique: true
    t.index ["user_session_id"], name: "index_layers_on_user_session_id"
  end

  create_table "user_sessions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "waters", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_session_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_session_id"], name: "index_waters_on_user_session_id"
  end

  create_table "weatherings", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_session_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_session_id"], name: "index_weatherings_on_user_session_id"
  end

  add_foreign_key "albedos", "user_sessions"
  add_foreign_key "exports", "user_sessions"
  add_foreign_key "layers", "user_sessions"
  add_foreign_key "waters", "user_sessions"
  add_foreign_key "weatherings", "user_sessions"
end
