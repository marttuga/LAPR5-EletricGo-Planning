dfsFortRelation(Origem,Destino,N,M,Caminho,Forca):-dfs3Relation(Origem,Destino,[Origem],N,M,Caminho,Forca).

dfs3Relation(Destino,Destino,ListaAuxiliar,_,_,Caminho,0):-!,reverse(ListaAuxiliar,Caminho).
dfs3Relation(Act,Destino,ListaAuxiliar,N,M,Caminho,FR):-
	node(Act),
    N>M,
	(edge_com_forcas(Act,X,Forca,_,ForcaRel,_);edge_com_forcas(X,Act,_,Forca,_,ForcaRel)),
    node(X),
    \+ member(X,ListaAuxiliar),
    multiCriterioDepthFirstRelation(Forca, ForcaRel, Resultado),
    M1 is M+1,
    dfs3Relation(X,Destino,[X|ListaAuxiliar],N,M1,Caminho, FR1),
	FR is FR1 + Resultado.


plan_fortligRelation(Origem,Destino,LCaminho_minlig,Custo,N):-
        %(generate_random_edges(); true),
		get_time(Ti),
		(melhor_caminho_minlig1Relation(Origem,Destino,N,0);true),
		retract(melhor_sol_minlig1Relation(LCaminho_minlig,Custo)),
		get_time(Tf),
		T is Tf-Ti,
        %(destroy_edges(); true),
		write('Tempo de geracao da solucao:'),write(T),nl.

melhor_caminho_minlig1Relation(Origem,Destino,N,M):-
		asserta(melhor_sol_minlig1Relation(_,-10000)),
		dfsFortRelation(Origem,Destino,N,M,LCaminho,Forca),
		atualiza_melhor_minlig1Relation(LCaminho, Forca),
		fail.

atualiza_melhor_minlig1Relation(LCaminho,Forca):-
		melhor_sol_minlig1Relation(_,N),
		Forca>N,retract(melhor_sol_minlig1Relation(_,_)),
		asserta(melhor_sol_minlig1Relation(LCaminho,Forca)).

multiCriterioDepthFirstRelation(CustoX,CustoRelX,Resultado):-
    CustoRelX1 is CustoRelX + 200,
    CustoRelX2 is CustoRelX1 / 400,
    CustoRelX3 is CustoRelX2 * 100,
    Resultado is (CustoRelX3 + CustoX)/2.
