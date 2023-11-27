:- ['three.pl'].

write_list([]).
write_list([H | T]) :-
    write(H),
    write(', '),
    write_list(T).

sum([], 0).
sum([H | T], S) :-
	sum(T, S1), 
	S is H + S1.

% delete all "List2" elements from List
delete_matching([], _, []).
delete_matching(List, [], List).
delete_matching(List, [H | T], Result) :-
    delete(List, H, ListWithoutH),
    delete_matching(ListWithoutH, T, Result).


group_students(GroupNumber, List) :-
    findall(X, student(GroupNumber, X, _), List).

group_count(GroupNumber, Count) :-
    group_students(GroupNumber, List),
    length(List, Count).

% get list with all grades of a group
group_grades_list(GroupNumber, List) :-
    findall(X, student(GroupNumber, _, [               grade('LP',  X) | _]), LP),
    findall(X, student(GroupNumber, _, [_,             grade('MTH', X) | _]), MTH),
    findall(X, student(GroupNumber, _, [_, _,          grade('FP',  X) | _]), FP),
    findall(X, student(GroupNumber, _, [_, _, _,       grade('INF', X) | _]), INF),
    findall(X, student(GroupNumber, _, [_, _, _, _,    grade('ENG', X) | _]), ENG),
    findall(X, student(GroupNumber, _, [_, _, _, _, _, grade('PSY', X)    ]), PSY),

    append(LP, MTH, T1),
    append(FP, INF, T2),
    append(ENG, PSY, T3),

    append(T1, T2, Temp),
    append(T3, Temp, List).


% Variant 1
% Получить таблицу групп и средний балл по каждой из групп

group_grade_sum(GroupNumber, Length, Sum) :-
    group_grades_list(GroupNumber, List),
    length(List, Length),
    sum(List, Sum).

group_grade_average(GroupNumber, Average) :-
    group_grade_sum(GroupNumber, Length, Sum),
    Average is Sum / Length.

group_grade_average() :-
    write("Average grade in 101 = "),
    group_grade_average(101, N1),
    write(N1),

    write("\nAverage grade in 102 = "),
    group_grade_average(102, N2),
    write(N2),

    write("\nAverage grade in 103 = "),
    group_grade_average(103, N3),
    write(N3),

    write("\nAverage grade in 104 = "),
    group_grade_average(104, N4),
    write(N4),
    write('\n').

group_students_table() :-
    write("101: "),
    group_students(101, List101),
    write_list(List101),

    write("\n102: "),
    group_students(102, List102),
    write_list(List102),

    write("\n103: "),
    group_students(103, List103),
    write_list(List103),

    write("\n104: "),
    group_students(104, List104),
    write_list(List104),
    write('\n').

task1() :-
    group_students_table(),
    write('\n'),
    group_grade_average().


% Для каждого предмета получить список студентов, не сдавших экзамен (grade=2)
lp_not_passed_students(List) :-
    findall(X, student(_, X, [               grade('LP',  2) | _]), List).

mth_not_passed_students(List) :-
    findall(X, student(_, X, [_,             grade('MTH', 2) | _]), List).

fp_not_passed_students(List) :-
    findall(X, student(_, X, [_, _,          grade('FP',  2) | _]), List).

inf_not_passed_students(List) :-
    findall(X, student(_, X, [_, _, _,       grade('INF', 2) | _]), List).

eng_not_passed_students(List) :-
    findall(X, student(_, X, [_, _, _, _,    grade('ENG', 2) | _]), List).

psy_not_passed_students(List) :-
    findall(X, student(_, X, [_, _, _, _, _, grade('PSY', 2)    ]), List).

task2() :-
    write("\nStudents that didn't pass logical programming: "),
    lp_not_passed_students(LP),
    write_list(LP),

    write("\n\nStudents that didn't pass mathematics: "),
    mth_not_passed_students(MTH),
    write_list(MTH),

    write("\n\nStudents that didn't pass functional programming: "),
    fp_not_passed_students(FP),
    write_list(FP),

    write("\n\nStudents that didn't pass informatics: "),
    inf_not_passed_students(INF),
    write_list(INF),

    write("\n\nStudents that didn't pass english: "),
    eng_not_passed_students(ENG),
    write_list(ENG),

    write("\n\nStudents that didn't pass psychology: "),
    psy_not_passed_students(PSY),
    write_list(PSY).


% Найти количество не сдавших студентов в каждой из групп

group_examed(GroupNumber, Passed) :-
    group_students(GroupNumber, StudentList),

    lp_not_passed_students(LP),
    mth_not_passed_students(MTH),
    fp_not_passed_students(FP),
    inf_not_passed_students(INF),
    eng_not_passed_students(ENG),
    psy_not_passed_students(PSY),

    append(LP, MTH, T1),
    append(FP, INF, T2),
    append(ENG, PSY, T3),
    append(T1, T2, Temp),
    append(Temp, T3, DidntPass),

    delete_matching(StudentList, DidntPass, Passed).

group_passed_count(GroupNumber, Count) :-
    group_examed(GroupNumber, Passed),
    length(Passed, Count).

group_didnt_pass_count(GroupNumber, Count) :-
    group_count(GroupNumber, StudentCount),
    group_passed_count(GroupNumber, PassedCount),
    Count is StudentCount - PassedCount.

task3() :-
    group_didnt_pass_count(101, C101),
    write(C101),
    write(" students of group 101 didn't pass all the exams... How unfortunate...\n\n"),

    group_didnt_pass_count(102, C102),
    write(C102),
    write(" students of group 102 didn't pass all the exams... How unfortunate...\n\n"),

    group_didnt_pass_count(103, C103),
    write(C103),
    write(" students of group 103 didn't pass all the exams... How unfortunate...\n\n"),

    group_didnt_pass_count(104, C104),
    write(C104),
    write(" students of group 104 didn't pass all the exams... How unfortunate..."),
    !.
