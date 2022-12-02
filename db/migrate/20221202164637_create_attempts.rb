class CreateAttempts < ActiveRecord::Migration[6.1]
  def self.up
    execute <<~SQL.squish
      DROP TABLE IF EXISTS attempts CASCADE;

      CREATE TABLE IF NOT EXISTS attempts (
          attempt_id serial PRIMARY KEY,
          student_id INT,
          subject_id INT,
          date_attempt DATE,
          result  INT,
          CONSTRAINT "FK_attempt_student"
          FOREIGN KEY (student_id) REFERENCES students (student_id) ON DELETE CASCADE,
          CONSTRAINT "FK_attempt_subject"
          FOREIGN KEY (subject_id) REFERENCES subjects (subject_id) ON DELETE CASCADE
      );
    SQL
  end

  def self.down
    execute 'DROP TABLE attempts'
  end
end

# Таблица attempts:
# (в таблице хранится информация о каждой попытке сдачи теста: id студента, id дисциплины,
#  дата попытки и результат в процентах)
