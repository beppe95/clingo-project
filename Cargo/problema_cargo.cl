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
% ~ Generazione conoscenza
    1 { carica(C,P,A,t) : merci(C), aereo(P), aeroporto(A);
        scarica(C,P,A,t) : merci(C), aereo(P), aeroporto(A);
        vola(P,F,T,t) : aereo(P), aeroporto(F), aeroporto(T) }. % possiamo cambiare il numero massimo di mosse per turno


% ~ Test (Precondizioni)
    %* Se al tempo t-1 la merce oppure l'aereo non sono presenti in quell'aeroporto,
       al tempo t non è possibile caricare una merce su di un aereo in un aeroporto *%
    :- carica(C,P,A,t), not posizione(C,A,t-1).
    :- carica(C,P,A,t), not posizione(P,A,t-1).
    %  Non è possibile caricare e volare nello stesso turno dallo stesso aeroporto con lo stesso aereo
    :- carica(C,P,A,t-1), vola(P,A,T,t-1).

    %* Se al tempo t-1 la merce non è presente all'interno dell'aereo oppure se l'aereo non è presente in quell'aeroporto,
       al tempo t non è possibile scaricare la merce dall'aereo *%
    :- scarica(C,P,A,t), not in(C,P,t-1).
    :- scarica(C,P,A,t), not posizione(P,A,t-1).
    %  Non è possibile scaricare e volare nello stesso turno dallo stesso aeroporto con lo stesso aereo
    :- scarica(C,P,A,t-1), vola(P,F,A,t-1).

    %* Non è possibile che un aereo parta da una posizione al tempo t
      se al tempo t-1 non si trovava in quella posizione  *%
    :- vola(P,F,T,t), not posizione(P,F,t-1).

% ~ Determinazione (Effetti)
    %  Se un pacco è stato caricato su un aereo al tempo t, allora non si troverà più nell'aeroporto al tempo t
    -posizione(C,A,t) :- carica(C,P,A,t).
    in(C,P,t) :- carica(C,P,A,t).

     % Se un pacco è stato scaricato su un aereo al tempo t, allora non si troverà più nell'aeroporto al tempo t
     posizione(C,A,t) :- scarica(C,P,A,t).
     -in(C,P,t) :- scarica(C,P,A,t).

     % Se un aereo vola, la posizione cambia di conseguenza
    -posizione(P,F,t) :- vola(P,F,T,t).
     posizione(P,T,t) :- vola(P,F,T,t).

% ~  PROBLEMA NO-OP
    % Se un aereo o una merce non si sono mossi dalla loro posizione, allora specifichiamo che sono rimasti nello stesso posto
    posizione(X,Y,t) :- posizione(X,Y,t-1), not -posizione(X,Y,t).
    in(X,Y,t) :- in(X,Y,t-1), not -in(X,Y,t).

% ~  GOAL (Obiettivo)
% La soluzione è completa e consistente se al tempo t le posizioni di c1 e c2 sono rispettivamente jfk e sfo.
% (Controlla che non possa non essere così)
#program check(t).
    :- not posizione(c1,jfk,t), query(t).
    :- not posizione(c2,sfo,t), query(t).


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
