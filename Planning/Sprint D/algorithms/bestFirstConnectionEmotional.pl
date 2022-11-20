bestfs1ConnectionEmotional(Orig,Dest,Cam,N,Custo,ListaEmocoes):-
    %(generate_random_edges(); true),
	get_time(Ti),
	bestfs12ConnectionEmotional(Dest,[([Orig],0)],Cam,N,Custo,ListaEmocoes),!,
	get_time(Tf),
    T is Tf-Ti,
    %(destroy_edges(); true),
	write('Caminho='),write(Cam),nl,
	write('Tempo de geracao da solucao:'),write(T),nl.

bestfs12ConnectionEmotional(Dest,[([Dest|T],_)|_],Cam,_,Custo,_):-
	reverse([Dest|T],Cam),
	calcula_custoConnectionEmotional(Cam,Custo).

bestfs12ConnectionEmotional(Dest,[([Dest|_],_)|LLA2],Cam,N,Custo,ListaEmocoes):-
	!,
	bestfs12ConnectionEmotional(Dest,LLA2,Cam,N,Custo,ListaEmocoes).

bestfs12ConnectionEmotional(Dest,LLA,Cam,N,Custo,ListaEmocoes):-
    member1ConnectionEmotional(LA,LLA,LLA1),
    LA=(LAlist,M),
    LAlist=[Act|_],
    (
        (Act==Dest,!,bestfs12ConnectionEmotional(Dest,[LA|LLA1],Cam,N,Custo,ListaEmocoes))
	;
	(
	    M1 is M + 1,
	    findall((CEX,CustoX,([X|LAlist],M1)),
                (N>M,
		 node(X,Lista),
	        (edge_com_forcas(Act,X,CustoX,_,_,_);edge_com_forcas(X,Act,_,CustoX,_,_)),
		\+member(X,LAlist),
		 verificaEmocoesConnectionB(Lista,ListaEmocoes),
                estimativaBestFirstConnectionEmotional(N,M1,CustoX,Est),
		CEX is Est + CustoX),
		Novos),
	    Novos\==[],!,
            sort(Novos,NovosOrd),
            reverse(NovosOrd, NovosOrdReverse),
	    retira_custosConnectionEmotional(NovosOrdReverse,NovosOrd1),
	    append(NovosOrd1,LLA1,LLA2),
	    %write('LLA2='),write(LLA2),nl,
	    bestfs12ConnectionEmotional(Dest,LLA2,Cam,N,Custo,ListaEmocoes)
	)
    ).

member1ConnectionEmotional(LA,[LA|LAA],LAA).
member1ConnectionEmotional(LA,[_|LAA],LAA1):-member1ConnectionEmotional(LA,LAA,LAA1).

retira_custosConnectionEmotional([],[]).
retira_custosConnectionEmotional([(_,_,LA)|L],[LA|L1]):-retira_custosConnectionEmotional(L,L1).

calcula_custoConnectionEmotional([Act,X],C):-
    !,
    (edge_com_forcas(Act,X,C,_,_,_);edge_com_forcas(X,Act,_,C,_,_)).

calcula_custoConnectionEmotional([Act,X|L],S):-
        calcula_custoConnectionEmotional([X|L],S1),
		(edge_com_forcas(Act,X,C,_,_,_);edge_com_forcas(X,Act,_,C,_,_)),
        S is S1+C.

estimativaBestFirstConnectionEmotional(N,M,CustoX,Est):-
    Est is CustoX*(N-M).

verificaEmocoesConnectionB(_, []):- !.

% o T vai ter o aspeto (emoção, valor)
verificaEmocoesConnectionB(Lista, [(Emocao,Valor)|L]):-
                                        percorreConnectionEmotionalB(Lista, Emocao, V),
                                        (V =< Valor; fail),
                                        verificaEmocoesConnectionB(Lista, L).

percorreConnectionEmotionalB([], _, _):- !.

percorreConnectionEmotionalB([(E, V)|_], E, V):- !.

percorreConnectionEmotionalB([(_, _)| T], Emocao, Valor):-
                                    percorreConnectionEmotionalB(T, Emocao, Valor).
