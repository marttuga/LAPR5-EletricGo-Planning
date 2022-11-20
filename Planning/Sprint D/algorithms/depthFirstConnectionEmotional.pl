dfsFortConnectionEmotional(Origem,Destino,N,M,Caminho,Forca,ListaEmocoes):-
        dfs3ConnectionEmotional(Origem,Destino,[Origem],N,M,Caminho,Forca,ListaEmocoes).

dfs3ConnectionEmotional(Destino,Destino,ListaAuxiliar,_,_,Caminho,0,_):-!,reverse(ListaAuxiliar,Caminho).
dfs3ConnectionEmotional(Act,Destino,ListaAuxiliar,N,M,Caminho,FR,ListaEmocoes):-
    node(Act,_),
    N>M,
    (edge_com_forcas(Act,X,Forca,_,_,_);edge_com_forcas(X,Act,_,Forca,_,_)),
    node(X,Lista),
    \+member(X,ListaAuxiliar),
    verificaEmocoesConnectionD(Lista,ListaEmocoes),
    M1 is M+1,
    dfs3ConnectionEmotional(X,Destino,[X|ListaAuxiliar],N,M1,Caminho, FR1,ListaEmocoes),
    FR is FR1 + Forca.

plan_fortligConnectionEmotional(Origem,Destino,LCaminho_minlig,Custo,N,ListaEmocoes):-
    %(generate_random_edges(); true),
    get_time(Ti),
    (melhor_caminho_minlig1ConnectionEmotional(Origem,Destino,N,0,ListaEmocoes);true),
    retract(melhor_sol_minlig1ConnectionE(LCaminho_minlig,Custo)),
    get_time(Tf),
    T is Tf-Ti,
    %(destroy_edges(); true),
    write('Tempo de geracao da solucao:'),write(T),nl.

melhor_caminho_minlig1ConnectionEmotional(Origem,Destino,N,M,ListaEmocoes):-
    asserta(melhor_sol_minlig1ConnectionE(_,-10000)),
    dfsFortConnectionEmotional(Origem,Destino,N,M,LCaminho,Forca,ListaEmocoes),
    atualiza_melhor_minlig1Connection(LCaminho, Forca),
    fail.

atualiza_melhor_minlig1Connection(LCaminho,Forca):-
    melhor_sol_minlig1ConnectionE(_,N),
    Forca>N,retract(melhor_sol_minlig1ConnectionE(_,_)),
    asserta(melhor_sol_minlig1ConnectionE(LCaminho,Forca)).


verificaEmocoesConnectionD(_, []):- !.

% o T vai ter o aspeto (emoção, valor)
verificaEmocoesConnectionD(Lista, [(Emocao,Valor)|L]):-
                                        percorreConnectionEmotionalD(Lista, Emocao, V),
                                        (V =< Valor; fail),
                                        verificaEmocoesConnectionD(Lista, L).

percorreConnectionEmotionalD([], _, _):- !.

percorreConnectionEmotionalD([(E, V)|_], E, V):- !.

percorreConnectionEmotionalD([(_, _)| T], Emocao, Valor):-
                                    percorreConnectionEmotionalD(T, Emocao, Valor).











