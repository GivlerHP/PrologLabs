% SWI-Prolog. Переменные на английском, с большой буквы: Parent, Child.
% Имена людей — русские атомы в одинарных кавычках: 'Дима', 'Сергей'.
% father(Father, Child), mother(Mother, Child).
male('Виктор').
male('Сергей').
male('Андрей').
male('Олег').
male('Дима').
male('Иван').
male('Никита').
female('Галина').
female('Елена').
female('Марина').
female('Анна').
female('Ольга').
female('Катя').
female('Нина').

father('Виктор', 'Сергей').
father('Виктор', 'Андрей').
father('Сергей', 'Дима').
father('Сергей', 'Катя').
father('Андрей', 'Иван').
father('Олег', 'Никита').

mother('Галина', 'Сергей').
mother('Галина', 'Андрей').
mother('Елена', 'Дима').
mother('Елена', 'Катя').
mother('Марина', 'Иван').
mother('Нина', 'Никита').

% Текущие браки. Первый аргумент - муж, второй - жена.
% Сергей и Елена были парой раньше; теперь Елена замужем за Олегом.
married('Виктор', 'Галина').
married('Сергей', 'Ольга').
married('Андрей', 'Марина').
married('Олег', 'Елена').
married('Дима', 'Анна').

parent(Parent, Child) :- father(Parent, Child).
parent(Parent, Child) :- mother(Parent, Child).

spouse(Person, Partner) :- married(Person, Partner).
spouse(Person, Partner) :- married(Partner, Person).

% Брат — мужчина с общим родителем, отличный от самого человека.
% При двух общих родителях одна пара может находиться дважды.
brother(Brother, Person) :-
    male(Brother),
    parent(CommonParent, Brother),
    parent(CommonParent, Person),
    dif(Brother, Person).

% №21. Сводный брат: сын супруга родителя, без общих родителей.
stepbrother(Stepbrother, Person) :-
    male(Stepbrother),
    parent(Parent, Person),
    spouse(Parent, Stepparent),
    parent(Stepparent, Stepbrother),
    dif(Stepbrother, Person),
    \+ (parent(CommonParent, Stepbrother), parent(CommonParent, Person)).

% №29. Мужской пол: male/1 задан фактами в начале файла.

% №37. Деверь — брат мужа.
dever(HusbandsBrother, Wife) :-
    married(Husband, Wife),
    brother(HusbandsBrother, Husband).

% №45. Ятровь — жена брата мужа.
yatrov(BrothersWife, Wife) :-
    married(Husband, Wife),
    brother(HusbandsBrother, Husband),
    married(HusbandsBrother, BrothersWife).

% Запуск демонстрации: demo.
demo :-
    writeln('21. Сводные братья Димы:'),
    forall(stepbrother(Stepbrother, 'Дима'), writeln(Stepbrother)),
    writeln('29. Мужчины:'),
    forall(male(Man), writeln(Man)),
    writeln('37. Деверь Ольги:'),
    findall(HusbandsBrother, dever(HusbandsBrother, 'Ольга'), DeverAnswers),
    sort(DeverAnswers, UniqueDeverAnswers),
    forall(member(HusbandsBrother, UniqueDeverAnswers), writeln(HusbandsBrother)),
    writeln('45. Ятровь Ольги:'),
    findall(BrothersWife, yatrov(BrothersWife, 'Ольга'), YatrovAnswers),
    sort(YatrovAnswers, UniqueYatrovAnswers),
    forall(member(BrothersWife, UniqueYatrovAnswers), writeln(BrothersWife)).
