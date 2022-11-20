aStarConnectionEmotional(Orig,Dest,N,Cam,Custo,ListaEmocoes):-
    %(generate_random_edges(); true),
    get_time(Ti),
    aStar2ConnectionEmotional(Dest,[(_,0,[Orig],0)],N,Cam,Custo,ListaEmocoes),
    get_time(Tf),
    T is Tf-Ti,
    %(destroy_edges(); true),
    write(Cam),
    write('Tempo de geracao da solucao:'),write(T),nl.

aStar2ConnectionEmotional(Dest,[(_,Custo,[Dest|T],_)|_],_,Cam,Custo,_):-
    !,
    reverse([Dest|T],Cam).

aStar2ConnectionEmotional(Dest,[(_,Ca,LA,M)|Outros],N,Cam,Custo,ListaEmocoes):-
    LA=[Act|_],
    M1 is M + 1,
    findall((CEX,CaX,[X|LA],M1),
        (Dest\==Act,
        N>M,
        node(X,Lista),
        (edge_com_forcas(Act,X,CustoX,_,_,_);edge_com_forcas(X,Act,_,CustoX,_,_)),
        \+member(X,LA),
        verificaEmocoesConnection(Lista,ListaEmocoes),
        CaX is CustoX + Ca,
        estimativaAStarConnectionEmotional(N,M1,CustoX,Est),
        CEX is CaX + Est),
        Novos),
    append(Outros,Novos,Todos),
    sort(Todos,TodosOrd),
    reverse(TodosOrd, TodosOrdReverse),
    aStar2ConnectionEmotional(Dest,TodosOrdReverse,N,Cam,Custo, ListaEmocoes).

estimativaAStarConnectionEmotional(N,M,CustoX,Est):-
    Est is CustoX*(N-M).

verificaEmocoesConnection(_, []):- !.

% o T vai ter o aspeto (emocao, valor)
verificaEmocoesConnection(Lista, [(Emocao,Valor)|L]):-
                                        percorreConnectionEmotional(Lista, Emocao, V),
                                        (V =< Valor; fail),
                                        verificaEmocoesConnection(Lista, L).

percorreConnectionEmotional([], _, _):- !.

percorreConnectionEmotional([(E, V)|_], E, V):- !.

percorreConnectionEmotional([(_, _)| T], Emocao, Valor):-
                                    percorreConnectionEmotional(T, Emocao, Valor).
