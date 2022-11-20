aStarRelationEmotional(Orig,Dest,N,Cam,Custo,ListaEmocoes):-
    %(generate_random_edges(); true),
    get_time(Ti),
    aStar2RelationEmotional(Dest,[(_,0,[Orig],0)],N,Cam,Custo,ListaEmocoes),
    get_time(Tf),
    T is Tf-Ti,
    %(destroy_edges(); true),
    write(Cam),
    write('Tempo de geracao da solucao:'),write(T),nl.

aStar2RelationEmotional(Dest,[(_,Custo,[Dest|T],_)|_],_,Cam,Custo,_):-
    !,
    reverse([Dest|T],Cam).

aStar2RelationEmotional(Dest,[(_,Ca,LA,M)|Outros],N,Cam,Custo,ListaEmocoes):-
    LA=[Act|_],
    M1 is M + 1,
    findall((CEX,CaX,[X|LA],M1),
        (Dest\==Act,
        N>M,
        node(X,Lista),
        (edge_com_forcas(Act,X,CustoX,_,CustoRelX,_);edge_com_forcas(X,Act,_,CustoX,_,CustoRelX)),
        \+member(X,LA),
        verificaEmocoesRelation(Lista,ListaEmocoes),
        multiCriterioAStarRelationEmotional(CustoX, CustoRelX, Resultado),
        CaX is Resultado + Ca,
        estimativaAStarRelationEmotional(N,M1,Resultado,Est),
        CEX is CaX + Est),
        Novos),
    append(Outros,Novos,Todos),
    sort(Todos,TodosOrd),
    reverse(TodosOrd, TodosOrdReverse),
    aStar2RelationEmotional(Dest,TodosOrdReverse,N,Cam,Custo,ListaEmocoes).

estimativaAStarRelationEmotional(N,M,CustoX,Est):-
    Est is CustoX*(N-M).

multiCriterioAStarRelationEmotional(CustoX,CustoRelX,Resultado):-
    CustoRelX1 is CustoRelX + 200,
    CustoRelX2 is CustoRelX1 / 400,
    CustoRelX3 is CustoRelX2 * 100,
    Resultado is (CustoRelX3 + CustoX)/2.

verificaEmocoesRelation(_, []):- !.

% o T vai ter o aspeto (emoção, valor)
verificaEmocoesRelation(Lista, [(Emocao,Valor)|L]):-
                                        percorreRelationEmotional(Lista, Emocao, V),
                                        (V =< Valor; fail),
                                        verificaEmocoesRelation(Lista, L).

percorreRelationEmotional([], _, _):- !.

percorreRelationEmotional([(E, V)|_], E, V):- !.

percorreRelationEmotional([(_, _)| T], Emocao, Valor):-
                                    percorreRelationEmotional(T, Emocao, Valor).
