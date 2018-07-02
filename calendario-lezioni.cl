studente(1..170).
docente(mario; lamberto; cesare; giuseppe; giovanni).
anno(1..3).

aula(A, 20).
aula(B, 25).
aula(C, 35).
aula(D, 40).
aula(E, 50).

giorno(lun; mar; mer; giov; ven).
orario(9, 11; 11, 13; 14, 16; 16, 18).

corso(A, 1, 6).
corso(B, 1, 6).
corso(C, 1, 6).
corso(D, 1, 6).
corso(E, 2, 6).
corso(F, 2, 6).
corso(G, 2, 6).
corso(H, 2, 6).
corso(I, 3, 6).
corso(J, 3, 6).
corso(K, 3, 6).
corso(L, 3, 6).

1 { aulaOccupata(Aula, Corso, Giorno, OraInizio, OraFine) : corso(Corso, _, _) } 1 :- aula(Aula, Spazio), giorno(Giorno), orario(OraInizio, OraFine).

:- aulaOccupata(_, Corso1, Giorno, OraInizio, OraFine), aulaOccupata(_, Corso2, Giorno, OraInizio, OraFine), 
    insegna(Docente1, Corso1), insegna(Docente2, Corso2), Docente1 == Docente2.