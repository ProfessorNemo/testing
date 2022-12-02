# frozen_string_literal: true

require 'roo'

namespace :import do
  desc 'Import data from xlsx files'

  data = Roo::Spreadsheet.open('db/import.xlsx')

  task from_xlsx_subjects: :environment do
    puts 'Importing Data Subjects'

    sheet = data.sheet(0)

    headers = sheet.row(1)

    sheet.each_with_index do |row, idx|
      next if idx.zero?

      subject_data = [headers, row].transpose.to_h

      if Subject.exists?(name_subject: subject_data['name_subject'])
        puts "Subject with title #{subject_data['name_subject']} already exists"

        next
      end

      subject = Subject.new(subject_data)

      puts "Saving Subject with title '#{subject.name_subject}'"

      subject.save!
    end
  end

  task from_xlsx_students: :environment do
    puts 'Importing Data Students'

    sheet = data.sheet(1)

    headers = sheet.row(1)

    sheet.each_with_index do |row, idx|
      next if idx.zero?

      student_data = [headers, row].transpose.to_h

      if Student.exists?(name_student: student_data['name_student'])
        puts "Student with name #{student_data['name_student']} already exists"

        next
      end

      student = Student.new(student_data)

      puts "Saving Student with title '#{student.name_student}'"

      student.save!
    end
  end

  task from_xlsx_attempts: :environment do
    puts 'Importing Data Attempts'

    sheet = data.sheet(2)

    headers = sheet.row(1)

    sheet.each_with_index do |row, idx|
      next if idx.zero?

      attempt_data = [headers, row].transpose.to_h

      attempt = Attempt.new(attempt_data)

      puts "Saving Attempt with result '#{attempt.result}'"

      attempt.save!
    end
  end

  task from_xlsx_questions: :environment do
    puts 'Importing Data Questions'

    sheet = data.sheet(3)

    headers = sheet.row(1)

    sheet.each_with_index do |row, idx|
      next if idx.zero?

      question_data = [headers, row].transpose.to_h

      question = Question.new(question_data)

      puts "Saving Question with title '#{question.name_question}'"

      question.save!
    end
  end

  task from_xlsx_answers: :environment do
    puts 'Importing Data Answers'

    sheet = data.sheet(4)

    headers = sheet.row(1)

    sheet.each_with_index do |row, idx|
      next if idx.zero?

      answer_data = [headers, row].transpose.to_h

      answer = Answer.new(answer_data)

      puts "Saving Answer with title '#{answer.name_answer}'"

      answer.save!
    end
  end

  task from_xlsx_tests: :environment do
    puts 'Importing Data Tests'

    sheet = data.sheet(5)

    headers = sheet.row(1)

    sheet.each_with_index do |row, idx|
      next if idx.zero?

      test_data = [headers, row].transpose.to_h

      test = Test.new(test_data)

      test.save!
    end
  end
end
