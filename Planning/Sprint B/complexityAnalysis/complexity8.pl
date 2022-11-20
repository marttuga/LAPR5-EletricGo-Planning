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
no(18,rafael1,[natureza,pintura,carros,futebol,lisboa]).

no(19,carlos2,[natureza,pintura,carros,futebol,lisboa]).
no(20,daniel2,[natureza,musica,carros,porto,moda]).
no(21,antoni2,[natureza,pintura,carros,futebol,lisboa]).
no(22,marial2,[natureza,pintura,carros,futebol,lisboa]).
no(23,joanal2,[natureza,pintura,carros,futebol,lisboa]).
no(24,pedrol2,[natureza,pintura,carros,futebol,lisboa]).
no(25,marcia2,[natureza,pintura,carros,futebol,lisboa]).
no(26,rafael2,[natureza,pintura,carros,futebol,lisboa]).

no(27,carlos3,[natureza,pintura,carros,futebol,lisboa]).
no(28,daniel3,[natureza,musica,carros,porto,moda]).
no(29,antoni3,[natureza,pintura,carros,futebol,lisboa]).
no(30,marial3,[natureza,pintura,carros,futebol,lisboa]).
no(31,joanal3,[natureza,pintura,carros,futebol,lisboa]).
no(32,pedrol3,[natureza,pintura,carros,futebol,lisboa]).
no(33,marcia3,[natureza,pintura,carros,futebol,lisboa]).
no(34,rafael3,[natureza,pintura,carros,futebol,lisboa]).

no(35,carlos4,[natureza,pintura,carros,futebol,lisboa]).
no(36,daniel4,[natureza,musica,carros,porto,moda]).
no(37,antoni4,[natureza,pintura,carros,futebol,lisboa]).
no(38,marial4,[natureza,pintura,carros,futebol,lisboa]).
no(39,joanal4,[natureza,pintura,carros,futebol,lisboa]).
no(40,pedrol4,[natureza,pintura,carros,futebol,lisboa]).
no(41,marcia4,[natureza,pintura,carros,futebol,lisboa]).
no(42,rafael4,[natureza,pintura,carros,futebol,lisboa]).

no(43,carlos5,[natureza,pintura,carros,futebol,lisboa]).
no(44,daniel5,[natureza,musica,carros,porto,moda]).
no(45,antoni5,[natureza,pintura,carros,futebol,lisboa]).
no(46,marial5,[natureza,pintura,carros,futebol,lisboa]).
no(47,joanal5,[natureza,pintura,carros,futebol,lisboa]).
no(48,pedrol5,[natureza,pintura,carros,futebol,lisboa]).
no(49,marcia5,[natureza,pintura,carros,futebol,lisboa]).
no(50,rafael5,[natureza,pintura,carros,futebol,lisboa]).

no(51,carlos6,[natureza,pintura,carros,futebol,lisboa]).
no(52,daniel6,[natureza,musica,carros,porto,moda]).
no(53,antoni6,[natureza,pintura,carros,futebol,lisboa]).
no(54,marial6,[natureza,pintura,carros,futebol,lisboa]).
no(55,joanal6,[natureza,pintura,carros,futebol,lisboa]).
no(56,pedrol6,[natureza,pintura,carros,futebol,lisboa]).
no(57,marcia6,[natureza,pintura,carros,futebol,lisboa]).
no(58,rafael6,[natureza,pintura,carros,futebol,lisboa]).

no(59,carlos7,[natureza,pintura,carros,futebol,lisboa]).
no(60,daniel7,[natureza,musica,carros,porto,moda]).
no(61,antoni7,[natureza,pintura,carros,futebol,lisboa]).
no(62,marial7,[natureza,pintura,carros,futebol,lisboa]).
no(63,joanal7,[natureza,pintura,carros,futebol,lisboa]).
no(64,pedrol7,[natureza,pintura,carros,futebol,lisboa]).
no(65,marcia7,[natureza,pintura,carros,futebol,lisboa]).
no(66,rafael7,[natureza,pintura,carros,futebol,lisboa]).

