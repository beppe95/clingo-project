citta(A..C).
squadra(1..9).
tempo(1..100).

incontro(citta, data, sq1, sq2).

1 { appartiene(C, S) : citta(C) } 1 :- squadra(S).
3 { appartiene(C, S) : squadra(S) } 3 :- citta(C).
0 { incontro(C, T, S1, S2) } :- squadra(S1), squadra(S2)


:- incontro(_, _, S, S).
:- incontro(_, Ta, Sa1, Sa2), incontro(_, Tb, Sb1, Sb2), Ta == Tb, Sa1 == Sb1.
:- incontro(_, Ta, Sa1, Sa2), incontro(_, Tb, Sb1, Sb2), Ta == Tb, Sa2 == Sb2.
:- appartiene(C, S),

:- 
appartiene(C, S),
incontro(_, N).


