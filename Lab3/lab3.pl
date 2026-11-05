% Лабораторная 3. SWI-Prolog / SWISH.

% Блок 1, №11. НОД: рекурсивный алгоритм Евклида.
nod(FirstNumber, 0, FirstNumber) :- FirstNumber > 0.
nod(FirstNumber, SecondNumber, Result) :-
    FirstNumber >= 0, SecondNumber > 0,
    Remainder is FirstNumber mod SecondNumber,
    nod(SecondNumber, Remainder, Result).

% Блок 2, №8. Семейные данные из лабораторной 1.
parent('Виктор', 'Сергей').
parent('Виктор', 'Андрей').
parent('Сергей', 'Дима').
parent('Сергей', 'Катя').
parent('Андрей', 'Иван').
parent('Олег', 'Никита').
parent('Галина', 'Сергей').
parent('Галина', 'Андрей').
parent('Елена', 'Дима').
parent('Елена', 'Катя').
parent('Марина', 'Иван').
parent('Нина', 'Никита').

married('Виктор', 'Галина').
married('Сергей', 'Ольга').
married('Андрей', 'Марина').
married('Олег', 'Елена').
married('Дима', 'Анна').

spouse(Person, Partner) :- married(Person, Partner).
spouse(Person, Partner) :- married(Partner, Person).

% Предок: родитель либо предок родителя.
ancestor(Ancestor, Descendant) :- parent(Ancestor, Descendant).
ancestor(Ancestor, Descendant) :-
    parent(Ancestor, Child),
    ancestor(Child, Descendant).

% Кровные родственники: предок/потомок либо общий предок.
blood_relative(Relative, Person) :- ancestor(Relative, Person).
blood_relative(Relative, Person) :- ancestor(Person, Relative).
blood_relative(Relative, Person) :-
    ancestor(CommonAncestor, Relative),
    ancestor(CommonAncestor, Person),
    dif(Relative, Person).

% Свойственник: кровный родственник супруга или супруг кровного родственника.
in_law(InLaw, Person) :-
    spouse(Person, Partner),
    blood_relative(InLaw, Partner),
    dif(InLaw, Person),
    \+ blood_relative(InLaw, Person).
in_law(InLaw, Person) :-
    blood_relative(Relative, Person),
    spouse(InLaw, Relative),
    dif(InLaw, Person),
    \+ blood_relative(InLaw, Person).

% Блок 4, №4. Первый элемент непустого списка.
first_element([First | _], First).

% Блок 6, №4. Последовательное деление первого элемента на остальные.
divide_first([First | Rest], Result) :-
    divide_rest(Rest, First, Result).

divide_rest([], Result, Result).
divide_rest([Divisor | Rest], Current, Result) :-
    Divisor =\= 0,
    Next is Current / Divisor,
    divide_rest(Rest, Next, Result).