no(67,carlos8,[natureza,pintura,carros,futebol,lisboa]).
no(68,daniel8,[natureza,musica,carros,porto,moda]).
no(69,antoni8,[natureza,pintura,carros,futebol,lisboa]).
no(70,marial8,[natureza,pintura,carros,futebol,lisboa]).
no(71,joanal8,[natureza,pintura,carros,futebol,lisboa]).
no(72,pedrol8,[natureza,pintura,carros,futebol,lisboa]).
no(73,marcia8,[natureza,pintura,carros,futebol,lisboa]).
no(74,rafael8,[natureza,pintura,carros,futebol,lisboa]).



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
ligacao(1,18,1,1).

%==============================
%Nivel 2

ligacao(11,19,1,1).
ligacao(11,20,1,1).
ligacao(11,21,1,1).
ligacao(11,22,1,1).
ligacao(11,23,1,1).
ligacao(11,24,1,1).
ligacao(11,25,1,1).
ligacao(11,26,1,1).

ligacao(12,19,1,1).
ligacao(12,20,1,1).
ligacao(12,21,1,1).
ligacao(12,22,1,1).
ligacao(12,23,1,1).
ligacao(12,24,1,1).
ligacao(12,25,1,1).
ligacao(12,26,1,1).

ligacao(13,19,1,1).
ligacao(13,20,1,1).
ligacao(13,21,1,1).
ligacao(13,22,1,1).
ligacao(13,23,1,1).
ligacao(13,24,1,1).
ligacao(13,25,1,1).
ligacao(13,26,1,1).

ligacao(14,19,1,1).
ligacao(14,20,1,1).
ligacao(14,21,1,1).
ligacao(14,22,1,1).
ligacao(14,23,1,1).
ligacao(14,24,1,1).
ligacao(14,25,1,1).
ligacao(14,26,1,1).

ligacao(15,19,1,1).
ligacao(15,20,1,1).
ligacao(15,21,1,1).
ligacao(15,22,1,1).
ligacao(15,23,1,1).
ligacao(15,24,1,1).
ligacao(15,25,1,1).
ligacao(15,26,1,1).

ligacao(16,19,1,1).
ligacao(16,20,1,1).
ligacao(16,21,1,1).
ligacao(16,22,1,1).
ligacao(16,23,1,1).
ligacao(16,24,1,1).
ligacao(16,25,1,1).
ligacao(16,26,1,1).

ligacao(17,19,1,1).
ligacao(17,20,1,1).
ligacao(17,21,1,1).
ligacao(17,22,1,1).
ligacao(17,23,1,1).
ligacao(17,24,1,1).
ligacao(17,25,1,1).
ligacao(17,26,1,1).

ligacao(18,19,1,1).
ligacao(18,20,1,1).
ligacao(18,21,1,1).
ligacao(18,22,1,1).
ligacao(18,23,1,1).
ligacao(18,24,1,1).
ligacao(18,25,1,1).
ligacao(18,26,1,1).


%==============================
%Nivel 3

ligacao(19,27,1,1).
ligacao(19,28,1,1).
ligacao(19,29,1,1).
ligacao(19,30,1,1).
ligacao(19,31,1,1).
ligacao(19,32,1,1).
ligacao(19,33,1,1).
ligacao(19,34,1,1).

ligacao(20,27,1,1).
ligacao(20,28,1,1).
ligacao(20,29,1,1).
ligacao(20,30,1,1).
ligacao(20,31,1,1).
ligacao(20,32,1,1).
ligacao(20,33,1,1).
ligacao(20,34,1,1).

ligacao(21,27,1,1).
ligacao(21,28,1,1).
ligacao(21,29,1,1).
ligacao(21,30,1,1).
ligacao(21,31,1,1).
ligacao(21,32,1,1).
ligacao(21,33,1,1).
ligacao(21,34,1,1).

ligacao(22,27,1,1).
ligacao(22,28,1,1).
ligacao(22,29,1,1).
ligacao(22,30,1,1).
ligacao(22,31,1,1).
ligacao(22,32,1,1).
ligacao(22,33,1,1).
ligacao(22,34,1,1).

ligacao(23,27,1,1).
ligacao(23,28,1,1).
ligacao(23,29,1,1).
ligacao(23,30,1,1).
ligacao(23,31,1,1).
ligacao(23,32,1,1).
ligacao(23,33,1,1).
ligacao(23,34,1,1).

