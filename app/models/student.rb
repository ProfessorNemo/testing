# frozen_string_literal: true

class Student < ApplicationRecord
  has_many :attempts, dependent: :destroy
  validates :name_student, presence: true, uniqueness: true

  # Вывести студентов, которые сдавали дисциплину «Основы баз данных»,
  # указать дату попытки и результат. Информацию вывести по убыванию результатов тестирования.
  scope :request1, lambda {
    connection.select_all("SELECT name_student, date_attempt, result
                                  FROM students
                                      INNER JOIN attempts USING(student_id)
                                      INNER JOIN subjects USING(subject_id)
                                  WHERE name_subject = 'Основы баз данных'
                                  ORDER BY result DESC")
  }

  # Вывести студентов (различных студентов), имеющих максимальные результаты попыток.
  # Информацию отсортировать в алфавитном порядке по фамилии студента.
  scope :request2, lambda {
    connection.select_all("SELECT name_student, result
                                FROM students
                                    INNER JOIN attempts USING(student_id)
                                WHERE result = (
                                         SELECT MAX(result)
                                         FROM attempts
                                      )
                                ORDER BY name_student")
  }

  # Если студент совершал несколько попыток по одной и той же дисциплине,
  # то вывести разницу в днях между первой и последней попыткой. В результат
  # включить фамилию и имя студента, название дисциплины и вычисляемый столбец
  # Интервал. Информацию вывести по возрастанию разницы. Студентов, сделавших одну
  # попытку по дисциплине, не учитывать.
  scope :request3, lambda {
    connection.select_all("SELECT name_student,
                               name_subject,
                               MAX(date_attempt::date) - MIN(date_attempt::date) AS Интервал
                          FROM subjects
                               JOIN attempts USING (subject_id)
                               JOIN students USING (student_id)
                          GROUP BY name_student, name_subject
                          HAVING COUNT(attempt_id) > 1
                          ORDER BY 3")
  }

  # Вывести максимальную оценку студента по каждому предмету, а также вердикт Зачет/Незачет
  # (если результат не менее 70%, то зачет). Если студент не сдавал предмет, оценка по нему будет 0.
  # Результат отсортировать по имени студента и названию предмета
  scope :request4, lambda {
    connection.select_all("SELECT name_student,
                                  name_subject,
                                  CASE
                                     WHEN MAX(result) IS NULL THEN 0
                                     ELSE MAX(result)
                                  END As Результат,
                                  CASE
                                     WHEN MAX(result) > 70 THEN 'Зачет'
                                     ELSE 'Незачет'
                                  END As Результат
                              FROM students CROSS JOIN subjects
                              LEFT JOIN attempts USING(student_id, subject_id)
                              GROUP BY student_id, subject_id
                              ORDER BY name_student, name_subject")
  }
end
