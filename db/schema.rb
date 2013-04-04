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

ActiveRecord::Schema.define(:version => 20130328164942) do

  create_table "courses", :force => true do |t|
    t.string   "name"
    t.string   "title"
    t.text     "description"
    t.integer  "department_id"
    t.string   "level_description"
    t.integer  "credit"
    t.string   "rules"
    t.string   "cip_codes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "courses", ["department_id"], :name => "index_courses_on_department_id"
  add_index "courses", ["id"], :name => "index_courses_on_id"
  add_index "courses", ["name"], :name => "index_courses_on_name", :unique => true

  create_table "credits", :force => true do |t|
    t.integer  "faculty_id"
    t.integer  "facultycredential_id"
    t.string   "course_name"
    t.string   "course_description"
    t.string   "course_year"
    t.integer  "course_credits"
    t.boolean  "semester_credits"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "credits", ["faculty_id"], :name => "index_credits_on_faculty_id"
  add_index "credits", ["facultycredential_id"], :name => "index_credits_on_facultycredential_id"
  add_index "credits", ["id"], :name => "index_credits_on_id"

  create_table "departments", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "school_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "departments", ["id"], :name => "index_departments_on_id"
  add_index "departments", ["name"], :name => "index_departments_on_name", :unique => true
  add_index "departments", ["school_id"], :name => "index_departments_on_school_id"

  create_table "donesemesters", :force => true do |t|
    t.integer  "faculty_id"
    t.integer  "semester_id"
    t.boolean  "completed",   :default => false
    t.boolean  "reviewed",    :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "teaching",    :default => false
  end

  add_index "donesemesters", ["completed"], :name => "index_donesemesters_on_completed"
  add_index "donesemesters", ["faculty_id"], :name => "index_donesemesters_on_faculty_id"
  add_index "donesemesters", ["id"], :name => "index_donesemesters_on_id"
  add_index "donesemesters", ["reviewed"], :name => "index_donesemesters_on_reviewed"
  add_index "donesemesters", ["semester_id"], :name => "index_donesemesters_on_semester_id"

  create_table "employmentstatuses", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "employmentstatuses", ["id"], :name => "index_employmentstatuses_on_id"
  add_index "employmentstatuses", ["name"], :name => "index_employmentstatuses_on_name"

  create_table "faculties", :force => true do |t|
    t.string   "znumber"
    t.string   "email"
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.integer  "title_id"
    t.integer  "department_id"
    t.integer  "rank_id"
    t.integer  "employmentstatus_id"
    t.integer  "tenurestatus_id"
    t.integer  "qualification_id"
    t.string   "cv_onfile"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "faculties", ["department_id"], :name => "index_faculties_on_department_id"
  add_index "faculties", ["employmentstatus_id"], :name => "index_faculties_on_employmentstatus_id"
  add_index "faculties", ["id"], :name => "index_faculties_on_id"
  add_index "faculties", ["qualification_id"], :name => "index_faculties_on_qualification_id"
  add_index "faculties", ["rank_id"], :name => "index_faculties_on_rank_id"
  add_index "faculties", ["tenurestatus_id"], :name => "index_faculties_on_tenurestatus_id"
  add_index "faculties", ["title_id"], :name => "index_faculties_on_title_id"
  add_index "faculties", ["znumber"], :name => "index_faculties_on_znumber", :unique => true

  create_table "facultycredentials", :force => true do |t|
    t.integer  "faculty_id"
    t.string   "email"
    t.string   "qualificationaward_id"
    t.string   "qualification_name"
    t.string   "qualification_institution"
    t.string   "qualification_field"
    t.string   "qualification_year"
    t.string   "transcript_on_file"
    t.string   "cip_codes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "facultycredentials", ["faculty_id"], :name => "index_facultycredentials_on_faculty_id"
  add_index "facultycredentials", ["id"], :name => "index_facultycredentials_on_id"
  add_index "facultycredentials", ["qualificationaward_id"], :name => "index_facultycredentials_on_qualificationaward_id"

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "groups", ["id"], :name => "index_groups_on_id"

  create_table "keyvalues", :force => true do |t|
    t.string   "key"
    t.text     "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "keyvalues", ["id"], :name => "index_keyvalues_on_id"
  add_index "keyvalues", ["key"], :name => "index_keyvalues_on_key"

  create_table "newhirecomments", :force => true do |t|
    t.text     "comment"
    t.integer  "newhire_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "course_id"
  end

  create_table "newhirecourses", :force => true do |t|
    t.string   "name"
    t.string   "title"
    t.string   "description"
    t.integer  "semester_id"
    t.integer  "assigned_to"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "newhire_id"
    t.integer  "final_approval", :default => 0
  end

  create_table "newhirecredentials", :force => true do |t|
    t.integer  "newhire_id"
    t.integer  "qualificationreason_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "qualification_explanation"
    t.text     "major"
    t.integer  "course_id"
  end

  create_table "newhirecredits", :force => true do |t|
    t.integer  "newhire_id"
    t.string   "course_name"
    t.string   "course_description"
    t.string   "course_year"
    t.text     "semester"
    t.integer  "course_credits"
    t.integer  "semester_credits"
    t.integer  "newhire_institution_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "course_id"
  end

  create_table "newhiredoctypes", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "newhiredocuments", :force => true do |t|
    t.string   "verified"
    t.string   "name"
    t.string   "location"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "newhire_id"
    t.integer  "newhiredoctype_id"
    t.integer  "course_id"
  end

  create_table "newhireinstitutions", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "newhirereviewreasons", :force => true do |t|
    t.integer  "newhire_id"
    t.integer  "course_id"
    t.integer  "review_state"
    t.integer  "reviewer_id"
    t.text     "review_comments"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "newhires", :force => true do |t|
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.integer  "semester_id"
    t.integer  "department_id"
    t.integer  "school_id"
    t.integer  "assigned_to"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "newhiresignoffs", :force => true do |t|
    t.integer  "newhire_id"
    t.integer  "course_id"
    t.integer  "signed_off"
    t.integer  "user_id"
    t.integer  "user_type"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sentto_id"
  end

  create_table "qualificationawards", :force => true do |t|
    t.string   "name"
    t.integer  "qualification_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "qualificationawards", ["id"], :name => "index_qualificationawards_on_id"
  add_index "qualificationawards", ["name"], :name => "index_qualificationawards_on_name", :unique => true
  add_index "qualificationawards", ["qualification_id"], :name => "index_qualificationawards_on_qualification_id"

  create_table "qualificationreasons", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "qualificationreasons", ["id"], :name => "index_qualificationreasons_on_id"

  create_table "qualifications", :force => true do |t|
    t.string   "name"
    t.integer  "level"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "qualifications", ["id"], :name => "index_qualifications_on_id"
  add_index "qualifications", ["name"], :name => "index_qualifications_on_name", :unique => true

  create_table "ranks", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ranks", ["id"], :name => "index_ranks_on_id"
  add_index "ranks", ["name"], :name => "index_ranks_on_name"

  create_table "reasons", :force => true do |t|
    t.integer  "faculty_id"
    t.integer  "course_id"
    t.integer  "qualificationreason_id"
    t.text     "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "review_state",           :default => 0
    t.integer  "reviewer_id"
    t.text     "review_comments"
    t.integer  "dean_id"
    t.boolean  "dean_signoff",           :default => false
    t.datetime "dean_signoff_date"
    t.text     "dean_comments"
    t.integer  "facultycredential_id"
  end

  add_index "reasons", ["course_id"], :name => "index_reasons_on_course_id"
  add_index "reasons", ["faculty_id", "course_id"], :name => "index_reasons_on_faculty_id_and_course_id", :unique => true
  add_index "reasons", ["faculty_id"], :name => "index_reasons_on_faculty_id"
  add_index "reasons", ["id"], :name => "index_reasons_on_id"
  add_index "reasons", ["qualificationreason_id"], :name => "index_reasons_on_qualificationreason_id"
  add_index "reasons", ["reviewer_id"], :name => "index_reasons_on_reviewer_id"
  add_index "reasons", ["user_id"], :name => "index_reasons_on_user_id"

  create_table "reasons_reviewreasons", :id => false, :force => true do |t|
    t.integer "reason_id"
    t.integer "reviewreason_id"
  end

  create_table "reviewreasons", :force => true do |t|
    t.string   "name"
    t.boolean  "review_passed"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "reviewreasons", ["id"], :name => "index_reviewreasons_on_id"
  add_index "reviewreasons", ["review_passed"], :name => "index_reviewreasons_on_review_passed"

  create_table "schools", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "enabled",     :default => true
  end

  add_index "schools", ["id"], :name => "index_schools_on_id"
  add_index "schools", ["name"], :name => "index_schools_on_name", :unique => true

  create_table "sectioncredentials", :force => true do |t|
    t.integer  "faculty_id"
    t.string   "email"
    t.string   "qualificationaward_id"
    t.string   "qualification_name"
    t.string   "qualification_institution"
    t.string   "qualification_year"
    t.integer  "section_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sectioncredentials", ["faculty_id"], :name => "index_sectioncredentials_on_faculty_id"
  add_index "sectioncredentials", ["id"], :name => "index_sectioncredentials_on_id"
  add_index "sectioncredentials", ["qualificationaward_id"], :name => "index_sectioncredentials_on_qualificationaward_id"
  add_index "sectioncredentials", ["section_id"], :name => "index_sectioncredentials_on_section_id"

  create_table "sectionenrollments", :force => true do |t|
    t.integer  "section_id"
    t.integer  "faculty_id"
    t.string   "email"
    t.string   "section_role"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "completed",    :default => false
  end

  add_index "sectionenrollments", ["faculty_id"], :name => "index_sectionenrollments_on_faculty_id"
  add_index "sectionenrollments", ["id"], :name => "index_sectionenrollments_on_id"
  add_index "sectionenrollments", ["section_id"], :name => "index_sectionenrollments_on_section_id"

  create_table "sections", :force => true do |t|
    t.string   "name"
    t.string   "title"
    t.text     "description"
    t.integer  "course_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "semester_id"
  end

  add_index "sections", ["course_id"], :name => "index_sections_on_course_id"
  add_index "sections", ["id"], :name => "index_sections_on_id"
  add_index "sections", ["name"], :name => "index_sections_on_name", :unique => true
  add_index "sections", ["semester_id"], :name => "index_sections_on_semester_id"

  create_table "semesters", :force => true do |t|
    t.string   "name"
    t.string   "prefix"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "semester_status", :default => 0
  end

  add_index "semesters", ["id"], :name => "index_semesters_on_id"
  add_index "semesters", ["name"], :name => "index_semesters_on_name"

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "tenurestatuses", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tenurestatuses", ["id"], :name => "index_tenurestatuses_on_id"
  add_index "tenurestatuses", ["name"], :name => "index_tenurestatuses_on_name"

  create_table "titles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "titles", ["id"], :name => "index_titles_on_id"
  add_index "titles", ["name"], :name => "index_titles_on_name"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.integer  "group_id"
    t.integer  "department_id"
    t.integer  "school_id"
    t.integer  "permission_id",  :default => 0
    t.string   "remember_token"
    t.boolean  "ro"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "enabled",        :default => false
  end

  add_index "users", ["department_id"], :name => "index_users_on_department_id"
  add_index "users", ["group_id"], :name => "index_users_on_group_id"
  add_index "users", ["id"], :name => "index_users_on_id"
  add_index "users", ["school_id"], :name => "index_users_on_school_id"

end