ligacao(24,27,1,1).
ligacao(24,28,1,1).
ligacao(24,29,1,1).
ligacao(24,30,1,1).
ligacao(24,31,1,1).
ligacao(24,32,1,1).
ligacao(24,33,1,1).
ligacao(24,34,1,1).

ligacao(25,27,1,1).
ligacao(25,28,1,1).
ligacao(25,29,1,1).
ligacao(25,30,1,1).
ligacao(25,31,1,1).
ligacao(25,32,1,1).
ligacao(25,33,1,1).
ligacao(25,34,1,1).

ligacao(26,27,1,1).
ligacao(26,28,1,1).
ligacao(26,29,1,1).
ligacao(26,30,1,1).
ligacao(26,31,1,1).
ligacao(26,32,1,1).
ligacao(26,33,1,1).
ligacao(26,34,1,1).


%==============================
%Nivel 4

ligacao(27,35,1,1).
ligacao(27,36,1,1).
ligacao(27,37,1,1).
ligacao(27,38,1,1).
ligacao(27,39,1,1).
ligacao(27,40,1,1).
ligacao(27,41,1,1).
ligacao(27,42,1,1).

ligacao(28,35,1,1).
ligacao(28,36,1,1).
ligacao(28,37,1,1).
ligacao(28,38,1,1).
ligacao(28,39,1,1).
ligacao(28,40,1,1).
ligacao(28,41,1,1).
ligacao(28,42,1,1).

ligacao(29,35,1,1).
ligacao(29,36,1,1).
ligacao(29,37,1,1).
ligacao(29,38,1,1).
ligacao(29,39,1,1).
ligacao(29,40,1,1).
ligacao(29,41,1,1).
ligacao(29,42,1,1).

ligacao(30,35,1,1).
ligacao(30,36,1,1).
ligacao(30,37,1,1).
ligacao(30,38,1,1).
ligacao(30,39,1,1).
ligacao(30,40,1,1).
ligacao(30,41,1,1).
ligacao(30,42,1,1).

ligacao(31,35,1,1).
ligacao(31,36,1,1).
ligacao(31,37,1,1).
ligacao(31,38,1,1).
ligacao(31,39,1,1).
ligacao(31,40,1,1).
ligacao(31,41,1,1).
ligacao(31,42,1,1).

ligacao(32,35,1,1).
ligacao(32,36,1,1).
ligacao(32,37,1,1).
ligacao(32,38,1,1).
ligacao(32,39,1,1).
ligacao(32,40,1,1).
ligacao(32,41,1,1).
ligacao(32,42,1,1).

ligacao(33,35,1,1).
ligacao(33,36,1,1).
ligacao(33,37,1,1).
ligacao(33,38,1,1).
ligacao(33,39,1,1).
ligacao(33,40,1,1).
ligacao(33,41,1,1).
ligacao(33,42,1,1).

ligacao(34,35,1,1).
ligacao(34,36,1,1).
ligacao(34,37,1,1).
ligacao(34,38,1,1).
ligacao(34,39,1,1).
ligacao(34,40,1,1).
ligacao(34,41,1,1).
ligacao(34,42,1,1).


%==============================
%Nivel 5

ligacao(35,43,1,1).
ligacao(35,44,1,1).
ligacao(35,45,1,1).
ligacao(35,46,1,1).
ligacao(35,47,1,1).
ligacao(35,48,1,1).
ligacao(35,49,1,1).
ligacao(35,50,1,1).

ligacao(36,43,1,1).
ligacao(36,44,1,1).
ligacao(36,45,1,1).
ligacao(36,46,1,1).
ligacao(36,47,1,1).
ligacao(36,48,1,1).
ligacao(36,49,1,1).
ligacao(36,50,1,1).

ligacao(37,43,1,1).
ligacao(37,44,1,1).
ligacao(37,45,1,1).
ligacao(37,46,1,1).
ligacao(37,47,1,1).
ligacao(37,48,1,1).
ligacao(37,49,1,1).
ligacao(37,50,1,1).

ligacao(38,43,1,1).
ligacao(38,44,1,1).
ligacao(38,45,1,1).
ligacao(38,46,1,1).
ligacao(38,47,1,1).
ligacao(38,48,1,1).
ligacao(38,49,1,1).
ligacao(38,50,1,1).

