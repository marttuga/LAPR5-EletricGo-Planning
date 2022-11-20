% =================================================
% CAMINHO MAIS SEGURO APENAS COM FORÇA DE LIGAÇÃO
% =================================================

:-dynamic safestConnectionPathApp/2.

:- use_module(library(http/http_json)).
:- use_module(library(http/http_open)).
:- use_module(library(http/json)).
:- use_module(library(http/json_convert)).
:- use_module(library(http/http_client)).
:- use_module(library(http/http_open)).
:- use_module(library(http/http_server)).
:- use_module(library(http/http_cors)).
:- use_module(library(http/thread_httpd)).

:- http_handler(root(api/safestPathConnection), home_safest_path_connection, []).

home_safest_path_connection(Request) :-
	cors_enable,
	http_parameters(Request, [origin(Origin,[string]),destination(Destination,[string]),strength(Strength,[integer])]),
	planSafestLigConnectionApp(Origin, Destination, Cam, _, Strength),
	reply_json(Cam).

dfsSafestPathConnectionApp(Origem,Destino,Caminho,Forca,MinimoForca):-dfs2SafestPathConnectionPath(Origem,Destino,[Origem],Caminho,Forca,MinimoForca).

dfs2SafestPathConnectionPath(Destino,Destino,ListaAuxiliar,Caminho,0,_):-!,reverse(ListaAuxiliar,Caminho).
dfs2SafestPathConnectionPath(Act,Destino,ListaAuxiliar,Caminho,FR,MinimoForca):-
	nos(Act,_,_,_),
	(ligacoes(Act,X,Forca,_,_,_);ligacoes(X,Act,_,Forca,_,_)),
        nos(X,_,_,_),
        \+ member(X,ListaAuxiliar),
        Forca >= MinimoForca,
        dfs2SafestPathConnectionPath(X,Destino,[X|ListaAuxiliar],Caminho, FR1, MinimoForca),
	FR is FR1 + Forca.


planSafestLigConnectionApp(Origem,Destino,Json,N,MinimoForca):-
		getAllUsers(),
		getAllConnections(),
		(melhorCaminhoSafestPathConnectionApp(Origem,Destino,MinimoForca);true),
		retract(safestConnectionPathApp(LCaminho,N)),
		createDto(LCaminho, Lista),
		prolog_to_json(Lista, Json),
		(destroy_ligacoes();true),
		(destroy_nos();true).

melhorCaminhoSafestPathConnectionApp(Origem,Destino,MinimoForca):-
		asserta(safestConnectionPathApp(_,-10000)),
		dfsSafestPathConnectionApp(Origem,Destino,LCaminho,Forca,MinimoForca),
		updateSafestConnectionApp(LCaminho, Forca),
		fail.

updateSafestConnectionApp(LCaminho,Forca):-
		safestConnectionPathApp(_,N),
		Forca>N,retract(safestConnectionPathApp(_,_)),
		asserta(safestConnectionPathApp(LCaminho,Forca)).
