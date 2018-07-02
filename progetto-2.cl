studente(AA..ZZ).
docente(mario; lamberto; cesare; giuseppe; giovanni).
anno(1..3).

corso(A, 1).
corso(B, 1).
corso(C, 1).
corso(D, 1).
corso(E, 2).
corso(F, 2).
corso(G, 2).
corso(H, 2).
corso(I, 3).
corso(J, 3).
corso(K, 3).
corso(L, 3).

1 { frequentaAnno(Studente, Anno) : anno(Anno) } 1:- studente(Studente).

1 { insegna(Docente, Corso1), insegna(Docente, Corso2) : docente(Docente) } 1:- corso(Corso1, _), corso(Corso2, _), Corso1 != Corso2.

:- docente(Docente1), docente(Docente2), Docente1 != Docente2, insegna(Docente1, corso), insegna(Docente2, corso).

conteggioCorsi(Docente, N) :- docente(Docente), N = #count{ Corso : insegna(Docente, Corso) }.

conteggio(N) :- N = #count{conteggioCorsi(Docente, K)}, K > 2.

vero :- conteggio(N), N > 2.

:- not vero.