
RUN_ARGS := $(wordlist 2, $(words $(MAKECMDGOALS)), $(MAKECMDGOALS))

drop:
	rails db:drop

up:
	rails db:create
	rails db:migrate
	rake import:from_xlsx_subjects
	rake import:from_xlsx_students
	rake import:from_xlsx_attempts
	rake import:from_xlsx_questions
	rake import:from_xlsx_answers
	rake import:from_xlsx_tests
	rails db:seed

migration:
	bundle exec rails g migration $(RUN_ARGS)

model:
	bundle exec rails g model $(RUN_ARGS)

create:
	bundle exec rails db:create

migrate:
	bundle exec rails db:migrate

rubocop:
	rubocop -A

run-console:
	bundle exec rails console

c: run-console

.PHONY:	db
