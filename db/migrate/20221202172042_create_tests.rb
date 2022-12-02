class CreateTests < ActiveRecord::Migration[6.1]
  def self.up
    execute <<~SQL.squish
      DROP TABLE IF EXISTS tests CASCADE;

      CREATE TABLE IF NOT EXISTS tests (
          test_id serial PRIMARY KEY,
          attempt_id INT,
          question_id INT,
          answer_id INT,
          CONSTRAINT "FK_test_attempt"
          FOREIGN KEY (attempt_id) REFERENCES attempts (attempt_id) ON DELETE CASCADE,
          CONSTRAINT "FK_test_question"
          FOREIGN KEY (question_id) REFERENCES questions (question_id) ON DELETE CASCADE,
          CONSTRAINT "FK_test_answer"
          FOREIGN KEY (answer_id) REFERENCES answers (answer_id) ON DELETE CASCADE
      );
    SQL
  end

  def self.down
    execute 'DROP TABLE tests'
  end
end

# Таблица tests:
# (в таблице хранится информация о каждой попытке студента:
# какие вопросы были заданы и какой ответ дал студент)
