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

ActiveRecord::Schema.define(version: 20170626180833) do

  create_table "call_logs", force: :cascade do |t|
    t.string   "entered_by"
    t.date     "date"
    t.time     "starttime"
    t.time     "endtime"
    t.integer  "user_id"
    t.boolean  "math"
    t.boolean  "worksheet"
    t.boolean  "stoodle"
    t.boolean  "image_share"
    t.string   "textbook"
    t.integer  "page"
    t.string   "chaptitle"
    t.string   "notes"
    t.string   "skill"
    t.integer  "startknow"
    t.integer  "endknow"
    t.string   "codename"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "student_id"
    t.boolean  "parent"
    t.string   "lang"
    t.string   "duration"
    t.integer  "timesdialed"
    t.boolean  "posttest"
    t.boolean  "textbool"
  end

  create_table "image_shares", force: :cascade do |t|
    t.string   "image_name"
    t.string   "image_type"
    t.binary   "image_content"
    t.string   "codename"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "mnps_reports", force: :cascade do |t|
    t.decimal  "hours",      precision: 8, scale: 3
    t.date     "billdate"
    t.integer  "user_id"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.integer  "var"
  end

  create_table "principals", force: :cascade do |t|
    t.string   "ccontactfirst"
    t.string   "ccontactlast"
    t.string   "ccontacttitle"
    t.string   "schoolsystem"
    t.string   "mailaddress"
    t.string   "csz"
    t.string   "phonenumb"
    t.string   "email"
    t.string   "textcontactfirst"
    t.string   "textcontactlast"
    t.string   "textcontactemail"
    t.date     "meetone"
    t.date     "meettwo"
    t.string   "completedbyfirst"
    t.string   "completedbylast"
    t.string   "completedbytitle"
    t.string   "schooltype"
    t.integer  "peds"
    t.integer  "census"
    t.integer  "ptgs"
    t.boolean  "sonicpartner"
    t.boolean  "titlei"
    t.boolean  "appalachain"
    t.integer  "districtnumb"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "nab_filename"
    t.string   "nab_content_type"
    t.binary   "nab_contents"
    t.string   "snl_filename"
    t.string   "snl_content_type"
    t.binary   "snl_contents"
    t.string   "schoolname"
    t.string   "city"
    t.integer  "zip"
    t.string   "d1"
    t.string   "d2"
    t.string   "d3"
    t.boolean  "c1"
    t.boolean  "c2"
    t.boolean  "c3"
    t.string   "nice_name"
    t.string   "nice_type"
    t.binary   "nice_content"
    t.datetime "mone"
    t.datetime "mtwo"
    t.string   "de1"
    t.string   "de2"
    t.string   "de3"
  end

  create_table "schools", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.integer  "zip"
    t.string   "county"
    t.string   "phone"
    t.string   "principal"
    t.string   "principalemail"
    t.boolean  "sonic"
    t.integer  "peds"
    t.integer  "census"
    t.integer  "ptgs"
    t.boolean  "appalreg"
    t.boolean  "titlei"
    t.integer  "sbdistrict"
    t.integer  "ccdistrict"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "schooltype"
  end

  create_table "searches", force: :cascade do |t|
    t.string   "model"
    t.string   "select"
    t.string   "search"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "students", force: :cascade do |t|
    t.integer  "grade"
    t.string   "codename"
    t.string   "homelang"
    t.boolean  "internet"
    t.integer  "school_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "time_clocks", force: :cascade do |t|
    t.time     "clock_in"
    t.time     "clock_out"
    t.date     "date"
    t.decimal  "hours",          precision: 8, scale: 3
    t.integer  "user_id"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.boolean  "billed"
    t.string   "activity"
    t.integer  "mnps_report_id"
    t.index ["user_id"], name: "index_time_clocks_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "firstname"
    t.string   "lastname"
    t.string   "username"
    t.string   "token"
    t.integer  "role"
    t.string   "district"
    t.integer  "men"
    t.string   "school"
    t.string   "program"
    t.integer  "locationcode"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
