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

ActiveRecord::Schema.define(:version => 20120218204356) do

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

  create_table "answer_logs", :force => true do |t|
    t.integer  "service_level_id"
    t.integer  "segment_id"
    t.integer  "school_id"
    t.integer  "dimension_id"
    t.string   "person"
    t.text     "questions"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "answers", :force => true do |t|
    t.integer  "do_not_know"
    t.integer  "do_not_answer"
    t.integer  "one"
    t.integer  "two"
    t.integer  "three"
    t.integer  "four"
    t.integer  "five"
    t.integer  "quantity_of_people"
    t.integer  "question_text_id"
    t.integer  "school_id"
    t.integer  "segment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "answers", ["question_text_id", "segment_id", "school_id"], :name => "idx_a_text_id_segment_id_school_id"
  add_index "answers", ["question_text_id"], :name => "idx_a_text_id"

  create_table "complex_queries", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "dimension_data", :force => true do |t|
    t.integer  "school_id"
    t.integer  "dimension_number"
    t.string   "indicator_number"
    t.integer  "year"
    t.float    "value"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "service_level_id"
  end

  create_table "dimension_statuses", :force => true do |t|
    t.integer  "status"
    t.integer  "dimension_id"
    t.integer  "school_id"
    t.integer  "segment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "dimensions", :force => true do |t|
    t.string   "name"
    t.integer  "number"
    t.integer  "service_level_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "dimensions_average_geral", :force => true do |t|
    t.integer  "service_level_id"
    t.integer  "dimension_id"
    t.integer  "dimension_number"
    t.float    "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "evaluation_answer_stats", :force => true do |t|
    t.integer  "service_level_id"
    t.integer  "segment_id"
    t.integer  "school_id"
    t.boolean  "started_to_answer"
    t.datetime "started_at"
    t.datetime "finished_at"
    t.integer  "dimension_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "evalutaion_answer_stats", :force => true do |t|
    t.integer  "service_level_id"
    t.integer  "segment_id"
    t.integer  "school_id"
    t.integer  "current_dimension_id"
    t.boolean  "started_to_answer"
    t.datetime "started_at"
    t.datetime "finished_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "general_data", :force => true do |t|
    t.integer  "service_level_id"
    t.integer  "dimension_number"
    t.integer  "indicator_number"
    t.string   "segment"
    t.float    "media"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "general_report_data", :force => true do |t|
    t.float    "media"
    t.integer  "indicator_id"
    t.integer  "segment_id"
    t.integer  "dimension_id"
    t.integer  "data_type"
    t.integer  "service_level_id"
    t.integer  "year"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.integer  "service_level_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups_schools", :id => false, :force => true do |t|
    t.integer "group_id",  :null => false
    t.integer "school_id", :null => false
  end

  add_index "groups_schools", ["group_id"], :name => "idx_groups"

  create_table "indicators", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "number"
    t.integer  "dimension_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "indicators_average_geral", :force => true do |t|
    t.integer  "service_level_id"
    t.integer  "dimension_id"
    t.integer  "dimension_number"
    t.integer  "indicator_id"
    t.integer  "indicator_number"
    t.float    "value"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "segment",          :default => ""
  end

  create_table "indicators_data_geral", :force => true do |t|
    t.integer  "service_level_id"
    t.integer  "dimension_id"
    t.integer  "dimension_number"
    t.integer  "indicator_id"
    t.integer  "indicator_number"
    t.float    "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "password_controls", :force => true do |t|
    t.integer  "school_id"
    t.integer  "service_level_id"
    t.integer  "passwords_total"
    t.integer  "segment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "passwords", :force => true do |t|
    t.string   "password"
    t.integer  "school_id"
    t.integer  "segment_id"
    t.integer  "service_level_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "practices", :force => true do |t|
    t.text     "consolidated"
    t.text     "to_be_improved"
    t.integer  "dimension_id"
    t.integer  "school_id"
    t.integer  "segment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "presences", :force => true do |t|
    t.string   "name"
    t.integer  "school_id"
    t.integer  "segment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "previous_avaliations", :force => true do |t|
    t.string   "year"
    t.integer  "school_id"
    t.string   "school_name"
    t.integer  "service_level_id"
    t.integer  "dimension_id"
    t.string   "indicator_number"
    t.float    "media"
    t.float    "professores"
    t.float    "familiares"
    t.float    "funcionarios"
    t.float    "gestores"
    t.float    "educandos"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "question_texts", :force => true do |t|
    t.text     "text"
    t.integer  "question_id"
    t.integer  "segment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "dimension_number"
    t.string   "question_number"
    t.integer  "dimension_id"
  end

  add_index "question_texts", ["question_number"], :name => "idx_question_texts"

  create_table "questions", :force => true do |t|
    t.integer  "number"
    t.integer  "service_level_id"
    t.integer  "indicator_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "report_data", :force => true do |t|
    t.float    "media"
    t.string   "answers_ids"
    t.integer  "indicator_id"
    t.integer  "segment_id"
    t.integer  "dimension_id"
    t.integer  "school_id"
    t.integer  "service_level_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "schools", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "group_id"
    t.string   "report_name"
  end

  create_table "schools_service_levels", :id => false, :force => true do |t|
    t.integer "service_level_id", :null => false
    t.integer "school_id",        :null => false
  end

  create_table "segments", :force => true do |t|
    t.string   "name"
    t.integer  "service_level_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "segments", ["service_level_id"], :name => "idx_segments"

  create_table "service_levels", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tbm", :id => false, :force => true do |t|
    t.integer "id"
  end

end
