bestfs1RelationEmotional(Orig,Dest,Cam,N,Custo,ListaEmocoes):-
    %(generate_random_edges(); true),
	get_time(Ti),
	bestfs12RelationEmotional(Dest,[([Orig],0)],Cam,N,Custo,ListaEmocoes),!,
	get_time(Tf),
    T is Tf-Ti,
    %(destroy_edges(); true),
	write('Caminho='),write(Cam),nl,
	write('Tempo de geracao da solucao:'),write(T),nl.

bestfs12RelationEmotional(Dest,[([Dest|T],_)|_],Cam,_,Custo,_):-
	reverse([Dest|T],Cam),
	retira_custosRelationEmotional(Cam,Custo).

bestfs12RelationEmotional(Dest,[([Dest|_],_)|LLA2],Cam,N,Custo,ListaEmocoes):-
	!,
        bestfs12RelationEmotional(Dest,LLA2,Cam,N,Custo,ListaEmocoes).

bestfs12RelationEmotional(Dest,LLA,Cam,N,Custo,ListaEmocoes):-
    member1RelationEmotional(LA,LLA,LLA1),
    LA=(LAlist,M),
    LAlist=[Act|_],
    (
        (Act==Dest,!,bestfs12RelationEmotional(Dest,[LA|LLA1],Cam,N,Custo,ListaEmocoes))
	;
	(
	    M1 is M + 1,
	    findall((CEX,CustoX,([X|LAlist],M1)),
                (N>M,
                node(X,Lista),
	        (edge_com_forcas(Act,X,CustoX,_,CustoRelX,_);edge_com_forcas(X,Act,_,CustoX,_,CustoRelX)),
		\+member(X,LAlist),
		verificaEmocoesRelationB(Lista,ListaEmocoes),
                multiCriterioBestFirstRelationEmotional(CustoX, CustoRelX, Resultado),
                estimativaBestFirstRelationEmotional(N,M1,Resultado,Est),
		CEX is Est + Resultado),
		Novos),
	    Novos\==[],!,
            sort(Novos,NovosOrd),
            reverse(NovosOrd, NovosOrdReverse),
	    retira_custosRelationEmotional(NovosOrdReverse,NovosOrd1),
	    append(NovosOrd1,LLA1,LLA2),
	    %write('LLA2='),write(LLA2),nl,
	    bestfs12RelationEmotional(Dest,LLA2,Cam,N,Custo,ListaEmocoes)
	)
    ).

member1RelationEmotional(LA,[LA|LAA],LAA).
member1RelationEmotional(LA,[_|LAA],LAA1):-member1RelationEmotional(LA,LAA,LAA1).

retira_custosRelationEmotional([],[]).
retira_custosRelationEmotional([(_,_,LA)|L],[LA|L1]):-retira_custosRelationEmotional(L,L1).

retira_custosRelationEmotional([Act,X],Resultado):-
    !,
    (edge_com_forcas(Act,X,C,_,CustoRelX,_);edge_com_forcas(X,Act,_,C,_,CustoRelX)),
    multiCriterioBestFirstRelationEmotional(C,CustoRelX,Resultado).

retira_custosRelationEmotional([Act,X|L],S):-
        retira_custosRelationEmotional([X|L],S1),
		(edge_com_forcas(Act,X,C,_,CustoRelX,_);edge_com_forcas(X,Act,_,C,_,CustoRelX)),
        multiCriterioBestFirstRelationEmotional(C,CustoRelX,Resultado),
        S is S1+Resultado.

estimativaBestFirstRelationEmotional(N,M,CustoX,Est):-
    Est is CustoX*(N-M).

multiCriterioBestFirstRelationEmotional(CustoX,CustoRelX,Resultado):-
    CustoRelX1 is CustoRelX + 200,
    CustoRelX2 is CustoRelX1 / 400,
    CustoRelX3 is CustoRelX2 * 100,
    Resultado is (CustoRelX3 + CustoX)/2.


verificaEmocoesRelationB(_, []):- !.

% o T vai ter o aspeto (emoção, valor)
verificaEmocoesRelationB(Lista, [(Emocao,Valor)|L]):-
                                        percorreRelationEmotionalB(Lista, Emocao, V),
                                        (V =< Valor; fail),
                                        verificaEmocoesRelationB(Lista, L).

percorreRelationEmotionalB([], _, _):- !.

percorreRelationEmotionalB([(E, V)|_], E, V):- !.

percorreRelationEmotionalB([(_, _)| T], Emocao, Valor):-
                                    percorreRelationEmotionalB(T, Emocao, Valor).
