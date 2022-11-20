% =================================================
% CAMINHO MAIS SEGURO (Considerando a soma das duas forças em cada ramo da travessia)
% =================================================

:-dynamic melhor_sol_minlig1_s2/2.

dfsFortSafest(Origem,Destino,Caminho,Forca,MinimoForca):-dfs3Safest(Origem,Destino,[Origem],Caminho,Forca,MinimoForca).

dfs3Safest(Destino,Destino,ListaAuxiliar,Caminho,0,_):-!,reverse(ListaAuxiliar,Caminho).
dfs3Safest(Act,Destino,ListaAuxiliar,Caminho,FR,MinimoForca):-
	no(NAct,Act,_),
	(ligacao(NAct,NX,Forca,OutraForca);ligacao(NX,NAct,OutraForca,Forca)),
        no(NX,X,_),
        \+ member(X,ListaAuxiliar),
        Forca >= MinimoForca,
        OutraForca >= MinimoForca,
        dfs3Safest(X,Destino,[X|ListaAuxiliar],Caminho, FR1, MinimoForca),
	FR is FR1 + Forca + OutraForca.


plan_safestLigTwoWays(Origem,Destino,LCaminho,N,MinimoForca):-
		get_time(Ti),
		(melhor_caminho_minlig1Safest(Origem,Destino,MinimoForca);true),
		retract(melhor_sol_minlig1_s2(LCaminho,N)),
		get_time(Tf),
		T is Tf-Ti,
		write('Tempo de geracao da solucao:'),write(T),nl.

melhor_caminho_minlig1Safest(Origem,Destino,MinimoForca):-
		asserta(melhor_sol_minlig1_s2(_,-10000)),
		dfsFortSafest(Origem,Destino,LCaminho,Forca,MinimoForca),
		atualiza_melhor_minlig1Safest(LCaminho, Forca),
		fail.

atualiza_melhor_minlig1Safest(LCaminho,Forca):-
		melhor_sol_minlig1_s2(_,N),
		Forca>N,retract(melhor_sol_minlig1_s2(_,_)),
		asserta(melhor_sol_minlig1_s2(LCaminho,Forca)).
