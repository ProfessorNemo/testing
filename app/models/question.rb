# frozen_string_literal: true

class Question < ApplicationRecord
  belongs_to :subject
  has_many :answers, dependent: :destroy

  # Случайным образом отберите 3 вопроса по дисциплине «Основы баз данных».
  # В результат включите столбцы question_id и name_question.
  scope :request1, lambda {
    connection.select_all("SELECT question_id, name_question
                                FROM subjects INNER JOIN questions USING(subject_id)
                                WHERE subjects.subject_id = 2
                                ORDER BY RANDOM()
                                LIMIT 3")
  }

  # Вывести вопросы, которые были включены в тест для Семенова Ивана по дисциплине
  # «Основы SQL» 2020-05-17  (значение attempt_id для этой попытки равно 7).
  # Указать, какой ответ дал студент и правильный он или нет(вывести Верно или Неверно).
  # В результат включить вопрос, ответ и вычисляемый столбец  Результат.
  scope :request2, lambda {
    connection.select_all("SELECT name_question,
                                  name_answer,
                                  CASE WHEN is_correct THEN 'Верно'
                                       ELSE 'Неверно'
                                  END AS Результат
                            FROM questions
                                 INNER JOIN tests USING(question_id)
                                 INNER JOIN answers USING(answer_id)
                            WHERE attempt_id = 7")
  }
end
