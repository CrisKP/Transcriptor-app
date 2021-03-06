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

ActiveRecord::Schema.define(version: 20180130221552) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "audio_files", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "audio_file_name"
    t.string "audio_content_type"
    t.integer "audio_file_size"
    t.datetime "audio_updated_at"
    t.string "title"
    t.string "email"
    t.binary "transcription"
    t.datetime "transcription_completed_at"
    t.decimal "confidence", precision: 15, scale: 13
    t.datetime "transcription_started_at"
  end

end
