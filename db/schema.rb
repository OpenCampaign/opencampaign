# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20151108195644) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "basic_auths", force: :cascade do |t|
    t.string  "email",           null: false
    t.string  "password_digest"
    t.string  "username"
    t.integer "identity_id"
    t.string  "token"
    t.boolean "verified"
    t.boolean "password_reset"
  end

  add_index "basic_auths", ["email"], name: "index_basic_auths_on_email", unique: true, using: :btree
  add_index "basic_auths", ["identity_id"], name: "index_basic_auths_on_identity_id", using: :btree
  add_index "basic_auths", ["username"], name: "index_basic_auths_on_username", using: :btree

  create_table "feedbacks", force: :cascade do |t|
    t.string "subject",       null: false
    t.string "first_name",    null: false
    t.string "last_name",     null: false
    t.string "email_address", null: false
    t.string "phone_number"
    t.string "address"
    t.text   "comment",       null: false
  end

  create_table "identities", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.string   "username"
    t.string   "affiliation"
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.string   "phone_secondary"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "identities", ["provider", "uid"], name: "index_identities_on_provider_and_uid", using: :btree
  add_index "identities", ["user_id", "updated_at"], name: "index_identities_on_user_id_and_updated_at", using: :btree
  add_index "identities", ["user_id"], name: "index_identities_on_user_id", using: :btree

  create_table "issues", force: :cascade do |t|
    t.string   "title",      null: false
    t.string   "opinion",    null: false
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "md_pages", force: :cascade do |t|
    t.string   "title",      null: false
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "sessions", force: :cascade do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

  create_table "socials", force: :cascade do |t|
    t.string   "name"
    t.json     "payload"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree

  create_table "tags", force: :cascade do |t|
    t.string "name"
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree

  create_table "volunteer_registrations", force: :cascade do |t|
    t.integer "user_id"
    t.text    "interests",         null: false
    t.text    "volunteer_profile", null: false
    t.string  "employer"
    t.string  "job_title"
  end

  add_index "volunteer_registrations", ["user_id"], name: "index_volunteer_registrations_on_user_id", using: :btree

end
