% Docenti, Corsi, Semestre, CFU (# slot), Anno
insegnamento(
    viola, analisi, 2, 9, 1;
    gaeta, architettura, 2, 9, 1;
    grosso, cmro, 1, 6, 1;
    cardone, progI, 1, 9, 1;
    baldoni, progII, 2, 9, 1;
    griffin, inglese, 1, 3, 1;
    roggero, mdl, 1, 12, 1;
    pironti, economia, 2, 9, 2;
    pensa, db, 2, 9, 2;
    pozzato, algoritmi, 2, 9, 2;
    dambrosio, statistica, 1, 6, 2;
    migliore, fisica, 1, 6, 2;
    zacchi, lft, 1, 9, 2;
    gunetti, so, 1, 12, 2;
    ronchi, logica, 1, 6, 3;
    ardissono, progIII, 2, 6, 3;
    sereno, reti, 1, 6, 3;
    sacco, ium, 2, 6, 3;
    ardissono, sWeb, 1, 6, 3;
    bergadano, sicurezza, 2, 6, 3;
    micalizio, sisInf, 1, 6, 3;
    % baroglio, sisInt, 2, 6, 3;
    % cardone, storia, 1, 6, 3;
    % baldoni, sas, 2, 9, 3;
    % ardissono, tWeb, 1, 6, 3
    % cardone, lpp, 2, 6, 3;
    % deliguoro, mfi, 2, 6, 3;
    ).

% Aule
aula(a; b; c; d; e; f).

% Giorno e Orario
giorno(lun; mar; mer; gio; ven).
orario(9, 11; 11, 13; 14, 16; 16, 18).

% Slot aule
1 { slot(Giorno, Aula, Inizio, Fine, Corso, Semestre, Docente, Anno) :  insegnamento(Docente, Corso, Semestre, _, Anno) } 1 :-
    orario(Inizio, Fine), giorno(Giorno), aula(Aula).

% Associazione slot per corso corretta
conteggio_slot(Corso, Conteggio) :-
    Conteggio = #count{ Giorno, Inizio, Fine : slot(Giorno, _, Inizio, Fine, Corso, _, _, _) },
    slot(_, _, _, _, Corso, _, _, _).

slot_CFU_corretti :- conteggio_slot(Corso, Conteggio), insegnamento(_, Corso, _, Conteggio, _).
:- not slot_CFU_corretti.


% Nella stessa aula, nello stesso momento, non vi può essere più di un docente
:- slot(Giorno1, Aula1, Inizio1, Fine1, _, Semestre1, Docente1, _), slot(Giorno2, Aula2, Inizio2, Fine2, _, Semestre2, Docente2, _),
    Giorno1 == Giorno2,
    Aula1 == Aula2,
    Inizio1 == Inizio2,
    Fine1 == Fine2,
    Semestre1 == Semestre2,
    Docente1 != Docente2.


% Un docente non può essere, nello stesso momento, in più aule diverse
:- slot(Giorno1, Aula1, Inizio1, Fine1, _, Semestre1, Docente1, _), slot(Giorno2, Aula2, Inizio2, Fine2, _, Semestre2, Docente2, _),
    Giorno1 == Giorno2,
    Inizio1 == Inizio2,
    Fine1 == Fine2,
    Semestre1 == Semestre2,
    Docente1 == Docente2,
    Aula1 != Aula2.


% Non possono esserci più corsi per la stessa aula nello stesso momento
:- slot(Giorno1, Aula1, Inizio1, Fine1, Corso1, Semestre1, _, _), slot(Giorno2, Aula2, Inizio2, Fine2, Corso2, Semestre2, _, _),
    Giorno1 == Giorno2,
    Inizio1 == Inizio2,
    Fine1 == Fine2,
    Semestre1 == Semestre2,
    Aula1 == Aula2,
    Corso1 != Corso2.


% Lo stesso corso non può essere svolto in aule diverse nello stesso momento
:- slot(Giorno1, Aula1, Inizio1, Fine1, Corso1, Semestre1, _, _), slot(Giorno2, Aula2, Inizio2, Fine2, Corso2, Semestre2, _, _),
    Giorno1 == Giorno2,
    Inizio1 == Inizio2,
    Fine1 == Fine2,
    Semestre1 == Semestre2,
    Corso1 == Corso2,
    Aula1 != Aula2.


% Divisione slot per semestri
:- insegnamento(_, Corso, Semestre1, _, _), slot(_, _, _, _, Corso, Semestre2, _, _),
    Semestre1 != Semestre2.


% Nello stesso momento non possono esserci due corsi diversi dello stesso anno
:- insegnamento(_, Corso1, _, _, Anno), insegnamento(_, Corso2, _, _, Anno),
    slot(Giorno, _, Inizio, Fine, Corso1, Semestre, _, _), slot(Giorno, _, Inizio, Fine, Corso2, Semestre, _, _),
    Corso1 != Corso2.

% Un corso che compare più di una volta nello stesso giorno, compare nella stessa aula
:- slot(Giorno, Aula1, _, _, Corso, Semestre, Docente, _), slot(Giorno, Aula2, _, _, Corso, Semestre, Docente, _),
    Aula1 != Aula2.

% Un corso che compare più di una volta nello stesso giorno, deve avere orari consecutivi
conteggioMateriaPerGiorno(Conteggio, Corso, Giorno) :-
    Conteggio = #count{ Inizio, Fine : slot(Giorno, _, Inizio, Fine, Corso, Semestre, Docente, _) },
    slot(Giorno, _, _, _, Corso, _, Docente, _).

:- conteggioMateriaPerGiorno(Conteggio, _, _), Conteggio > 2.


% Un corso che compare più di una volta nello stesso giorno, deve avere orari consecutivi
% :- slot(Giorno, _, Inizio1, Fine1, Corso, Semestre, Docente, _), slot(Giorno, _, Inizio2, Fine2, Corso, Semestre, Docente, _),
%    Fine1 != Inizio2.
% Con questa regola, non esiste un assegnamento completo e consistente


#show slot/8.