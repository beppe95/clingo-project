%*
Init(posizione(C1, SFO) ∧ posizione(C2, JFK ) ∧ posizione(P1, SFO) ∧ posizione(P2, JFK )
    ∧ merci(C1) ∧ merci(C2) ∧ aereo(P1) ∧ aereo(P2)
    ∧ aeroporto(JFK ) ∧ aeroporto(SFO))

Obiettivo(posizione(C1, JFK ) ∧ posizione(C2, SFO))

Azione(carica(c, p, a),
    PRECOND: posizione(c, a) ∧ posizione(p, a) ∧ merci(c) ∧ aereo(p) ∧ aeroporto(a)
    EFFETTO: ¬ posizione(c, a) ∧ In(c, p))

Azione(scarica(c, p, a),
    PRECOND: In(c, p) ∧ posizione(p, a) ∧ merci(c) ∧ aereo(p) ∧ aeroporto(a)
    EFFETTO: posizione(c, a) ∧ ¬ In(c, p))

Azione(vola(p, da, a),
    PRECOND: posizione(p, da) ∧ aereo(p) ∧ aeroporto(da) ∧ aeroporto(a)
    EFFETTO: ¬ posizione(p, da) ∧ posizione(p, a))
*%


#include <incmode>. % Abilita la modalità di computazione incrementale

#program base.
    posizione(c1,sfo,0).
    posizione(c2,jfk,0).
    posizione(p1,sfo,0).
    posizione(p2,jfk,0).
    merci(c1).
    merci(c2).
    aereo(p1).
    aereo(p2).
    aeroporto(jfk).
    aeroporto(sfo).


#program step(t).
    % ~ Generate
    1 { carica(C,P,A,t) : merci(C), aereo(P), aeroporto(A);
        scarica(C,P,A,t) : merci(C), aereo(P), aeroporto(A);
        vola(P,F,T,t) : aereo(P), aeroporto(F), aeroporto(T) } 1. % possiamo cambiare il numero massimo di mosse per turno

    % ~ Test (Precondizioni)

    % Al tempo t non è possibile caricare una merce su di un aereo in un aeroporto,
    %  se al tempo t-1 la merce oppure l'aereo non sono presenti in quell'aeroporto
    :- carica(C,P,A,t), not posizione(C,A,t-1).
    :- carica(C,P,A,t), not posizione(P,A,t-1).

    % Al tempo t non è possibile scaricare una merce su di un aereo in un aeroporto,
    %  se al tempo t-1 la merce non è presente all'interno dell'aereo
    % oppure se l'aereo non è presente in quell'aeroporto
    :- scarica(C,P,A,t), not in(C,P,t-1).
    :- scarica(C,P,A,t), not posizione(P,A,t-1).

    % Al tempo t non è possibile che un aereo parta da una posizione,
    % se al tempo t-1 non si trovava in quella posizione
    :- vola(P,F,T,t), not posizione(P,F,t-1).

    % ~ Define (Effetti)
    % Se un pacco è stato caricato su un aereo al tempo t, allora non si troverà più nell'aeroporto
    % -posizione(C,P,t) :- carica(C,P,A,t).
    -posizione(C,A,t) :- carica(C,P,A,t).
     in(C,P,t) :- carica(C,P,A,t).

     % ~ Define (Effetti)
     % Se un pacco è stato scaricato su un aereo al tempo t, allora non si troverà più nell'aeroporto
     % -posizione(C,P,t) :- carica(C,P,A,t).
     posizione(C,A,t) :- scarica(C,P,A,t).
     -in(C,P,t) :- scarica(C,P,A,t).
    % -in(C,A,t) :- scarica(C,P,A,t).

    -posizione(P,F,t) :- vola(P,F,T,t).
     posizione(P,T,t) :- vola(P,F,T,t).

    % inertia, PROBLEMA NO-OP. Precondizione di disuguaglianza per affermare che gli aereoporti da e a devono essere diversi

    posizione(X,Y,t) :- posizione(X,Y,t-1), not -posizione(X,Y,t).
    in(X,Y,t) :- in(X,Y,t-1), not -in(X,Y,t).

#program check(t).
    :- not posizione(c1,jfk,t), query(t).
    :- not posizione(c2,sfo,t), query(t).
