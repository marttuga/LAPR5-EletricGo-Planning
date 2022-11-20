aStarConnection(Orig,Dest,N,Cam,Custo):-
    %(generate_random_edges(); true),
    get_time(Ti),
    aStar2Connection(Dest,[(_,0,[Orig],0)],N,Cam,Custo),
    get_time(Tf),
    T is Tf-Ti,
    %(destroy_edges(); true),
    write(Cam),
    write('Tempo de geracao da solucao:'),write(T),nl.

aStar2Connection(Dest,[(_,Custo,[Dest|T],_)|_],_,Cam,Custo):-
    !,
    reverse([Dest|T],Cam).

aStar2Connection(Dest,[(_,Ca,LA,M)|Outros],N,Cam,Custo):-
    LA=[Act|_],
    M1 is M + 1,
    findall((CEX,CaX,[X|LA],M1),
        (Dest\==Act,
        N>M,
        (edge_com_forcas(Act,X,CustoX,_,_,_);edge_com_forcas(X,Act,_,CustoX,_,_)),
        \+member(X,LA),
        CaX is CustoX + Ca,
        estimativaAStarConnection(N,M1,CustoX,Est),
        CEX is CaX + Est),
        Novos),
    append(Outros,Novos,Todos),
    sort(Todos,TodosOrd),
    reverse(TodosOrd, TodosOrdReverse),
    aStar2Connection(Dest,TodosOrdReverse,N,Cam,Custo).

estimativaAStarConnection(N,M,CustoX,Est):-
    Est is CustoX*(N-M).
