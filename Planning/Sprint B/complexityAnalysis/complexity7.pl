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
no(17,marcia1,[natureza,pintura,carros,futebol,lisboa]).

no(18,carlos2,[natureza,pintura,carros,futebol,lisboa]).
no(19,daniel2,[natureza,musica,carros,porto,moda]).
no(20,antoni2,[natureza,pintura,carros,futebol,lisboa]).
no(21,marial2,[natureza,pintura,carros,futebol,lisboa]).
no(22,joanal2,[natureza,pintura,carros,futebol,lisboa]).
no(23,pedrol2,[natureza,pintura,carros,futebol,lisboa]).
no(24,marcia2,[natureza,pintura,carros,futebol,lisboa]).

no(25,carlos3,[natureza,pintura,carros,futebol,lisboa]).
no(26,daniel3,[natureza,musica,carros,porto,moda]).
no(27,antoni3,[natureza,pintura,carros,futebol,lisboa]).
no(28,marial3,[natureza,pintura,carros,futebol,lisboa]).
no(29,joanal3,[natureza,pintura,carros,futebol,lisboa]).
no(30,pedrol3,[natureza,pintura,carros,futebol,lisboa]).
no(31,marcia3,[natureza,pintura,carros,futebol,lisboa]).

no(32,carlos4,[natureza,pintura,carros,futebol,lisboa]).
no(33,daniel4,[natureza,musica,carros,porto,moda]).
no(34,antoni4,[natureza,pintura,carros,futebol,lisboa]).
no(35,marial4,[natureza,pintura,carros,futebol,lisboa]).
no(36,joanal4,[natureza,pintura,carros,futebol,lisboa]).
no(37,pedrol4,[natureza,pintura,carros,futebol,lisboa]).
no(38,marcia4,[natureza,pintura,carros,futebol,lisboa]).

no(39,carlos5,[natureza,pintura,carros,futebol,lisboa]).
no(40,daniel5,[natureza,musica,carros,porto,moda]).
no(41,antoni5,[natureza,pintura,carros,futebol,lisboa]).
no(42,marial5,[natureza,pintura,carros,futebol,lisboa]).
no(43,joanal5,[natureza,pintura,carros,futebol,lisboa]).
no(44,pedrol5,[natureza,pintura,carros,futebol,lisboa]).
no(45,marcia5,[natureza,pintura,carros,futebol,lisboa]).

no(46,carlos6,[natureza,pintura,carros,futebol,lisboa]).
no(47,daniel6,[natureza,musica,carros,porto,moda]).
no(48,antoni6,[natureza,pintura,carros,futebol,lisboa]).
no(49,marial6,[natureza,pintura,carros,futebol,lisboa]).
no(50,joanal6,[natureza,pintura,carros,futebol,lisboa]).
no(51,pedrol6,[natureza,pintura,carros,futebol,lisboa]).
no(52,marcia6,[natureza,pintura,carros,futebol,lisboa]).

no(53,carlos7,[natureza,pintura,carros,futebol,lisboa]).
no(54,daniel7,[natureza,musica,carros,porto,moda]).
no(55,antoni7,[natureza,pintura,carros,futebol,lisboa]).
no(56,marial7,[natureza,pintura,carros,futebol,lisboa]).
no(57,joanal7,[natureza,pintura,carros,futebol,lisboa]).
no(58,pedrol7,[natureza,pintura,carros,futebol,lisboa]).
no(59,marcia7,[natureza,pintura,carros,futebol,lisboa]).


no(200,sara,[natureza,moda,musica,sw,coimbra]).

% Explicação: ligacao(IdUtilizadorA, IdUtilizadorB, forcaLigacaoEntreAeB, forcaLigacaoEntreBeA)

%Nivel 1
ligacao(1,11,1,1).
ligacao(1,12,1,1).
ligacao(1,13,1,1).
ligacao(1,14,1,1).
ligacao(1,15,1,1).
ligacao(1,16,1,1).
ligacao(1,17,1,1).

%==============================
%Nivel 2
ligacao(11,18,1,1).
ligacao(11,19,1,1).
ligacao(11,20,1,1).
ligacao(11,21,1,1).
ligacao(11,22,1,1).
ligacao(11,23,1,1).
ligacao(11,24,1,1).

ligacao(12,18,1,1).
ligacao(12,19,1,1).
ligacao(12,20,1,1).
ligacao(12,21,1,1).
ligacao(12,22,1,1).
ligacao(12,23,1,1).
ligacao(12,24,1,1).

ligacao(13,18,1,1).
ligacao(13,19,1,1).
ligacao(13,20,1,1).
ligacao(13,21,1,1).
ligacao(13,22,1,1).
ligacao(13,23,1,1).
ligacao(13,24,1,1).

ligacao(14,18,1,1).
ligacao(14,19,1,1).
ligacao(14,20,1,1).
ligacao(14,21,1,1).
ligacao(14,22,1,1).
ligacao(14,23,1,1).
ligacao(14,24,1,1).

