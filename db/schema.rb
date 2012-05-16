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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120516213901) do

  create_table "active_admin_comments", :force => true do |t|
    t.integer  "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "admin_users", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "datacenters", :force => true do |t|
    t.string   "name"
    t.integer  "hosts"
    t.integer  "id_template_server"
    t.integer  "id_template_rs"
    t.integer  "id_template_node"
    t.integer  "id_zone"
    t.integer  "infrastructure_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "infrastructures", :force => true do |t|
    t.string   "name"
    t.string   "infrastructure_type"
    t.boolean  "deployed",            :default => false
    t.integer  "id_zone"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "instances", :force => true do |t|
    t.string   "instanceId"
    t.string   "imageId"
    t.string   "instanceType"
    t.string   "architecture"
    t.string   "rootDeviceType"
    t.string   "rootDeviceName"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "instanceState"
    t.string   "privateDnsName"
    t.string   "dnsName"
    t.string   "reason"
    t.string   "amiLaunchIndex"
    t.string   "productCodes"
    t.date     "launchTime"
    t.string   "placement"
    t.string   "kernelId"
    t.string   "monitoring"
    t.string   "stateReason"
    t.string   "blockDeviceMapping"
    t.string   "virtualizationType"
    t.string   "clientToken"
    t.integer  "infrastructure_id"
  end

  create_table "preferences", :force => true do |t|
    t.string   "option"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "templates", :force => true do |t|
    t.string   "name"
    t.string   "idRemote"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "zones", :force => true do |t|
    t.string   "name"
    t.string   "zoneId"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
