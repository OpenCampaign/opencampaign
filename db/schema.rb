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

ActiveRecord::Schema.define(version: 20151108052304) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "alchemy_attachments", force: :cascade do |t|
    t.string   "name"
    t.string   "file_name"
    t.string   "file_mime_type"
    t.integer  "file_size"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.text     "cached_tag_list"
    t.string   "file_uid"
  end

  add_index "alchemy_attachments", ["file_uid"], name: "index_alchemy_attachments_on_file_uid", using: :btree

  create_table "alchemy_cells", force: :cascade do |t|
    t.integer  "page_id"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "alchemy_contents", force: :cascade do |t|
    t.string   "name"
    t.string   "essence_type"
    t.integer  "essence_id"
    t.integer  "element_id"
    t.integer  "position"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "creator_id"
    t.integer  "updater_id"
  end

  add_index "alchemy_contents", ["element_id", "position"], name: "index_contents_on_element_id_and_position", using: :btree

  create_table "alchemy_elements", force: :cascade do |t|
    t.string   "name"
    t.integer  "position"
    t.integer  "page_id"
    t.boolean  "public",          default: true
    t.boolean  "folded",          default: false
    t.boolean  "unique",          default: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.integer  "cell_id"
    t.text     "cached_tag_list"
  end

  add_index "alchemy_elements", ["page_id", "position"], name: "index_elements_on_page_id_and_position", using: :btree

  create_table "alchemy_elements_alchemy_pages", id: false, force: :cascade do |t|
    t.integer "element_id"
    t.integer "page_id"
  end

  create_table "alchemy_essence_booleans", force: :cascade do |t|
    t.boolean  "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "creator_id"
    t.integer  "updater_id"
  end

  add_index "alchemy_essence_booleans", ["value"], name: "index_alchemy_essence_booleans_on_value", using: :btree

  create_table "alchemy_essence_dates", force: :cascade do |t|
    t.datetime "date"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "alchemy_essence_files", force: :cascade do |t|
    t.integer  "attachment_id"
    t.string   "title"
    t.string   "css_class"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "alchemy_essence_htmls", force: :cascade do |t|
    t.text     "source"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "alchemy_essence_links", force: :cascade do |t|
    t.string   "link"
    t.string   "link_title"
    t.string   "link_target"
    t.string   "link_class_name"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "creator_id"
    t.integer  "updater_id"
  end

  create_table "alchemy_essence_pictures", force: :cascade do |t|
    t.integer  "picture_id"
    t.string   "caption"
    t.string   "title"
    t.string   "alt_tag"
    t.string   "link"
    t.string   "link_class_name"
    t.string   "link_title"
    t.string   "css_class"
    t.string   "link_target"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "crop_from"
    t.string   "crop_size"
    t.string   "render_size"
  end

  create_table "alchemy_essence_richtexts", force: :cascade do |t|
    t.text     "body"
    t.text     "stripped_body"
    t.boolean  "public"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "alchemy_essence_selects", force: :cascade do |t|
    t.string   "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "creator_id"
    t.integer  "updater_id"
  end

  add_index "alchemy_essence_selects", ["value"], name: "index_alchemy_essence_selects_on_value", using: :btree

  create_table "alchemy_essence_texts", force: :cascade do |t|
    t.text     "body"
    t.string   "link"
    t.string   "link_title"
    t.string   "link_class_name"
    t.boolean  "public",          default: false
    t.string   "link_target"
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  create_table "alchemy_folded_pages", force: :cascade do |t|
    t.integer "page_id"
    t.integer "user_id"
    t.boolean "folded",  default: false
  end

  create_table "alchemy_languages", force: :cascade do |t|
    t.string   "name"
    t.string   "language_code"
    t.string   "frontpage_name"
    t.string   "page_layout",    default: "intro"
    t.boolean  "public",         default: false
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.boolean  "default",        default: false
    t.string   "country_code",   default: "",      null: false
    t.integer  "site_id"
  end

  add_index "alchemy_languages", ["language_code", "country_code"], name: "index_alchemy_languages_on_language_code_and_country_code", using: :btree
  add_index "alchemy_languages", ["language_code"], name: "index_alchemy_languages_on_language_code", using: :btree
  add_index "alchemy_languages", ["site_id"], name: "index_alchemy_languages_on_site_id", using: :btree

  create_table "alchemy_legacy_page_urls", force: :cascade do |t|
    t.string   "urlname",    null: false
    t.integer  "page_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "alchemy_legacy_page_urls", ["urlname"], name: "index_alchemy_legacy_page_urls_on_urlname", using: :btree

  create_table "alchemy_pages", force: :cascade do |t|
    t.string   "name"
    t.string   "urlname"
    t.string   "title"
    t.string   "language_code"
    t.boolean  "language_root"
    t.string   "page_layout"
    t.text     "meta_keywords"
    t.text     "meta_description"
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "parent_id"
    t.integer  "depth"
    t.boolean  "visible",          default: false
    t.boolean  "public",           default: false
    t.boolean  "locked",           default: false
    t.integer  "locked_by"
    t.boolean  "restricted",       default: false
    t.boolean  "robot_index",      default: true
    t.boolean  "robot_follow",     default: true
    t.boolean  "sitemap",          default: true
    t.boolean  "layoutpage",       default: false
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.integer  "language_id"
    t.text     "cached_tag_list"
    t.datetime "published_at"
  end

  add_index "alchemy_pages", ["language_id"], name: "index_pages_on_language_id", using: :btree
  add_index "alchemy_pages", ["parent_id", "lft"], name: "index_pages_on_parent_id_and_lft", using: :btree
  add_index "alchemy_pages", ["urlname"], name: "index_pages_on_urlname", using: :btree

  create_table "alchemy_pictures", force: :cascade do |t|
    t.string   "name"
    t.string   "image_file_name"
    t.integer  "image_file_width"
    t.integer  "image_file_height"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "creator_id"
    t.integer  "updater_id"
    t.string   "upload_hash"
    t.text     "cached_tag_list"
    t.string   "image_file_uid"
    t.integer  "image_file_size"
  end

  create_table "alchemy_sites", force: :cascade do |t|
    t.string   "host"
    t.string   "name"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.boolean  "public",                   default: false
    t.text     "aliases"
    t.boolean  "redirect_to_primary_host"
  end

  add_index "alchemy_sites", ["host", "public"], name: "alchemy_sites_public_hosts_idx", using: :btree
  add_index "alchemy_sites", ["host"], name: "index_alchemy_sites_on_host", using: :btree

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
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "creator_id"
    t.integer  "updater_id"
  end

  add_index "users", ["creator_id"], name: "index_users_on_creator_id", using: :btree
  add_index "users", ["updater_id"], name: "index_users_on_updater_id", using: :btree

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree

end
