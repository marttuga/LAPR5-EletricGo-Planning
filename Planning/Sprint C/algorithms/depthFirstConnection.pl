dfsFortConnection(Origem,Destino,N,M,Caminho,Forca):-dfs3Connection(Origem,Destino,[Origem],N,M,Caminho,Forca).

dfs3Connection(Destino,Destino,ListaAuxiliar,_,_,Caminho,0):-!,reverse(ListaAuxiliar,Caminho).
dfs3Connection(Act,Destino,ListaAuxiliar,N,M,Caminho,FR):-
    node(Act),
    N>M,
    (edge_com_forcas(Act,X,Forca,_,_,_);edge_com_forcas(X,Act,_,Forca,_,_)),
    node(X),
    \+member(X,ListaAuxiliar),
    M1 is M+1,
    dfs3Connection(X,Destino,[X|ListaAuxiliar],N,M1,Caminho, FR1),
    FR is FR1 + Forca.

plan_fortligConnection(Origem,Destino,LCaminho_minlig,Custo,N):-
    %(generate_random_edges(); true),
    get_time(Ti),
    (melhor_caminho_minlig1Connection(Origem,Destino,N,0);true),
    retract(melhor_sol_minlig1Connection(LCaminho_minlig,Custo)),
    get_time(Tf),
    T is Tf-Ti,
    %(destroy_edges(); true),
    write('Tempo de geracao da solucao:'),write(T),nl.

melhor_caminho_minlig1Connection(Origem,Destino,N,M):-
    asserta(melhor_sol_minlig1Connection(_,-10000)),
    dfsFortConnection(Origem,Destino,N,M,LCaminho,Forca),
    atualiza_melhor_minlig1Connection(LCaminho, Forca),
    fail.

atualiza_melhor_minlig1Connection(LCaminho,Forca):-
    melhor_sol_minlig1Connection(_,N),
    Forca>N,retract(melhor_sol_minlig1Connection(_,_)),
    asserta(melhor_sol_minlig1Connection(LCaminho,Forca)).













