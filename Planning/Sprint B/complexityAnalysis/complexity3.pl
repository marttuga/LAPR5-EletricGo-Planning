% Base de Conhecimento

:-dynamic melhor_sol_minlig/2.
:-dynamic conta_sol/1.

% Explicação: no(IdUtilizador, nomeUtilizador, tags)

no(1,ana,[natureza,pintura,musica,sw,porto]).

no(11,carlos1,[natureza,pintura,carros,futebol,lisboa]).
no(12,daniel1,[natureza,musica,carros,porto,moda]).
no(15,antonio1,[natureza,pintura,carros,futebol,lisboa]).

no(13,carlos2,[natureza,musica,sw,futebol,coimbra]).
no(14,daniel2,[natureza,cinema,jogos,sw,moda]).
no(16,antonio2,[natureza,pintura,carros,futebol,lisboa]).

no(17,carlos3,[natureza,musica,sw,futebol,coimbra]).
no(18,daniel3,[natureza,cinema,jogos,sw,moda]).
no(19,antonio3,[natureza,pintura,carros,futebol,lisboa]).

no(200,sara,[natureza,moda,musica,sw,coimbra]).

% Explicação: ligacao(IdUtilizadorA, IdUtilizadorB, forcaLigacaoEntreAeB, forcaLigacaoEntreBeA)

ligacao(1,11,1,1).
ligacao(1,12,1,1).
ligacao(1,15,1,1).


ligacao(11,13,1,1).
ligacao(11,14,1,1).
ligacao(11,16,1,1).

ligacao(12,13,1,1).
ligacao(12,14,1,1).
ligacao(12,16,1,1).

ligacao(15,13,1,1).
ligacao(15,14,1,1).
ligacao(15,16,1,1).


ligacao(13,17,1,1).
ligacao(13,18,1,1).
ligacao(13,19,1,1).

ligacao(14,17,1,1).
ligacao(14,18,1,1).
ligacao(14,19,1,1).

ligacao(16,17,1,1).
ligacao(16,18,1,1).
ligacao(16,19,1,1).


ligacao(17,200,1,1).
ligacao(18,200,1,1).
ligacao(19,200,1,1).



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










