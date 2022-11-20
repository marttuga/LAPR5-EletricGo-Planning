bestfs1Connection(Orig,Dest,Cam,N,Custo):-
    %(generate_random_edges(); true),
	get_time(Ti),
	bestfs12Connection(Dest,[([Orig],0)],Cam,N,Custo),!,
	get_time(Tf),
    T is Tf-Ti,
    %(destroy_edges(); true),
	write('Caminho='),write(Cam),nl,
	write('Tempo de geracao da solucao:'),write(T),nl.

bestfs12Connection(Dest,[([Dest|T],_)|_],Cam,_,Custo):-
	reverse([Dest|T],Cam),
	calcula_custoConnection(Cam,Custo).

bestfs12Connection(Dest,[([Dest|_],_)|LLA2],Cam,N,Custo):-
	!,
	bestfs12Connection(Dest,LLA2,Cam,N,Custo).

bestfs12Connection(Dest,LLA,Cam,N,Custo):-
    member1Connection(LA,LLA,LLA1),
    LA=(LAlist,M),
    LAlist=[Act|_],
    (
        (Act==Dest,!,bestfs12Connection(Dest,[LA|LLA1],Cam,N,Custo))
	;
	(
	    M1 is M + 1,
	    findall((CEX,CustoX,([X|LAlist],M1)),
                (N>M,
	        (edge_com_forcas(Act,X,CustoX,_,_,_);edge_com_forcas(X,Act,_,CustoX,_,_)),
		\+member(X,LAlist),
                estimativaBestFirstConnection(N,M1,CustoX,Est),
		CEX is Est + CustoX),
		Novos),
	    Novos\==[],!,
            sort(Novos,NovosOrd),
            reverse(NovosOrd, NovosOrdReverse),
	    retira_custosConnection(NovosOrdReverse,NovosOrd1),
	    append(NovosOrd1,LLA1,LLA2),
	    %write('LLA2='),write(LLA2),nl,
	    bestfs12Connection(Dest,LLA2,Cam,N,Custo)
	)
    ).

member1Connection(LA,[LA|LAA],LAA).
member1Connection(LA,[_|LAA],LAA1):-member1Connection(LA,LAA,LAA1).

retira_custosConnection([],[]).
retira_custosConnection([(_,_,LA)|L],[LA|L1]):-retira_custosConnection(L,L1).

calcula_custoConnection([Act,X],C):-
    !,
    (edge_com_forcas(Act,X,C,_,_,_);edge_com_forcas(X,Act,_,C,_,_)).

calcula_custoConnection([Act,X|L],S):-
        calcula_custoConnection([X|L],S1),
		(edge_com_forcas(Act,X,C,_,_,_);edge_com_forcas(X,Act,_,C,_,_)),
        S is S1+C.

estimativaBestFirstConnection(N,M,CustoX,Est):-
    Est is CustoX*(N-M).
