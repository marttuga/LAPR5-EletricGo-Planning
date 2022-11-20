% Base de Conhecimento

:-dynamic melhor_sol_minlig/2.
:-dynamic conta_sol/1.

% Explicação: no(IdUtilizador, nomeUtilizador, tags)

no(1,ana,[natureza,pintura,musica,sw,porto]).

no(11,carlos1,[natureza,pintura,carros,futebol,lisboa]).
no(12,daniel1,[natureza,musica,carros,porto,moda]).
no(13,antonio1,[natureza,pintura,carros,futebol,lisboa]).
no(14,maria1,[natureza,pintura,carros,futebol,lisboa]).

no(15,carlos2,[natureza,pintura,carros,futebol,lisboa]).
no(16,daniel2,[natureza,musica,carros,porto,moda]).
no(17,antonio2,[natureza,pintura,carros,futebol,lisboa]).
no(18,maria2,[natureza,pintura,carros,futebol,lisboa]).

no(19,carlos3,[natureza,pintura,carros,futebol,lisboa]).
no(20,daniel3,[natureza,musica,carros,porto,moda]).
no(21,antonio3,[natureza,pintura,carros,futebol,lisboa]).
no(22,maria3,[natureza,pintura,carros,futebol,lisboa]).

no(23,carlos4,[natureza,pintura,carros,futebol,lisboa]).
no(24,daniel4,[natureza,musica,carros,porto,moda]).
no(25,antonio4,[natureza,pintura,carros,futebol,lisboa]).
no(26,maria4,[natureza,pintura,carros,futebol,lisboa]).

no(200,sara,[natureza,moda,musica,sw,coimbra]).

% Explicação: ligacao(IdUtilizadorA, IdUtilizadorB, forcaLigacaoEntreAeB, forcaLigacaoEntreBeA)

ligacao(1,11,1,1).
ligacao(1,12,1,1).
ligacao(1,13,1,1).
ligacao(1,14,1,1).


ligacao(11,15,1,1).
ligacao(11,16,1,1).
ligacao(11,17,1,1).
ligacao(11,18,1,1).

ligacao(12,15,1,1).
ligacao(12,16,1,1).
ligacao(12,17,1,1).
ligacao(12,18,1,1).

ligacao(13,15,1,1).
ligacao(13,16,1,1).
ligacao(13,17,1,1).
ligacao(13,18,1,1).

ligacao(14,15,1,1).
ligacao(14,16,1,1).
ligacao(14,17,1,1).
ligacao(14,18,1,1).


ligacao(15,19,1,1).
ligacao(15,20,1,1).
ligacao(15,21,1,1).
ligacao(15,22,1,1).

ligacao(16,19,1,1).
ligacao(16,20,1,1).
ligacao(16,21,1,1).
ligacao(16,22,1,1).

ligacao(17,19,1,1).
ligacao(17,20,1,1).
ligacao(17,21,1,1).
ligacao(17,22,1,1).

ligacao(18,19,1,1).
ligacao(18,20,1,1).
ligacao(18,21,1,1).
ligacao(18,22,1,1).


ligacao(19,23,1,1).
ligacao(19,24,1,1).
ligacao(19,25,1,1).
ligacao(19,26,1,1).

ligacao(20,23,1,1).
ligacao(20,24,1,1).
ligacao(20,25,1,1).
ligacao(20,26,1,1).

ligacao(21,23,1,1).
ligacao(21,24,1,1).
ligacao(21,25,1,1).
ligacao(21,26,1,1).

ligacao(22,23,1,1).
ligacao(22,24,1,1).
ligacao(22,25,1,1).
ligacao(22,26,1,1).


ligacao(23,200,1,1).
ligacao(24,200,1,1).
ligacao(25,200,1,1).
ligacao(26,200,1,1).



%Com findall unidireciona
all_dfs(Nome1,Nome2,LCaminho):-get_time(T1),
    findall(Caminho,dfs(Nome1,Nome2,Caminho),LCaminho),
    length(LCaminho,NLCam),
    get_time(T2),
    write(NLCam),write(' solucoes encontradas em '),
    T is T2-T1,write(T),write(' segundos'),nl.

dfs(Origem,Destino,Caminho):-dfs2(Origem,Destino,[Origem],Caminho).

dfs2(Destino,Destino,ListaAuxiliar,Caminho):-!,reverse(ListaAuxiliar,Caminho).
dfs2(Act,Destino,ListaAuxiliar,Caminho):-
	no(NAct,Act,_),
	ligacao(NAct,NX,_,_),
    no(NX,X,_),
    \+member(X,ListaAuxiliar),
    dfs2(X,Destino,[X|ListaAuxiliar],Caminho).


%=========================
%DFS Bidirectional

all_dfs_bi(Nome1,Nome2,LCaminho):-get_time(T1),
    findall(Caminho,dfs_bi(Nome1,Nome2,Caminho),LCaminho),
    length(LCaminho,NLCam),
    get_time(T2),
    write(NLCam),write(' solucoes encontradas em '),
    T is T2-T1,write(T),write(' segundos'),nl.

dfs_bi(Origem,Destino,Caminho):-dfs_bi2(Origem,Destino,[Origem],Caminho).

dfs_bi2(Destino,Destino,ListaAuxiliar,Caminho):-!,reverse(ListaAuxiliar,Caminho).
dfs_bi2(Act,Destino,ListaAuxiliar,Caminho):-
	no(NAct,Act,_),
	(ligacao(NAct,NX,_,_);ligacao(NX,NAct,_,_)),
    no(NX,X,_),
    \+ member(X,ListaAuxiliar),
    dfs_bi2(X,Destino,[X|ListaAuxiliar],Caminho).


%=========================
%DFS Bidirectional (sem findall)


plan_minlig(Orig,Dest,LCaminho_minlig, Conta):-
    get_time(Ti),
    (melhor_caminho_minlig(Orig,Dest);true),
    retract(melhor_sol_minlig(LCaminho_minlig,_)),
    retract(conta_sol(Conta)),
    get_time(Tf),
    T is Tf-Ti,
    write('Tempo de geracao da solucao:'),write(T),nl.

melhor_caminho_minlig(Orig,Dest):-
    assert(melhor_sol_minlig(_,10000)),
    assert(conta_sol(0)),
    dfs_bi(Orig,Dest,LCaminho),
    atualiza_melhor_minlig(LCaminho),
    fail.

atualiza_melhor_minlig(LCaminho):-
    retract(conta_sol(NS)),
    NS1 is NS+1,
    assert(conta_sol(NS1)),
    melhor_sol_minlig(_,N),
    length(LCaminho,C),
    C<N,retract(melhor_sol_minlig(_,_)),
    assert(melhor_sol_minlig(LCaminho,C)).






