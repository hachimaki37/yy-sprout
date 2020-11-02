# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_10_31_025637) do

  create_table "schedule_results", force: :cascade do |t|
    t.datetime "match_date_time"
    t.integer "section", null: false
    t.integer "opponent", null: false
    t.integer "match_result", default: 0
    t.integer "stadium", null: false
    t.integer "home_and_away", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
