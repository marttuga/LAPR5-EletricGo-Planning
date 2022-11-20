% ----------------------------------------------------------
% CAMINHO MAIS FORTE  (Só no sentido da travessia)
% ----------------------------------------------------------

:-dynamic melhor_sol_minlig1/2.

dfsFort(Origem,Destino,Caminho,Forca):-dfs3(Origem,Destino,[Origem],Caminho,Forca).

dfs3(Destino,Destino,ListaAuxiliar,Caminho,0):-!,reverse(ListaAuxiliar,Caminho).
dfs3(Act,Destino,ListaAuxiliar,Caminho,FR):-
	no(NAct,Act,_),
	(ligacao(NAct,NX,Forca,_);ligacao(NX,NAct,_,Forca)),
    no(NX,X,_),
    \+ member(X,ListaAuxiliar),
    dfs3(X,Destino,[X|ListaAuxiliar],Caminho, FR1),
	FR is FR1 + Forca.


plan_fortlig(Origem,Destino,LCaminho_minlig,N):-
		get_time(Ti),
		(melhor_caminho_minlig1(Origem,Destino);true),
		retract(melhor_sol_minlig1(LCaminho_minlig,N)),
		get_time(Tf),
		T is Tf-Ti,
		write('Tempo de geracao da solucao:'),write(T),nl.

melhor_caminho_minlig1(Origem,Destino):-
		asserta(melhor_sol_minlig1(_,-10000)),
		dfsFort(Origem,Destino,LCaminho,Forca),
		atualiza_melhor_minlig1(LCaminho, Forca),
		fail.	

atualiza_melhor_minlig1(LCaminho,Forca):-
		melhor_sol_minlig1(_,N),
		Forca>N,retract(melhor_sol_minlig1(_,_)),
		asserta(melhor_sol_minlig1(LCaminho,Forca)).