ligacao(39,43,1,1).
ligacao(39,44,1,1).
ligacao(39,45,1,1).
ligacao(39,46,1,1).
ligacao(39,47,1,1).
ligacao(39,48,1,1).
ligacao(39,49,1,1).
ligacao(39,50,1,1).

ligacao(40,43,1,1).
ligacao(40,44,1,1).
ligacao(40,45,1,1).
ligacao(40,46,1,1).
ligacao(40,47,1,1).
ligacao(40,48,1,1).
ligacao(40,49,1,1).
ligacao(40,50,1,1).

ligacao(41,43,1,1).
ligacao(41,44,1,1).
ligacao(41,45,1,1).
ligacao(41,46,1,1).
ligacao(41,47,1,1).
ligacao(41,48,1,1).
ligacao(41,49,1,1).
ligacao(41,50,1,1).

ligacao(42,43,1,1).
ligacao(42,44,1,1).
ligacao(42,45,1,1).
ligacao(42,46,1,1).
ligacao(42,47,1,1).
ligacao(42,48,1,1).
ligacao(42,49,1,1).
ligacao(42,50,1,1).


%==============================
%Nivel 6

ligacao(43,51,1,1).
ligacao(43,52,1,1).
ligacao(43,53,1,1).
ligacao(43,54,1,1).
ligacao(43,55,1,1).
ligacao(43,56,1,1).
ligacao(43,57,1,1).
ligacao(43,58,1,1).

ligacao(44,51,1,1).
ligacao(44,52,1,1).
ligacao(44,53,1,1).
ligacao(44,54,1,1).
ligacao(44,55,1,1).
ligacao(44,56,1,1).
ligacao(44,57,1,1).
ligacao(44,58,1,1).

ligacao(45,51,1,1).
ligacao(45,52,1,1).
ligacao(45,53,1,1).
ligacao(45,54,1,1).
ligacao(45,55,1,1).
ligacao(45,56,1,1).
ligacao(45,57,1,1).
ligacao(45,58,1,1).

ligacao(46,51,1,1).
ligacao(46,52,1,1).
ligacao(46,53,1,1).
ligacao(46,54,1,1).
ligacao(46,55,1,1).
ligacao(46,56,1,1).
ligacao(46,57,1,1).
ligacao(46,58,1,1).

ligacao(47,51,1,1).
ligacao(47,52,1,1).
ligacao(47,53,1,1).
ligacao(47,54,1,1).
ligacao(47,55,1,1).
ligacao(47,56,1,1).
ligacao(47,57,1,1).
ligacao(47,58,1,1).

ligacao(48,51,1,1).
ligacao(48,52,1,1).
ligacao(48,53,1,1).
ligacao(48,54,1,1).
ligacao(48,55,1,1).
ligacao(48,56,1,1).
ligacao(48,57,1,1).
ligacao(48,58,1,1).

ligacao(49,51,1,1).
ligacao(49,52,1,1).
ligacao(49,53,1,1).
ligacao(49,54,1,1).
ligacao(49,55,1,1).
ligacao(49,56,1,1).
ligacao(49,57,1,1).
ligacao(49,58,1,1).

ligacao(50,51,1,1).
ligacao(50,52,1,1).
ligacao(50,53,1,1).
ligacao(50,54,1,1).
ligacao(50,55,1,1).
ligacao(50,56,1,1).
ligacao(50,57,1,1).
ligacao(50,58,1,1).


%==============================
%Nivel 7

ligacao(51,59,1,1).
ligacao(51,60,1,1).
ligacao(51,61,1,1).
ligacao(51,62,1,1).
ligacao(51,63,1,1).
ligacao(51,64,1,1).
ligacao(51,65,1,1).
ligacao(51,66,1,1).

ligacao(52,59,1,1).
ligacao(52,60,1,1).
ligacao(52,61,1,1).
ligacao(52,62,1,1).
ligacao(52,63,1,1).
ligacao(52,64,1,1).
ligacao(52,65,1,1).
ligacao(52,66,1,1).

