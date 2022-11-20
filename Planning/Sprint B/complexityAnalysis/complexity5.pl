% Base de Conhecimento

:-dynamic melhor_sol_minlig/2.
:-dynamic conta_sol/1.

% Explicação: no(IdUtilizador, nomeUtilizador, tags)

no(1,ana,[natureza,pintura,musica,sw,porto]).

no(11,carlos1,[natureza,pintura,carros,futebol,lisboa]).
no(12,daniel1,[natureza,musica,carros,porto,moda]).
no(13,antonio1,[natureza,pintura,carros,futebol,lisboa]).
no(14,maria1,[natureza,pintura,carros,futebol,lisboa]).
no(15,joana1,[natureza,pintura,carros,futebol,lisboa]).

no(16,carlos2,[natureza,pintura,carros,futebol,lisboa]).
no(17,daniel2,[natureza,musica,carros,porto,moda]).
no(18,antonio2,[natureza,pintura,carros,futebol,lisboa]).
no(19,maria2,[natureza,pintura,carros,futebol,lisboa]).
no(20,joana2,[natureza,pintura,carros,futebol,lisboa]).

no(21,carlos3,[natureza,pintura,carros,futebol,lisboa]).
no(22,daniel3,[natureza,musica,carros,porto,moda]).
no(23,antonio3,[natureza,pintura,carros,futebol,lisboa]).
no(24,maria3,[natureza,pintura,carros,futebol,lisboa]).
no(25,joana3,[natureza,pintura,carros,futebol,lisboa]).

no(26,carlos4,[natureza,pintura,carros,futebol,lisboa]).
no(27,daniel4,[natureza,musica,carros,porto,moda]).
no(28,antonio4,[natureza,pintura,carros,futebol,lisboa]).
no(29,maria4,[natureza,pintura,carros,futebol,lisboa]).
no(30,joana4,[natureza,pintura,carros,futebol,lisboa]).

no(31,carlos5,[natureza,pintura,carros,futebol,lisboa]).
no(32,daniel5,[natureza,musica,carros,porto,moda]).
no(33,antonio5,[natureza,pintura,carros,futebol,lisboa]).
no(34,maria5,[natureza,pintura,carros,futebol,lisboa]).
no(35,joana5,[natureza,pintura,carros,futebol,lisboa]).

no(200,sara,[natureza,moda,musica,sw,coimbra]).

% Explicação: ligacao(IdUtilizadorA, IdUtilizadorB, forcaLigacaoEntreAeB, forcaLigacaoEntreBeA)

%Nivel 1
ligacao(1,11,1,1).
ligacao(1,12,1,1).
ligacao(1,13,1,1).
ligacao(1,14,1,1).
ligacao(1,15,1,1).

%Nivel 2
ligacao(11,16,1,1).
ligacao(11,17,1,1).
ligacao(11,18,1,1).
ligacao(11,19,1,1).
ligacao(11,20,1,1).

ligacao(12,16,1,1).
ligacao(12,17,1,1).
ligacao(12,18,1,1).
ligacao(12,19,1,1).
ligacao(12,20,1,1).

ligacao(13,16,1,1).
ligacao(13,17,1,1).
ligacao(13,18,1,1).
ligacao(13,19,1,1).
ligacao(13,20,1,1).

ligacao(14,16,1,1).
ligacao(14,17,1,1).
ligacao(14,18,1,1).
ligacao(14,19,1,1).
ligacao(14,20,1,1).

ligacao(15,16,1,1).
ligacao(15,17,1,1).
ligacao(15,18,1,1).
ligacao(15,19,1,1).
ligacao(15,20,1,1).

%Nivel 3
ligacao(16,21,1,1).
ligacao(16,22,1,1).
ligacao(16,23,1,1).
ligacao(16,24,1,1).
ligacao(16,25,1,1).

ligacao(17,21,1,1).
ligacao(17,22,1,1).
ligacao(17,23,1,1).
ligacao(17,24,1,1).
ligacao(17,25,1,1).

ligacao(18,21,1,1).
ligacao(18,22,1,1).
ligacao(18,23,1,1).
ligacao(18,24,1,1).
ligacao(18,25,1,1).

ligacao(19,21,1,1).
ligacao(19,22,1,1).
ligacao(19,23,1,1).
ligacao(19,24,1,1).
ligacao(19,25,1,1).

ligacao(20,21,1,1).
ligacao(20,22,1,1).
ligacao(20,23,1,1).
ligacao(20,24,1,1).
ligacao(20,25,1,1).

%Nivel 4
ligacao(21,26,1,1).
ligacao(21,27,1,1).
ligacao(21,28,1,1).
ligacao(21,29,1,1).
ligacao(21,30,1,1).

ligacao(22,26,1,1).
ligacao(22,27,1,1).
ligacao(22,28,1,1).
ligacao(22,29,1,1).
ligacao(22,30,1,1).

ligacao(23,26,1,1).
ligacao(23,27,1,1).
ligacao(23,28,1,1).
ligacao(23,29,1,1).
ligacao(23,30,1,1).

ligacao(24,26,1,1).
ligacao(24,27,1,1).
ligacao(24,28,1,1).
ligacao(24,29,1,1).
ligacao(24,30,1,1).

ligacao(25,26,1,1).
ligacao(25,27,1,1).
ligacao(25,28,1,1).
ligacao(25,29,1,1).
ligacao(25,30,1,1).

%Nivel 5
ligacao(26,31,1,1).
ligacao(26,32,1,1).
ligacao(26,33,1,1).
ligacao(26,34,1,1).
ligacao(26,35,1,1).

ligacao(27,31,1,1).
ligacao(27,32,1,1).
ligacao(27,33,1,1).
ligacao(27,34,1,1).
ligacao(27,35,1,1).

ligacao(28,31,1,1).
ligacao(28,32,1,1).
ligacao(28,33,1,1).
ligacao(28,34,1,1).
ligacao(28,35,1,1).

ligacao(29,31,1,1).
ligacao(29,32,1,1).
ligacao(29,33,1,1).
ligacao(29,34,1,1).
ligacao(29,35,1,1).

ligacao(30,31,1,1).
ligacao(30,32,1,1).
ligacao(30,33,1,1).
ligacao(30,34,1,1).
ligacao(30,35,1,1).

%Final
ligacao(31,200,1,1).
ligacao(32,200,1,1).
ligacao(33,200,1,1).
ligacao(34,200,1,1).
ligacao(35,200,1,1).



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










