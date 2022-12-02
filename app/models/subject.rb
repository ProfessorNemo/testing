# frozen_string_literal: true

class Subject < ApplicationRecord
  has_many :questions, dependent: :destroy
  has_many :attempts, dependent: :destroy
  validates :name_subject, presence: true, uniqueness: true

  # Студенты могут тестироваться по одной или нескольким дисциплинам
  # (не обязательно по всем). Вывести дисциплину и количество уникальных
  # студентов (столбец назвать Количество), которые по ней проходили
  # тестирование . Информацию отсортировать сначала по убыванию количества,
  # а потом по названию дисциплины. В результат включить и дисциплины, тестирование
  # по которым студенты не проходили, в этом случае указать количество студентов 0.
  scope :request1, lambda {
    connection.select_all("SELECT name_subject, COUNT(DISTINCT student_id) AS Количество
                                FROM subjects LEFT JOIN attempts USING(subject_id)
                                GROUP BY name_subject
                                ORDER BY COUNT(DISTINCT student_id) DESC, name_subject")
  }
end
