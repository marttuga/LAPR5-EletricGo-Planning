bestfs1Relation(Orig,Dest,Cam,N,Custo):-
    %(generate_random_edges(); true),
	get_time(Ti),
	bestfs12Relation(Dest,[([Orig],0)],Cam,N,Custo),!,
	get_time(Tf),
    T is Tf-Ti,
    %(destroy_edges(); true),
	write('Caminho='),write(Cam),nl,
	write('Tempo de geracao da solucao:'),write(T),nl.

bestfs12Relation(Dest,[([Dest|T],_)|_],Cam,_,Custo):-
	reverse([Dest|T],Cam),
	calcula_custoRelation(Cam,Custo).

bestfs12Relation(Dest,[([Dest|_],_)|LLA2],Cam,N,Custo):-
	!,
        bestfs12Relation(Dest,LLA2,Cam,N,Custo).

bestfs12Relation(Dest,LLA,Cam,N,Custo):-
    member1Relation(LA,LLA,LLA1),
    LA=(LAlist,M),
    LAlist=[Act|_],
    (
        (Act==Dest,!,bestfs12Relation(Dest,[LA|LLA1],Cam,N,Custo))
	;
	(
	    M1 is M + 1,
	    findall((CEX,CustoX,([X|LAlist],M1)),
                (N>M,
	        (edge_com_forcas(Act,X,CustoX,_,CustoRelX,_);edge_com_forcas(X,Act,_,CustoX,_,CustoRelX)),
		\+member(X,LAlist),
                multiCriterioBestFirstRelation(CustoX, CustoRelX, Resultado),
                estimativaBestFirstRelation(N,M1,Resultado,Est),
		CEX is Est + Resultado),
		Novos),
	    Novos\==[],!,
            sort(Novos,NovosOrd),
            reverse(NovosOrd, NovosOrdReverse),
	    retira_custosRelation(NovosOrdReverse,NovosOrd1),
	    append(NovosOrd1,LLA1,LLA2),
	    %write('LLA2='),write(LLA2),nl,
	    bestfs12Relation(Dest,LLA2,Cam,N,Custo)
	)
    ).

member1Relation(LA,[LA|LAA],LAA).
member1Relation(LA,[_|LAA],LAA1):-member1Relation(LA,LAA,LAA1).

retira_custosRelation([],[]).
retira_custosRelation([(_,_,LA)|L],[LA|L1]):-retira_custosRelation(L,L1).

calcula_custoRelation([Act,X],Resultado):-
    !,
    (edge_com_forcas(Act,X,C,_,CustoRelX,_);edge_com_forcas(X,Act,_,C,_,CustoRelX)),
    multiCriterioBestFirstRelation(C,CustoRelX,Resultado).

calcula_custoRelation([Act,X|L],S):-
        calcula_custoRelation([X|L],S1),
		(edge_com_forcas(Act,X,C,_,CustoRelX,_);edge_com_forcas(X,Act,_,C,_,CustoRelX)),
        multiCriterioBestFirstRelation(C,CustoRelX,Resultado),
        S is S1+Resultado.

estimativaBestFirstRelation(N,M,CustoX,Est):-
    Est is CustoX*(N-M).

multiCriterioBestFirstRelation(CustoX,CustoRelX,Resultado):-
    CustoRelX1 is CustoRelX + 200,
    CustoRelX2 is CustoRelX1 / 400,
    CustoRelX3 is CustoRelX2 * 100,
    Resultado is (CustoRelX3 + CustoX)/2.
