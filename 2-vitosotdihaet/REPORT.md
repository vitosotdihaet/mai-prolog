# Отчет по лабораторной работе №2
## по курсу "Логическое программирование"

## Решение логических задач

### студент: Клименко В. М.

## Результат проверки

| Преподаватель     | Дата         |  Оценка       |
|-------------------|--------------|---------------|
| Сошников Д.В. |              |               |
| Левинская М.А.|              |               |

> *Комментарии проверяющих (обратите внимание, что более подробные комментарии возможны непосредственно в репозитории по тексту программы)*


## Введение
Один из главных способов решения логических задач - перебор. Пролог для этого прекрасно подходит с внутреннем устройством данных, которые представляются "деревом".

## Задание
10. В одном городе живут 5 человек. Их имена Леонид, Михаил, Николай, Олег и Петр. Их фамилии Атаров, Бартенев, Кленов, Данилин и Иванов. Бартенев знаком только с двумя из перечисленных мужчин. Петр знаком со всеми, кроме одного. Леонид знаком только с одним из всех. Данилин и Михаил незнакомы. Николай и Иванов знают друг друга. Михаил, Николай и Олег знакомы между собой. Атаров незнаком только с одним из всех. Только один из всех знаком с Кленовым. Назовите имена и фамилии каждого. С кем знаком каждый из них?

## Принцип решения
Составляем переменные с персонами, часть - с именами, часть с фамилиями. 

```prolog
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
```

Унифицируем их между собой перебором.

```prolog
permutation([Leonid, Michael, Nikolay, Oleg, Petr], [Atarov, Bartenev, Klenov, Danilin, Ivanov]),
FullNames = [Leonid, Michael, Nikolay, Oleg, Petr],
```

После этого составляем списки для каждого имени и для каждой фамилии список знакомств, в котором есть сама же персона и все люди с кем он знаком по условию. Неизвестных людей перебираем.

```prolog
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
```

Выводим результат

```prolog
% Назовите имена и фамилии каждого. С кем знаком каждый из них
write(FullNames), nl,

write(LeonidKnows), nl,
write(MichaelKnows), nl,
write(NikolayKnows), nl,
write(OlegKnows), nl,
write(PetrKnows), nl.
```


## Выводы
По окончании работы с лабораторной работой я понял, что логические задачи и правда очень легко, удобно и эффективно решать именно на Прологе, в отличие от других языков программирования. В Прологе не нужно задумываться о том, как представляются данных и как осуществлять перебор, это помогает сосредоточиться на выполнении самой задачи. Вообще очень приятно и удобно использовать компьютер для решения логических задач, потому что на перебор вручную может уйти очень много времени.