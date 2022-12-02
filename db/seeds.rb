# frozen_string_literal: true

# В таблицу attempt включить новую попытку для студента Баранова Павла по дисциплине «Основы баз данных».
# Установить текущую дату в качестве даты выполнения попытки.
#
if Attempt.last.attempt_id == 8
  Rails.logger.debug { "Student with id=#{Attempt.last.attempt_id} already exists" }
else
  n = Attempt.new attempt_id: 8, student_id: 1, subject_id: 2, date_attempt: '2020-06-05'
  n.save
end

# Случайным образом выбрать три вопроса (запрос) по дисциплине,
# тестирование по которой собирается проходить студент, занесенный в
# таблицу attempts последним, и добавить их в таблицу tests.
# id последней попытки получить как максимальное значение id из таблицы attempts.
#
if Test.last.answer_id.nil?
  Rails.logger.debug { 'Questions have already been added to the table' }
else
  Test.send(:request)
end

# Удалить из таблицы attempts все попытки, выполненные раньше 1 мая 2020 года. Также удалить
# и все соответствующие этим попыткам вопросы из таблицы tests.
# Test.send(:delete_attempt)