ligacao(53,59,1,1).
ligacao(53,60,1,1).
ligacao(53,61,1,1).
ligacao(53,62,1,1).
ligacao(53,63,1,1).
ligacao(53,64,1,1).
ligacao(53,65,1,1).
ligacao(53,66,1,1).

ligacao(54,59,1,1).
ligacao(54,60,1,1).
ligacao(54,61,1,1).
ligacao(54,62,1,1).
ligacao(54,63,1,1).
ligacao(54,64,1,1).
ligacao(54,65,1,1).
ligacao(54,66,1,1).

ligacao(55,59,1,1).
ligacao(55,60,1,1).
ligacao(55,61,1,1).
ligacao(55,62,1,1).
ligacao(55,63,1,1).
ligacao(55,64,1,1).
ligacao(55,65,1,1).
ligacao(55,66,1,1).

ligacao(56,59,1,1).
ligacao(56,60,1,1).
ligacao(56,61,1,1).
ligacao(56,62,1,1).
ligacao(56,63,1,1).
ligacao(56,64,1,1).
ligacao(56,65,1,1).
ligacao(56,66,1,1).

ligacao(57,59,1,1).
ligacao(57,60,1,1).
ligacao(57,61,1,1).
ligacao(57,62,1,1).
ligacao(57,63,1,1).
ligacao(57,64,1,1).
ligacao(57,65,1,1).
ligacao(57,66,1,1).

ligacao(58,59,1,1).
ligacao(58,60,1,1).
ligacao(58,61,1,1).
ligacao(58,62,1,1).
ligacao(58,63,1,1).
ligacao(58,64,1,1).
ligacao(58,65,1,1).
ligacao(58,66,1,1).


%==============================
%Nivel 8

ligacao(59,67,1,1).
ligacao(59,68,1,1).
ligacao(59,69,1,1).
ligacao(59,70,1,1).
ligacao(59,71,1,1).
ligacao(59,72,1,1).
ligacao(59,73,1,1).
ligacao(59,74,1,1).

ligacao(60,67,1,1).
ligacao(60,68,1,1).
ligacao(60,69,1,1).
ligacao(60,70,1,1).
ligacao(60,71,1,1).
ligacao(60,72,1,1).
ligacao(60,73,1,1).
ligacao(60,74,1,1).

ligacao(61,67,1,1).
ligacao(61,68,1,1).
ligacao(61,69,1,1).
ligacao(61,70,1,1).
ligacao(61,71,1,1).
ligacao(61,72,1,1).
ligacao(61,73,1,1).
ligacao(61,74,1,1).

ligacao(62,67,1,1).
ligacao(62,68,1,1).
ligacao(62,69,1,1).
ligacao(62,70,1,1).
ligacao(62,71,1,1).
ligacao(62,72,1,1).
ligacao(62,73,1,1).
ligacao(62,74,1,1).

ligacao(63,67,1,1).
ligacao(63,68,1,1).
ligacao(63,69,1,1).
ligacao(63,70,1,1).
ligacao(63,71,1,1).
ligacao(63,72,1,1).
ligacao(63,73,1,1).
ligacao(63,74,1,1).

ligacao(64,67,1,1).
ligacao(64,68,1,1).
ligacao(64,69,1,1).
ligacao(64,70,1,1).
ligacao(64,71,1,1).
ligacao(64,72,1,1).
ligacao(64,73,1,1).
ligacao(64,74,1,1).

ligacao(65,67,1,1).
ligacao(65,68,1,1).
ligacao(65,69,1,1).
ligacao(65,70,1,1).
ligacao(65,71,1,1).
ligacao(65,72,1,1).
ligacao(65,73,1,1).
ligacao(65,74,1,1).

ligacao(66,67,1,1).
ligacao(66,68,1,1).
ligacao(66,69,1,1).
ligacao(66,70,1,1).
ligacao(66,71,1,1).
ligacao(66,72,1,1).
ligacao(66,73,1,1).
ligacao(66,74,1,1).

%==============================
%Final
ligacao(67,200,1,1).
ligacao(68,200,1,1).
ligacao(69,200,1,1).
ligacao(70,200,1,1).
ligacao(71,200,1,1).
ligacao(72,200,1,1).
ligacao(73,200,1,1).
ligacao(74,200,1,1).


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











