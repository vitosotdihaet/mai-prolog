% Standard predicates for list processing
my_length([], 0).
my_length([_ | T], N) :-
    my_length(T, N1),
    N is N1 + 1.

my_member([X | _], X) :- !.
my_member([_ | T], X) :-
    my_member(T, X).

my_append([], List1, List1).
my_append([X | List1], List2, [X | Result]) :-
    my_append(List1, List2, Result).

my_delete([X | WithoutX], X, WithoutX).
my_delete([Other | WithX], X, [Other | WithoutX]) :-
    my_delete(WithX, X, WithoutX).

my_permutation([], []).
my_permutation(List, [X | Permutation]) :-
    my_delete(List, X, Other),
    my_permutation(Other, Permutation).

my_sublist([], _) :- !.
my_sublist(Sublist, List) :-
    my_append(Sublist, _, Temp),
    my_append(_, Temp, List), !.


% 11. Удаление элемента с заданным номером
% With standard predicates
delete_at(1, [_ | List], List) :- !.
delete_at(Index, [H | List], [H | Result]) :-
    length([H | List], Length),
    Index =< Length, Index > 0,
    NewIndex is Index - 1,
    delete_at(NewIndex, List, Result).

% With custom predicates
my_delete_at(1, [_ | List], List) :- !.
my_delete_at(Index, [H | List], [H | Result]) :-
    my_length([H | List], Length),
    Index =< Length, Index > 0,
    NewIndex is Index - 1,
    my_delete_at(NewIndex, List, Result).


% 16. Вычисление суммы двух векторов-списков (с учетом возможного несовпадения размерностей)
sum([], List, List) :- !.
sum(List, [], List) :- !.
sum([N1 | T1], [N2 | T2], [Sum | T]) :-
    Sum is N1 + N2,
    sum(T1, T2, T).
