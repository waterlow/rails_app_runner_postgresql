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

ActiveRecord::Schema[7.0].define(version: 2023_01_14_041213) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "posts", force: :cascade do |t|
    t.string "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "original_email", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "remember_digest"
    t.index ["email"], name: "email_unique", unique: true
    t.check_constraint "char_length(email::text) <= 255", name: "email_length"
    t.check_constraint "char_length(name::text) <= 50", name: "name_length"
    t.check_constraint "email::text = lower(email::text)", name: "email_lower"
    t.check_constraint "email::text ~* '^[a-z_0-9+-.]+@[.a-z0-9-]+[.]{1}[a-z]+$'::text", name: "email_format"
    t.check_constraint "lower(email::text) = lower(original_email::text)", name: "email_and_original_email_allow_case_difference"
    t.check_constraint "name::text !~ '^ *$'::text", name: "name_present"
    t.check_constraint "password_digest::text !~ '^ *$'::text", name: "password_digest_present"
  end

end