ligacao(15,18,1,1).
ligacao(15,19,1,1).
ligacao(15,20,1,1).
ligacao(15,21,1,1).
ligacao(15,22,1,1).
ligacao(15,23,1,1).
ligacao(15,24,1,1).

ligacao(16,18,1,1).
ligacao(16,19,1,1).
ligacao(16,20,1,1).
ligacao(16,21,1,1).
ligacao(16,22,1,1).
ligacao(16,23,1,1).
ligacao(16,24,1,1).

ligacao(17,18,1,1).
ligacao(17,19,1,1).
ligacao(17,20,1,1).
ligacao(17,21,1,1).
ligacao(17,22,1,1).
ligacao(17,23,1,1).
ligacao(17,24,1,1).



%==============================
%Nivel 3
ligacao(18,25,1,1).
ligacao(18,26,1,1).
ligacao(18,27,1,1).
ligacao(18,28,1,1).
ligacao(18,29,1,1).
ligacao(18,30,1,1).
ligacao(18,31,1,1).

ligacao(19,25,1,1).
ligacao(19,26,1,1).
ligacao(19,27,1,1).
ligacao(19,28,1,1).
ligacao(19,29,1,1).
ligacao(19,30,1,1).
ligacao(19,31,1,1).

ligacao(20,25,1,1).
ligacao(20,26,1,1).
ligacao(20,27,1,1).
ligacao(20,28,1,1).
ligacao(20,29,1,1).
ligacao(20,30,1,1).
ligacao(20,31,1,1).

ligacao(21,25,1,1).
ligacao(21,26,1,1).
ligacao(21,27,1,1).
ligacao(21,28,1,1).
ligacao(21,29,1,1).
ligacao(21,30,1,1).
ligacao(21,31,1,1).

ligacao(22,25,1,1).
ligacao(22,26,1,1).
ligacao(22,27,1,1).
ligacao(22,28,1,1).
ligacao(22,29,1,1).
ligacao(22,30,1,1).
ligacao(22,31,1,1).

ligacao(23,25,1,1).
ligacao(23,26,1,1).
ligacao(23,27,1,1).
ligacao(23,28,1,1).
ligacao(23,29,1,1).
ligacao(23,30,1,1).
ligacao(23,31,1,1).

ligacao(24,25,1,1).
ligacao(24,26,1,1).
ligacao(24,27,1,1).
ligacao(24,28,1,1).
ligacao(24,29,1,1).
ligacao(24,30,1,1).
ligacao(24,31,1,1).



%==============================
%Nivel 4
ligacao(25,32,1,1).
ligacao(25,33,1,1).
ligacao(25,34,1,1).
ligacao(25,35,1,1).
ligacao(25,36,1,1).
ligacao(25,37,1,1).
ligacao(25,38,1,1).

ligacao(26,32,1,1).
ligacao(26,33,1,1).
ligacao(26,34,1,1).
ligacao(26,35,1,1).
ligacao(26,36,1,1).
ligacao(26,37,1,1).
ligacao(26,38,1,1).

ligacao(27,32,1,1).
ligacao(27,33,1,1).
ligacao(27,34,1,1).
ligacao(27,35,1,1).
ligacao(27,36,1,1).
ligacao(27,37,1,1).
ligacao(27,38,1,1).

ligacao(28,32,1,1).
ligacao(28,33,1,1).
ligacao(28,34,1,1).
ligacao(28,35,1,1).
ligacao(28,36,1,1).
ligacao(28,37,1,1).
ligacao(28,38,1,1).

ligacao(29,32,1,1).
ligacao(29,33,1,1).
ligacao(29,34,1,1).
ligacao(29,35,1,1).
ligacao(29,36,1,1).
ligacao(29,37,1,1).
ligacao(29,38,1,1).

ligacao(30,32,1,1).
ligacao(30,33,1,1).
ligacao(30,34,1,1).
ligacao(30,35,1,1).
ligacao(30,36,1,1).
ligacao(30,37,1,1).
ligacao(30,38,1,1).

ligacao(31,32,1,1).
ligacao(31,33,1,1).
ligacao(31,34,1,1).
ligacao(31,35,1,1).
ligacao(31,36,1,1).
ligacao(31,37,1,1).
ligacao(31,38,1,1).



%==============================
%Nivel 5
ligacao(32,39,1,1).
ligacao(32,40,1,1).
ligacao(32,41,1,1).
ligacao(32,42,1,1).
ligacao(32,43,1,1).
ligacao(32,44,1,1).
ligacao(32,45,1,1).

ligacao(33,39,1,1).
ligacao(33,40,1,1).
ligacao(33,41,1,1).
ligacao(33,42,1,1).
ligacao(33,43,1,1).
ligacao(33,44,1,1).
ligacao(33,45,1,1).

