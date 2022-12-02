# frozen_string_literal: true

class Attempt < ApplicationRecord
  belongs_to :subject
  belongs_to :student

  # Вывести, сколько попыток сделали студенты по каждой дисциплине, а также
  # средний результат попыток, который округлить до 2 знаков после запятой.
  # Под результатом попытки понимается процент правильных ответов на вопросы
  # теста, который занесен в столбец result.  В результат включить название
  # дисциплины, а также вычисляемые столбцы Количество и Среднее. Информацию
  # вывести по убыванию средних результатов.
  scope :request1, lambda {
    connection.select_all("SELECT name_subject,
                                 COUNT(attempt_id) AS Количество,
                                 ROUND(AVG(result), 2) AS Среднее
                          FROM subjects
                                 LEFT JOIN attempts USING(subject_id)
                          GROUP BY name_subject
                          ORDER BY Среднее DESC")
  }
end
