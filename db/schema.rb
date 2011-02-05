# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110205181140) do

  create_table "answers", :force => true do |t|
    t.integer  "user_id"
    t.integer  "survey_id"
    t.integer  "question_id"
    t.integer  "zero"
    t.integer  "one"
    t.integer  "two"
    t.integer  "three"
    t.integer  "four"
    t.integer  "five"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "participants_number"
  end

  add_index "answers", ["created_at"], :name => "index_answers_on_created_at"
  add_index "answers", ["participants_number"], :name => "index_answers_on_participants_number"
  add_index "answers", ["question_id"], :name => "index_answers_on_question_id"
  add_index "answers", ["survey_id"], :name => "index_answers_on_survey_id"
  add_index "answers", ["user_id"], :name => "index_answers_on_user_id"

  create_table "attendees", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "dimensions", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "number"
  end

  add_index "dimensions", ["number"], :name => "index_dimensions_on_number"

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "indicators", :force => true do |t|
    t.integer  "dimension_id"
    t.string   "number"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "service_level_id"
    t.integer  "segment_id"
    t.integer  "membership_id"
    t.integer  "indicators_party_id"
  end

  create_table "indicators_parties", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "dimension_id"
  end

  create_table "institutions", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "institutions_service_levels", :id => false, :force => true do |t|
    t.integer "institution_id"
    t.integer "service_level_id"
  end

  create_table "memberships", :force => true do |t|
    t.integer  "party_id"
    t.integer  "member_id"
    t.string   "member_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "parties", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "questions", :force => true do |t|
    t.string   "number"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "survey_id"
    t.integer  "indicator_id"
    t.integer  "questions_party_id"
  end

  add_index "questions", ["number"], :name => "index_questions_on_number"
  add_index "questions", ["survey_id"], :name => "index_questions_on_survey_id"

  create_table "questions_parties", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "questions_surveys", :id => false, :force => true do |t|
    t.integer "question_id"
    t.integer "surveys_id"
  end

  create_table "segments", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "segments_service_levels", :id => false, :force => true do |t|
    t.integer "segment_id"
    t.integer "service_level_id"
  end

  create_table "service_levels", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "surveys", :force => true do |t|
    t.integer  "segment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "service_level_id"
  end

  create_table "users", :force => true do |t|
    t.integer  "institution_id"
    t.integer  "service_level_id"
    t.integer  "segment_id"
    t.string   "password"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "group_id"
  end

  add_index "users", ["group_id"], :name => "index_users_on_group_id"
  add_index "users", ["institution_id"], :name => "index_users_on_institution_id"
  add_index "users", ["service_level_id"], :name => "index_users_on_service_level_id"

end
