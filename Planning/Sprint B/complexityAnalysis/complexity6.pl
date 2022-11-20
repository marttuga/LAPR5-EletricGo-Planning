% Base de Conhecimento

:-dynamic melhor_sol_minlig/2.
:-dynamic conta_sol/1.

% Explicação: no(IdUtilizador, nomeUtilizador, tags)

no(1,ana,[natureza,pintura,musica,sw,porto]).

no(11,carlos1,[natureza,pintura,carros,futebol,lisboa]).
no(12,daniel1,[natureza,musica,carros,porto,moda]).
no(13,antoni1,[natureza,pintura,carros,futebol,lisboa]).
no(14,marial1,[natureza,pintura,carros,futebol,lisboa]).
no(15,joanal1,[natureza,pintura,carros,futebol,lisboa]).
no(16,pedrol1,[natureza,pintura,carros,futebol,lisboa]).

no(17,carlos2,[natureza,pintura,carros,futebol,lisboa]).
no(18,daniel2,[natureza,musica,carros,porto,moda]).
no(19,antoni2,[natureza,pintura,carros,futebol,lisboa]).
no(20,marial2,[natureza,pintura,carros,futebol,lisboa]).
no(21,joanal2,[natureza,pintura,carros,futebol,lisboa]).
no(22,pedrol2,[natureza,pintura,carros,futebol,lisboa]).

no(23,carlos3,[natureza,pintura,carros,futebol,lisboa]).
no(24,daniel3,[natureza,musica,carros,porto,moda]).
no(25,antoni3,[natureza,pintura,carros,futebol,lisboa]).
no(26,marial3,[natureza,pintura,carros,futebol,lisboa]).
no(27,joanal3,[natureza,pintura,carros,futebol,lisboa]).
no(28,pedrol3,[natureza,pintura,carros,futebol,lisboa]).

no(29,carlos4,[natureza,pintura,carros,futebol,lisboa]).
no(30,daniel4,[natureza,musica,carros,porto,moda]).
no(31,antoni4,[natureza,pintura,carros,futebol,lisboa]).
no(32,marial4,[natureza,pintura,carros,futebol,lisboa]).
no(33,joanal4,[natureza,pintura,carros,futebol,lisboa]).
no(34,pedrol4,[natureza,pintura,carros,futebol,lisboa]).

no(35,carlos5,[natureza,pintura,carros,futebol,lisboa]).
no(36,daniel5,[natureza,musica,carros,porto,moda]).
no(37,antoni5,[natureza,pintura,carros,futebol,lisboa]).
no(38,marial5,[natureza,pintura,carros,futebol,lisboa]).
no(39,joanal5,[natureza,pintura,carros,futebol,lisboa]).
no(40,pedrol5,[natureza,pintura,carros,futebol,lisboa]).

no(41,carlos6,[natureza,pintura,carros,futebol,lisboa]).
no(42,daniel6,[natureza,musica,carros,porto,moda]).
no(43,antoni6,[natureza,pintura,carros,futebol,lisboa]).
no(44,marial6,[natureza,pintura,carros,futebol,lisboa]).
no(45,joanal6,[natureza,pintura,carros,futebol,lisboa]).
no(46,pedrol6,[natureza,pintura,carros,futebol,lisboa]).

no(200,sara,[natureza,moda,musica,sw,coimbra]).

% Explicação: ligacao(IdUtilizadorA, IdUtilizadorB, forcaLigacaoEntreAeB, forcaLigacaoEntreBeA)

%Nivel 1
ligacao(1,11,1,1).
ligacao(1,12,1,1).
ligacao(1,13,1,1).
ligacao(1,14,1,1).
ligacao(1,15,1,1).
ligacao(1,16,1,1).


%Nivel 2
ligacao(11,17,1,1).
ligacao(11,18,1,1).
ligacao(11,19,1,1).
ligacao(11,20,1,1).
ligacao(11,21,1,1).
ligacao(11,22,1,1).

ligacao(12,17,1,1).
ligacao(12,18,1,1).
ligacao(12,19,1,1).
ligacao(12,20,1,1).
ligacao(12,21,1,1).
ligacao(12,22,1,1).

ligacao(13,17,1,1).
ligacao(13,18,1,1).
ligacao(13,19,1,1).
ligacao(13,20,1,1).
ligacao(13,21,1,1).
ligacao(13,22,1,1).

ligacao(14,17,1,1).
ligacao(14,18,1,1).
ligacao(14,19,1,1).
ligacao(14,20,1,1).
ligacao(14,21,1,1).
ligacao(14,22,1,1).

ligacao(15,17,1,1).
ligacao(15,18,1,1).
ligacao(15,19,1,1).
ligacao(15,20,1,1).
ligacao(15,21,1,1).
ligacao(15,22,1,1).

ligacao(16,17,1,1).
ligacao(16,18,1,1).
ligacao(16,19,1,1).
ligacao(16,20,1,1).
ligacao(16,21,1,1).
ligacao(16,22,1,1).


%Nivel 3
ligacao(17,23,1,1).
ligacao(17,24,1,1).
ligacao(17,25,1,1).
ligacao(17,26,1,1).
ligacao(17,27,1,1).
ligacao(17,28,1,1).

