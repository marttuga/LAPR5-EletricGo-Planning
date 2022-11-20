dfsFortRelationEmotional(Origem,Destino,N,M,Caminho,Forca,ListaEmocoes):-dfs3RelationEmotional(Origem,Destino,[Origem],N,M,Caminho,Forca,ListaEmocoes).

dfs3RelationEmotional(Destino,Destino,ListaAuxiliar,_,_,Caminho,0,_):-!,reverse(ListaAuxiliar,Caminho).
dfs3RelationEmotional(Act,Destino,ListaAuxiliar,N,M,Caminho,FR,ListaEmocoes):-
	node(Act,_),
    N>M,
	(edge_com_forcas(Act,X,Forca,_,ForcaRel,_);edge_com_forcas(X,Act,_,Forca,_,ForcaRel)),
    node(X,Lista),
    \+ member(X,ListaAuxiliar),
    verificaEmocoesRelationD(Lista,ListaEmocoes),
    multiCriterioDepthFirstRelationEmotional(Forca, ForcaRel, Resultado),
    M1 is M+1,
    dfs3RelationEmotional(X,Destino,[X|ListaAuxiliar],N,M1,Caminho, FR1,ListaEmocoes),
	FR is FR1 + Resultado.


plan_fortligRelationEmotional(Origem,Destino,LCaminho_minlig,Custo,N,ListaEmocoes):-
        %(generate_random_edges(); true),
		get_time(Ti),
		(melhor_caminho_minlig1RelationE(Origem,Destino,N,0,ListaEmocoes);true),
		retract(melhor_sol_minlig1RelationE(LCaminho_minlig,Custo)),
		get_time(Tf),
		T is Tf-Ti,
        %(destroy_edges(); true),
		write('Tempo de geracao da solucao:'),write(T),nl.

melhor_caminho_minlig1RelationE(Origem,Destino,N,M,ListaEmocoes):-
		asserta(melhor_sol_minlig1RelationE(_,-10000)),
		dfsFortRelationEmotional(Origem,Destino,N,M,LCaminho,Forca,ListaEmocoes),
		atualiza_melhor_minlig1RelationE(LCaminho, Forca),
		fail.

atualiza_melhor_minlig1RelationE(LCaminho,Forca):-
		melhor_sol_minlig1RelationE(_,N),
		Forca>N,retract(melhor_sol_minlig1RelationE(_,_)),
		asserta(melhor_sol_minlig1RelationE(LCaminho,Forca)).

multiCriterioDepthFirstRelationEmotional(CustoX,CustoRelX,Resultado):-
    CustoRelX1 is CustoRelX + 200,
    CustoRelX2 is CustoRelX1 / 400,
    CustoRelX3 is CustoRelX2 * 100,
    Resultado is (CustoRelX3 + CustoX)/2.

verificaEmocoesRelationD(_, []):- !.

% o T vai ter o aspeto (emoção, valor)
verificaEmocoesRelationD(Lista, [(Emocao,Valor)|L]):-
                                        percorreRelationEmotionalD(Lista, Emocao, V),
                                        (V =< Valor; fail),
                                        verificaEmocoesRelationB(Lista, L).

percorreRelationEmotionalD([], _, _):- !.

percorreRelationEmotionalD([(E, V)|_], E, V):- !.

percorreRelationEmotionalD([(_, _)| T], Emocao, Valor):-
                                    percorreRelationEmotionalD(T, Emocao, Valor).

