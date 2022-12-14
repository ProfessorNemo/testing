# testing
## SQL-запросы к таблицам БД "PostgreSQL" в Rails - приложении. Часть 3. База данных «Тестирование» 

###### Ruby: `3.0.3` Rails: `6.1.6` Language: `Russian`

Основано на выполнении заданий 3-й части курса [`MySQL`](https://stepik.org/course/63054/syllabus)

Данное приложение по сути не является завершенным проектом, а представляет собой лишь пример (набор) SQL-запросов к БД PostgreSQL для создания моделей, добавления миграций и взаимодействия с БД при помощи чистого SQL. Примеры запросов можно найди в директории `app/models`.

### Установка:
1. Клонируйте репозиторий
```
$ git clone git@github.com:ProfessorNemo/testing.git
```

2. Установите библиотеки
```
$ bundle
```

3. Создайте базу данных и запустите миграции
```
$ make up
```

### Предметная область:

В университете реализуется on-line тестирование по нескольким дисциплинам. Каждая дисциплина включает некоторое количество вопросов. Ответы на вопрос представлены в виде вариантов ответов, один из этих вариантов правильный.

Студент регистрируется в системе, указав свое имя, фамилию и отчество. После этого он может проходить тестирование по одной или нескольким дисциплинам. Студент имеет несколько попыток для прохождения тестирования  (необходимо сохранять дату попытки). Каждому студенту случайным образом выбирается набор вопросов по дисциплине и формируется индивидуальный тест. Студент отвечает на вопросы, выбирая один из предложенных вариантов ответа.

После окончания тестирования  вычисляется и сохраняется результат (в процентах) попытки.

### Концептуальная модель базы данных:
![Снимок экрана от 2022-12-04 03-16-35](https://user-images.githubusercontent.com/102049907/205467735-49dfa497-259e-4e23-a4dc-7e47c04766ce.png)

### Логическая модель базы данных:
![Снимок экрана от 2022-12-04 03-17-42](https://user-images.githubusercontent.com/102049907/205467754-a31e8c14-2ed2-4f62-8415-2c91e2552bd3.png)

