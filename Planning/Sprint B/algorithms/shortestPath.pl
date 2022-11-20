% ----------------------------------------------------------
% CAMINHO MAIS CURTO
% ----------------------------------------------------------

:-dynamic melhor_sol_minlig/2.

all_dfs(Nome1,Nome2,LCaminho):-get_time(T1),
    findall(Caminho,dfs(Nome1,Nome2,Caminho),LCaminho),
    length(LCaminho,NLCam),
    get_time(T2),
    write(NLCam),write(' solucoes encontradas em '),
    T is T2-T1,write(T),write(' segundos'),nl,
    write('Lista de Caminhos possiveis: '),write(LCaminho),nl,nl.

dfs(Origem,Destino,Caminho):-dfs2(Origem,Destino,[Origem],Caminho).

dfs2(Destino,Destino,ListaAuxiliar,Caminho):-!,reverse(ListaAuxiliar,Caminho).
dfs2(Act,Destino,ListaAuxiliar,Caminho):-
	no(NAct,Act,_),
	(ligacao(NAct,NX,_,_);ligacao(NX,NAct,_,_)),
    no(NX,X,_),
    \+ member(X,ListaAuxiliar),
    dfs2(X,Destino,[X|ListaAuxiliar],Caminho).


plan_minlig(Origem,Destino,LCaminho_minlig,N):-
		get_time(Ti),
		(melhor_caminho_minlig(Origem,Destino);true),
		retract(melhor_sol_minlig(LCaminho_minlig,N)),
		get_time(Tf),
		T is Tf-Ti,
		write('Tempo de geracao da solucao:'),write(T),nl.

melhor_caminho_minlig(Origem,Destino):-
		asserta(melhor_sol_minlig(_,10000)),
		dfs(Origem,Destino,LCaminho),
		atualiza_melhor_minlig(LCaminho),
		fail.

% fazer uma condição if quando for 1, para parar.		

atualiza_melhor_minlig(LCaminho):-
		melhor_sol_minlig(_,N),
		length(LCaminho,C),
		C<N,retract(melhor_sol_minlig(_,_)),
		asserta(melhor_sol_minlig(LCaminho,C)).