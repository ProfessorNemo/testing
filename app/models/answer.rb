# frozen_string_literal: true

class Answer < ApplicationRecord
  belongs_to :question

  # Шпаргалка с правильными ответами
  scope :request1, lambda {
    connection.select_all("SELECT name_question AS Вопрос, name_answer AS Ответ
                                  FROM questions
                                  JOIN answers USING(question_id)
                                  WHERE answers.is_correct = true
                                  GROUP BY 1, 2")
  }
end
