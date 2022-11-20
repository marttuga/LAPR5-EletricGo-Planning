aStarRelation(Orig,Dest,N,Cam,Custo):-
    %(generate_random_edges(); true),
    get_time(Ti),
    aStar2Relation(Dest,[(_,0,[Orig],0)],N,Cam,Custo),
    get_time(Tf),
    T is Tf-Ti,
    %(destroy_edges(); true),
    write(Cam),
    write('Tempo de geracao da solucao:'),write(T),nl.

aStar2Relation(Dest,[(_,Custo,[Dest|T],_)|_],_,Cam,Custo):-
    !,
    reverse([Dest|T],Cam).

aStar2Relation(Dest,[(_,Ca,LA,M)|Outros],N,Cam,Custo):-
    LA=[Act|_],
    M1 is M + 1,
    findall((CEX,CaX,[X|LA],M1),
        (Dest\==Act,
        N>M,
        (edge_com_forcas(Act,X,CustoX,_,CustoRelX,_);edge_com_forcas(X,Act,_,CustoX,_,CustoRelX)),
        \+member(X,LA),
        multiCriterioAStarRelation(CustoX, CustoRelX, Resultado),
        CaX is Resultado + Ca ,
        estimativaAStarRelation(N,M1,Resultado,Est),
        CEX is CaX + Est),
        Novos),
    append(Outros,Novos,Todos),
    sort(Todos,TodosOrd),
    reverse(TodosOrd, TodosOrdReverse),
    aStar2Relation(Dest,TodosOrdReverse,N,Cam,Custo).

estimativaAStarRelation(N,M,CustoX,Est):-
    Est is CustoX*(N-M).

multiCriterioAStarRelation(CustoX,CustoRelX,Resultado):-
    CustoRelX1 is CustoRelX + 200,
    CustoRelX2 is CustoRelX1 / 400,
    CustoRelX3 is CustoRelX2 * 100,
    Resultado is (CustoRelX3 + CustoX)/2.