ligacao(18,23,1,1).
ligacao(18,24,1,1).
ligacao(18,25,1,1).
ligacao(18,26,1,1).
ligacao(18,27,1,1).
ligacao(18,28,1,1).

ligacao(19,23,1,1).
ligacao(19,24,1,1).
ligacao(19,25,1,1).
ligacao(19,26,1,1).
ligacao(19,27,1,1).
ligacao(19,28,1,1).

ligacao(20,23,1,1).
ligacao(20,24,1,1).
ligacao(20,25,1,1).
ligacao(20,26,1,1).
ligacao(20,27,1,1).
ligacao(20,28,1,1).

ligacao(21,23,1,1).
ligacao(21,24,1,1).
ligacao(21,25,1,1).
ligacao(21,26,1,1).
ligacao(21,27,1,1).
ligacao(21,28,1,1).

ligacao(22,23,1,1).
ligacao(22,24,1,1).
ligacao(22,25,1,1).
ligacao(22,26,1,1).
ligacao(22,27,1,1).
ligacao(22,28,1,1).


%Nivel 4
ligacao(23,29,1,1).
ligacao(23,30,1,1).
ligacao(23,31,1,1).
ligacao(23,32,1,1).
ligacao(23,33,1,1).
ligacao(23,34,1,1).

ligacao(24,29,1,1).
ligacao(24,30,1,1).
ligacao(24,31,1,1).
ligacao(24,32,1,1).
ligacao(24,33,1,1).
ligacao(24,34,1,1).

ligacao(25,29,1,1).
ligacao(25,30,1,1).
ligacao(25,31,1,1).
ligacao(25,32,1,1).
ligacao(25,33,1,1).
ligacao(25,34,1,1).

ligacao(26,29,1,1).
ligacao(26,30,1,1).
ligacao(26,31,1,1).
ligacao(26,32,1,1).
ligacao(26,33,1,1).
ligacao(26,34,1,1).

ligacao(27,29,1,1).
ligacao(27,30,1,1).
ligacao(27,31,1,1).
ligacao(27,32,1,1).
ligacao(27,33,1,1).
ligacao(27,34,1,1).

ligacao(28,29,1,1).
ligacao(28,30,1,1).
ligacao(28,31,1,1).
ligacao(28,32,1,1).
ligacao(28,33,1,1).
ligacao(28,34,1,1).


%Nivel 5
ligacao(29,35,1,1).
ligacao(29,36,1,1).
ligacao(29,37,1,1).
ligacao(29,38,1,1).
ligacao(29,39,1,1).
ligacao(29,40,1,1).

ligacao(30,35,1,1).
ligacao(30,36,1,1).
ligacao(30,37,1,1).
ligacao(30,38,1,1).
ligacao(30,39,1,1).
ligacao(30,40,1,1).

ligacao(31,35,1,1).
ligacao(31,36,1,1).
ligacao(31,37,1,1).
ligacao(31,38,1,1).
ligacao(31,39,1,1).
ligacao(31,40,1,1).

ligacao(32,35,1,1).
ligacao(32,36,1,1).
ligacao(32,37,1,1).
ligacao(32,38,1,1).
ligacao(32,39,1,1).
ligacao(32,40,1,1).

ligacao(33,35,1,1).
ligacao(33,36,1,1).
ligacao(33,37,1,1).
ligacao(33,38,1,1).
ligacao(33,39,1,1).
ligacao(33,40,1,1).

ligacao(34,35,1,1).
ligacao(34,36,1,1).
ligacao(34,37,1,1).
ligacao(34,38,1,1).
ligacao(34,39,1,1).
ligacao(34,40,1,1).


%Nivel 6
ligacao(35,41,1,1).
ligacao(35,42,1,1).
ligacao(35,43,1,1).
ligacao(35,44,1,1).
ligacao(35,45,1,1).
ligacao(35,46,1,1).

ligacao(36,41,1,1).
ligacao(36,42,1,1).
ligacao(36,43,1,1).
ligacao(36,44,1,1).
ligacao(36,45,1,1).
ligacao(36,46,1,1).

ligacao(37,41,1,1).
ligacao(37,42,1,1).
ligacao(37,43,1,1).
ligacao(37,44,1,1).
ligacao(37,45,1,1).
ligacao(37,46,1,1).

ligacao(38,41,1,1).
ligacao(38,42,1,1).
ligacao(38,43,1,1).
ligacao(38,44,1,1).
ligacao(38,45,1,1).
ligacao(38,46,1,1).

ligacao(39,41,1,1).
ligacao(39,42,1,1).
ligacao(39,43,1,1).
ligacao(39,44,1,1).
ligacao(39,45,1,1).
ligacao(39,46,1,1).

ligacao(40,41,1,1).
ligacao(40,42,1,1).
ligacao(40,43,1,1).
ligacao(40,44,1,1).
ligacao(40,45,1,1).
ligacao(40,46,1,1).

%Final
ligacao(41,200,1,1).
ligacao(42,200,1,1).
ligacao(43,200,1,1).
ligacao(44,200,1,1).
ligacao(45,200,1,1).
ligacao(46,200,1,1).



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
















