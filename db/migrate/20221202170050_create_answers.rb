class CreateAnswers < ActiveRecord::Migration[6.1]
  def self.up
    execute <<~SQL.squish
      DROP TABLE IF EXISTS answers CASCADE;

      CREATE TABLE IF NOT EXISTS answers (
          answer_id serial PRIMARY KEY,
          name_answer TEXT,
          question_id INT,
          is_correct  BOOLEAN,
          CONSTRAINT "FK_answer_question"
          FOREIGN KEY (question_id) REFERENCES questions (question_id) ON DELETE CASCADE
      );
    SQL
  end

  def self.down
    execute 'DROP TABLE answers'
  end
end

# Таблица answers:
# (в таблице содержатся варианты ответов на каждый вопрос,
# для правильного варианта столбец is_correct имеет значение true):
