# frozen_string_literal: true

class CreateQuestions < ActiveRecord::Migration[6.1]
  def self.up
    execute <<~SQL.squish
      DROP TABLE IF EXISTS questions CASCADE;

      CREATE TABLE IF NOT EXISTS questions (
          question_id serial PRIMARY KEY,
          name_question TEXT,
          subject_id  INT,
          CONSTRAINT "FK_question_subject"
          FOREIGN KEY (subject_id) REFERENCES subjects (subject_id) ON DELETE CASCADE
      );
    SQL
  end

  def self.down
    execute 'DROP TABLE questions'
  end
end

# Таблица questions:
# (таблица содержит вопросы по каждой дисциплине)
