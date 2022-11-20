% ---------------------------------------------------------------------------------------
% CAMINHO MAIS FORTE  (Considerando a soma das duas forças em cada ramo da travessia)
% ---------------------------------------------------------------------------------------

:-dynamic melhor_sol_minlig3/2.

dfsFort1(Origem,Destino,Caminho,Forca):-dfs4(Origem,Destino,[Origem],Caminho,Forca).

dfs4(Destino,Destino,ListaAuxiliar,Caminho,0):-!,reverse(ListaAuxiliar,Caminho).
dfs4(Act,Destino,ListaAuxiliar,Caminho,FR):-
	no(NAct,Act,_),
	(ligacao(NAct,NX,Forca,F1);ligacao(NX,NAct,F1,Forca)),
    no(NX,X,_),
    \+ member(X,ListaAuxiliar),
    dfs4(X,Destino,[X|ListaAuxiliar],Caminho, FR1),
	FR is FR1 + Forca + F1.


plan_fortlig1(Origem,Destino,LCaminho_minlig,N):-
		get_time(Ti),
		(melhor_caminho_minlig3(Origem,Destino);true),
		retract(melhor_sol_minlig3(LCaminho_minlig,N)),
		get_time(Tf),
		T is Tf-Ti,
		write('Tempo de geracao da solucao:'),write(T),nl.

melhor_caminho_minlig3(Origem,Destino):-
		asserta(melhor_sol_minlig3(_,-10000)),
		dfsFort1(Origem,Destino,LCaminho,Forca),
		atualiza_melhor_minlig3(LCaminho, Forca),
		fail.	

atualiza_melhor_minlig3(LCaminho,Forca):-
		melhor_sol_minlig3(_,N),
		Forca>N,retract(melhor_sol_minlig3(_,_)),
		asserta(melhor_sol_minlig3(LCaminho,Forca)).
