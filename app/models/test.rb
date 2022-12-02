# frozen_string_literal: true

class Test < ApplicationRecord
  belongs_to :attempt
  belongs_to :question
  belongs_to :answer

  def self.request
    connection.select_all("INSERT INTO tests (attempt_id, question_id)
                                SELECT attempt_id, question_id
                                FROM questions
                                JOIN attempts USING(subject_id)
                                WHERE attempt_id = (SELECT MAX(attempt_id) FROM attempts)
                                ORDER BY RANDOM()
                                LIMIT 3")
  end

  def self.delete_attempt
    connection.select_all("DELETE FROM attempts
                WHERE date_attempt < '2020-05-01'")
  end

  # Сформировать шпаргалку со списком предметов, вопросов и ответов, где в каждом вопросе перед
  # корректным ответом стоит стрелка '->' и этот ответ расположен первым среди остальных вариантов.
  # Вопросы и ответы обрезать до 30 символов и добавить к результату многоточие '...', но только в том
  # случае, если строка обрезалась (была изначально длиннее 30 символов). Столбцы полученной таблицы
  # назвать 'Предмет', 'Вопрос', 'Ответ'.
  scope :request1, lambda {
    connection.select_all("SELECT
                              name_subject AS Предмет,
                           CASE
                              WHEN CHAR_LENGTH(name_question) > 30
                              THEN CONCAT(LEFT(name_question, 30), '...')
                              ELSE name_question
                           END AS Вопрос,
                           CASE
                                WHEN CHAR_LENGTH(name_answer) > 30
                                THEN
                                    CASE
                                       WHEN is_correct
                                       THEN CONCAT('-> ', LEFT(name_answer, 30), '...')
                                       ELSE CONCAT('   ', LEFT(name_answer, 30), '...')
                                    END
                                ELSE
                                    CASE
                                       WHEN is_correct
                                       THEN CONCAT('-> ', name_answer)
                                       ELSE CONCAT('   ', name_answer)
                                    END
                           END AS Ответ
                          FROM
                              subjects
                                  JOIN questions USING(subject_id)
                                  JOIN answers USING(question_id)
                          ORDER BY
                              1, 2, 3 DESC")
  }
end