ligacao(34,39,1,1).
ligacao(34,40,1,1).
ligacao(34,41,1,1).
ligacao(34,42,1,1).
ligacao(34,43,1,1).
ligacao(34,44,1,1).
ligacao(34,45,1,1).

ligacao(35,39,1,1).
ligacao(35,40,1,1).
ligacao(35,41,1,1).
ligacao(35,42,1,1).
ligacao(35,43,1,1).
ligacao(35,44,1,1).
ligacao(35,45,1,1).

ligacao(36,39,1,1).
ligacao(36,40,1,1).
ligacao(36,41,1,1).
ligacao(36,42,1,1).
ligacao(36,43,1,1).
ligacao(36,44,1,1).
ligacao(36,45,1,1).

ligacao(37,39,1,1).
ligacao(37,40,1,1).
ligacao(37,41,1,1).
ligacao(37,42,1,1).
ligacao(37,43,1,1).
ligacao(37,44,1,1).
ligacao(37,45,1,1).

ligacao(38,39,1,1).
ligacao(38,40,1,1).
ligacao(38,41,1,1).
ligacao(38,42,1,1).
ligacao(38,43,1,1).
ligacao(38,44,1,1).
ligacao(38,45,1,1).


%==============================
%Nivel 6
ligacao(39,46,1,1).
ligacao(39,47,1,1).
ligacao(39,48,1,1).
ligacao(39,49,1,1).
ligacao(39,50,1,1).
ligacao(39,51,1,1).
ligacao(39,52,1,1).

ligacao(40,46,1,1).
ligacao(40,47,1,1).
ligacao(40,48,1,1).
ligacao(40,49,1,1).
ligacao(40,50,1,1).
ligacao(40,51,1,1).
ligacao(40,52,1,1).

ligacao(41,46,1,1).
ligacao(41,47,1,1).
ligacao(41,48,1,1).
ligacao(41,49,1,1).
ligacao(41,50,1,1).
ligacao(41,51,1,1).
ligacao(41,52,1,1).

ligacao(42,46,1,1).
ligacao(42,47,1,1).
ligacao(42,48,1,1).
ligacao(42,49,1,1).
ligacao(42,50,1,1).
ligacao(42,51,1,1).
ligacao(42,52,1,1).

ligacao(43,46,1,1).
ligacao(43,47,1,1).
ligacao(43,48,1,1).
ligacao(43,49,1,1).
ligacao(43,50,1,1).
ligacao(43,51,1,1).
ligacao(43,52,1,1).

ligacao(44,46,1,1).
ligacao(44,47,1,1).
ligacao(44,48,1,1).
ligacao(44,49,1,1).
ligacao(44,50,1,1).
ligacao(44,51,1,1).
ligacao(44,52,1,1).

ligacao(45,46,1,1).
ligacao(45,47,1,1).
ligacao(45,48,1,1).
ligacao(45,49,1,1).
ligacao(45,50,1,1).
ligacao(45,51,1,1).
ligacao(45,52,1,1).


%==============================
%Nivel 7
ligacao(46,53,1,1).
ligacao(46,54,1,1).
ligacao(46,55,1,1).
ligacao(46,56,1,1).
ligacao(46,57,1,1).
ligacao(46,58,1,1).
ligacao(46,59,1,1).

ligacao(47,53,1,1).
ligacao(47,54,1,1).
ligacao(47,55,1,1).
ligacao(47,56,1,1).
ligacao(47,57,1,1).
ligacao(47,58,1,1).
ligacao(47,59,1,1).

ligacao(48,53,1,1).
ligacao(48,54,1,1).
ligacao(48,55,1,1).
ligacao(48,56,1,1).
ligacao(48,57,1,1).
ligacao(48,58,1,1).
ligacao(48,59,1,1).

ligacao(49,53,1,1).
ligacao(49,54,1,1).
ligacao(49,55,1,1).
ligacao(49,56,1,1).
ligacao(49,57,1,1).
ligacao(49,58,1,1).
ligacao(49,59,1,1).

ligacao(50,53,1,1).
ligacao(50,54,1,1).
ligacao(50,55,1,1).
ligacao(50,56,1,1).
ligacao(50,57,1,1).
ligacao(50,58,1,1).
ligacao(50,59,1,1).

ligacao(51,53,1,1).
ligacao(51,54,1,1).
ligacao(51,55,1,1).
ligacao(51,56,1,1).
ligacao(51,57,1,1).
ligacao(51,58,1,1).
ligacao(51,59,1,1).

ligacao(52,53,1,1).
ligacao(52,54,1,1).
ligacao(52,55,1,1).
ligacao(52,56,1,1).
ligacao(52,57,1,1).
ligacao(52,58,1,1).
ligacao(52,59,1,1).

%==============================
%Final
ligacao(53,200,1,1).
ligacao(54,200,1,1).
ligacao(55,200,1,1).
ligacao(56,200,1,1).
ligacao(57,200,1,1).
ligacao(58,200,1,1).
ligacao(59,200,1,1).



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











