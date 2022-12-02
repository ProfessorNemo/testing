# frozen_string_literal: true

class CreateStudents < ActiveRecord::Migration[6.1]
  execute <<~SQL.squish
    DROP TABLE IF EXISTS students CASCADE;

    CREATE TABLE IF NOT EXISTS students (
        student_id serial PRIMARY KEY,
        name_student TEXT,
        CONSTRAINT uniq_student UNIQUE (name_student)
    );
  SQL
end

def self.down
  execute 'DROP TABLE students'
end
