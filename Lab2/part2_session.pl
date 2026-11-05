% Лабораторная 2. Часть 2, вариант 4: расписание сессии.
% session(Группа, СписокПредметов).
% Элемент списка: subject(Название, ФормаКонтроля).
% Альтернативы: exam(Дата, Время, Аудитория, ФИО) — экзамен;
% credit(Дата, Время, Аудитория, ФИО) — зачёт.

session_data('ПИ-21', [
    subject('Английский язык',
        credit(date(10, 1, 2027), time(10, 0), room('А', 201),
               fio('Смирнова', 'Анна', 'Петровна'))),
    subject('История',
        credit(date(12, 1, 2027), time(12, 0), room('Б', 105),
               fio('Лебедев', 'Олег', 'Иванович'))),
    subject('Логика',
        exam(date(15, 1, 2027), time(9, 0), room('А', 301),
             fio('Петров', 'Иван', 'Николаевич'))),
    subject('Prolog',
        exam(date(20, 1, 2027), time(10, 0), room('А', 305),
             fio('Соколов', 'Павел', 'Андреевич'))),
    subject('Математика',
        exam(date(25, 1, 2027), time(9, 0), room('Б', 210),
             fio('Волкова', 'Елена', 'Сергеевна')))
]).

session(Group, Subjects) :-
    session_data(Group, Subjects),
    maplist(valid_subject, Subjects).

valid_subject(subject(_, exam(_, _, _, _))).
valid_subject(subject(_, credit(_, _, _, _))).

% Найти предмет в списке расписания группы.
session_subject(Group, Subject, Control) :-
    session(Group, Subjects),
    member(subject(Subject, Control), Subjects).

% Только экзамены.
exam_subject(Group, Subject, Date, Time, Room, Teacher) :-
    session_subject(Group, Subject, exam(Date, Time, Room, Teacher)).

% Только зачёты.
credit_subject(Group, Subject, Date, Time, Room, Teacher) :-
    session_subject(Group, Subject, credit(Date, Time, Room, Teacher)).
