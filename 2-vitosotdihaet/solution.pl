% В одном городе живут 5 человек.

% Их имена Леонид, Михаил, Николай, Олег и Петр.
is_name(leonid).
is_name(michael).
is_name(nikolay).
is_name(oleg).
is_name(petr).

% Их фамилии Атаров, Бартенев, Кленов, Данилин и Иванов.
is_surname(atarov).
is_surname(bartenev).
is_surname(klenov).
is_surname(danilin).
is_surname(ivanov).


solve :-
    Leonid = [leonid, LeonidSurname], is_surname(LeonidSurname),
    Michael = [michael, MichaelSurname], is_surname(MichaelSurname),
    Nikolay = [nikolay, NikolaySurname], is_surname(NikolaySurname),
    Oleg = [oleg, OlegSurname], is_surname(OlegSurname),
    Petr = [petr, PetrSurname], is_surname(PetrSurname),

    Atarov = [AtarovName, atarov], is_name(AtarovName),
    Bartenev = [BartenevName, bartenev], is_name(BartenevName),
    Klenov = [KlenovName, klenov], is_name(KlenovName),
    Danilin = [DanilinName, danilin], is_name(DanilinName),
    Ivanov = [IvanovName, ivanov], is_name(IvanovName),
    
    permutation([Leonid, Michael, Nikolay, Oleg, Petr], [Atarov, Bartenev, Klenov, Danilin, Ivanov]),
    FullNames = [Leonid, Michael, Nikolay, Oleg, Petr],

    write(FullNames), nl,


    % Леонид знаком только с одним из всех.
    LeonidKnows = [Leonid, L1],
    member(L1, FullNames),
    % Данилин и Михаил незнакомы.
    % Михаил, Николай и Олег знакомы между собой
    MichaelKnows = [Michael, Nikolay, Oleg, M1],
    \+ member(Danilin, MichaelKnows),
    (member(M1, FullNames) ; \+ member(M1, FullNames)),
    % Николай и Иванов знают друг друга
    % Михаил, Николай и Олег знакомы между собой
    NikolayKnows = [Nikolay, Ivanov, Michael, Oleg, N1],
    (member(N1, FullNames) ; \+ member(N1, FullNames)),
    % Михаил, Николай и Олег знакомы между собой
    OlegKnows = [Oleg, Michael, Nikolay, O1, O2],
    (member(O1, FullNames) ; member(O2, FullNames) ; \+ member(O1, FullNames) ; \+ member(O2, FullNames)),
    % Петр знаком со всеми, кроме одного.
    PetrKnows = [Petr, P1, P2, P3],
    member(P1, FullNames), member(P2, FullNames), member(P3, FullNames),


    % Атаров незнаком только с одним из всех.
    AtarovKnows = [Atarov, A1, A2, A3],
    member(A1, FullNames), member(A2, FullNames), member(A3, FullNames),
    % Бартенев знаком только с двумя из перечисленных мужчин.
    BartenevKnows = [Bartenev, B1, B2],
    member(B1, FullNames), member(B2, FullNames),
    % Только один из всех знаком с Кленовым.
    KlenovKnows = [Klenov, K1],
    member(K1, FullNames),
    % Данилин и Михаил незнакомы.
    DanilinKnows = [Danilin, D1, D2, D3],
    \+ member(Michael, DanilinKnows),
    (member(D1, FullNames) ; member(D2, FullNames) ; member(D3, FullNames)),
    IvanovKnows = [Ivanov, Nikolay, I1, I2, I3],
    (member(I1, FullNames) ; member(I2, FullNames) ; member(I3, FullNames) ; \+ member(I1, FullNames); \+ member(I2, FullNames); \+ member(I3, FullNames)),

    % Назовите имена и фамилии каждого. С кем знаком каждый из них
    write(FullNames), nl,

    write(LeonidKnows), nl,
    write(MichaelKnows), nl,
    write(NikolayKnows), nl,
    write(OlegKnows), nl,
    write(PetrKnows), nl.

?- solve.
