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

ActiveRecord::Schema.define(version: 2022_12_02_172042) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", primary_key: "answer_id", id: :serial, force: :cascade do |t|
    t.text "name_answer"
    t.integer "question_id"
    t.boolean "is_correct"
  end

  create_table "attempts", primary_key: "attempt_id", id: :serial, force: :cascade do |t|
    t.integer "student_id"
    t.integer "subject_id"
    t.date "date_attempt"
    t.integer "result"
  end

  create_table "questions", primary_key: "question_id", id: :serial, force: :cascade do |t|
    t.text "name_question"
    t.integer "subject_id"
  end

  create_table "students", primary_key: "student_id", id: :serial, force: :cascade do |t|
    t.text "name_student"
    t.index ["name_student"], name: "uniq_student", unique: true
  end

  create_table "subjects", primary_key: "subject_id", id: :serial, force: :cascade do |t|
    t.text "name_subject"
    t.index ["name_subject"], name: "uniq_subject", unique: true
  end

  create_table "tests", primary_key: "test_id", id: :serial, force: :cascade do |t|
    t.integer "attempt_id"
    t.integer "question_id"
    t.integer "answer_id"
  end

  add_foreign_key "answers", "questions", primary_key: "question_id", name: "FK_answer_question", on_delete: :cascade
  add_foreign_key "attempts", "students", primary_key: "student_id", name: "FK_attempt_student", on_delete: :cascade
  add_foreign_key "attempts", "subjects", primary_key: "subject_id", name: "FK_attempt_subject", on_delete: :cascade
  add_foreign_key "questions", "subjects", primary_key: "subject_id", name: "FK_question_subject", on_delete: :cascade
  add_foreign_key "tests", "answers", primary_key: "answer_id", name: "FK_test_answer", on_delete: :cascade
  add_foreign_key "tests", "attempts", primary_key: "attempt_id", name: "FK_test_attempt", on_delete: :cascade
  add_foreign_key "tests", "questions", primary_key: "question_id", name: "FK_test_question", on_delete: :cascade
end
