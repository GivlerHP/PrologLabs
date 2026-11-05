% Лабораторная 2. Часть 1, вариант 6: табель оценок.
% Единственный предикат хранения — tabel/4.
% tabel(ФИО, Группа, Предмет, Результат).
% Структуры: fio(Фамилия, Имя, Отчество), mark(Оценка, date(День, Месяц, Год)).
% Шкала: 1–5; положительная оценка — от 3.

tabel(fio('Иванов', 'Дима', 'Сергеевич'), 'ПИ-21', 'Логика',
      mark(5, date(15, 1, 2027))).
tabel(fio('Иванов', 'Дима', 'Сергеевич'), 'ПИ-21', 'Prolog',
      mark(5, date(20, 1, 2027))).
tabel(fio('Иванов', 'Дима', 'Сергеевич'), 'ПИ-21', 'Математика',
      mark(4, date(25, 1, 2027))).

tabel(fio('Петров', 'Максим', 'Олегович'), 'ПИ-21', 'Логика',
      mark(3, date(15, 1, 2027))).
tabel(fio('Петров', 'Максим', 'Олегович'), 'ПИ-21', 'Prolog',
      mark(2, date(20, 1, 2027))).
tabel(fio('Петров', 'Максим', 'Олегович'), 'ПИ-21', 'Математика',
      mark(3, date(25, 1, 2027))).

tabel(fio('Смирнова', 'Алина', 'Андреевна'), 'ПИ-21', 'Логика',
      mark(5, date(15, 1, 2027))).
tabel(fio('Смирнова', 'Алина', 'Андреевна'), 'ПИ-21', 'Prolog',
      mark(5, date(20, 1, 2027))).
tabel(fio('Смирнова', 'Алина', 'Андреевна'), 'ПИ-21', 'Математика',
      mark(5, date(25, 1, 2027))).

% Оценки с полным ФИО, без раскрытия структур в запросе.
student_grade(Surname, Name, Patronymic, Subject, Grade) :-
    tabel(fio(Surname, Name, Patronymic), _, Subject, mark(Grade, _)).

% Каждый студент один раз, независимо от количества предметов.
student(Surname, Name, Patronymic) :-
    setof(
        fio(StudentSurname, StudentName, StudentPatronymic),
        Group^Subject^Result^
        tabel(fio(StudentSurname, StudentName, StudentPatronymic),
              Group, Subject, Result),
        Students
    ),
    member(fio(Surname, Name, Patronymic), Students).

% Найти оценку по имени студента и предмету.
% В учебной базе имена разные; для тёзок нужно использовать полное ФИО.
student_mark(Name, Subject, Grade) :-
    tabel(fio(_, Name, _), _, Subject, mark(Grade, _)).

% Неудовлетворительные оценки.
failed_student(Name, Subject, Grade) :-
    student_mark(Name, Subject, Grade),
    Grade < 3.

% Отличные оценки — 5.
high_mark(Name, Subject, Grade) :-
    student_mark(Name, Subject, Grade),
    Grade = 5.
