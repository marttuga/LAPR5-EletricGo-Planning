% =================================================
% CAMINHO MAIS SEGURO (Só no sentido da travessia)
% =================================================

:-dynamic melhor_sol_minlig1_s1/2.

dfsFort(Origem,Destino,Caminho,Forca,MinimoForca):-dfs3(Origem,Destino,[Origem],Caminho,Forca,MinimoForca).

dfs3(Destino,Destino,ListaAuxiliar,Caminho,0,_):-!,reverse(ListaAuxiliar,Caminho).
dfs3(Act,Destino,ListaAuxiliar,Caminho,FR,MinimoForca):-
	no(NAct,Act,_),
	(ligacao(NAct,NX,Forca,_);ligacao(NX,NAct,_,Forca)),
        no(NX,X,_),
        \+ member(X,ListaAuxiliar),
        Forca >= MinimoForca,
        dfs3(X,Destino,[X|ListaAuxiliar],Caminho, FR1, MinimoForca),
	FR is FR1 + Forca.


plan_safestLig(Origem,Destino,LCaminho,N,MinimoForca):-
		get_time(Ti),
		(melhor_caminho_minlig1(Origem,Destino,MinimoForca);true),
		retract(melhor_sol_minlig1_s1(LCaminho,N)),
		get_time(Tf),
		T is Tf-Ti,
		write('Tempo de geracao da solucao:'),write(T),nl.

melhor_caminho_minlig1(Origem,Destino,MinimoForca):-
		asserta(melhor_sol_minlig1_s1(_,-10000)),
		dfsFort(Origem,Destino,LCaminho,Forca,MinimoForca),
		atualiza_melhor_minligOneWay(LCaminho, Forca),
		fail.

atualiza_melhor_minligOneWay(LCaminho,Forca):-
		melhor_sol_minlig1_s1(_,N),
		Forca>N,retract(melhor_sol_minlig1_s1(_,_)),
		asserta(melhor_sol_minlig1_s1(LCaminho,Forca)).
