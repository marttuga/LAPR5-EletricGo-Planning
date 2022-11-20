% ----------------------------------------------------------
% CAMINHO MAIS FORTE APENAS COM FORÇA DE LIGAÇÃO
% ----------------------------------------------------------

:-dynamic strongestConnectionPathApp/2.

:- use_module(library(http/http_json)).
:- use_module(library(http/http_open)).
:- use_module(library(http/json)).
:- use_module(library(http/json_convert)).
:- use_module(library(http/http_client)).
:- use_module(library(http/http_open)).
:- use_module(library(http/http_server)).
:- use_module(library(http/http_cors)).
:- use_module(library(http/thread_httpd)).

:- http_handler(root(api/strongestPathConnection), home_strongest_path_connection, []).

home_strongest_path_connection(Request) :-
	cors_enable,
	http_parameters(Request, [origin(Origin,[string]),destination(Destination,[string])]),
	planStrongestLigConnectionApp(Origin, Destination, Cam, _),
	reply_json(Cam).

dfsStrongestPathConnectionApp(Origem,Destino,Caminho,Forca):-dfs2SafestPathConnectionPath(Origem,Destino,[Origem],Caminho,Forca).

dfs2SafestPathConnectionPath(Destino,Destino,ListaAuxiliar,Caminho,0):-!,reverse(ListaAuxiliar,Caminho).
dfs2SafestPathConnectionPath(Act,Destino,ListaAuxiliar,Caminho,FR):-
	nos(Act,_,_,_),
	(ligacoes(Act,X,Forca,_,_,_);ligacoes(X,Act,_,Forca,_,_)),
    nos(X,_,_,_),
    \+ member(X,ListaAuxiliar),
    dfs2SafestPathConnectionPath(X,Destino,[X|ListaAuxiliar],Caminho, FR1),
	FR is FR1 + Forca.


planStrongestLigConnectionApp(Origem,Destino,Json,N):-
		getAllUsers(),
		getAllConnections(),
		(melhorCaminhoStrongestPathConnectionApp(Origem,Destino);true),
		retract(strongestConnectionPathApp(LCaminho,N)),
		createDto(LCaminho, Lista),
		prolog_to_json(Lista, Json),
		(destroy_ligacoes();true),
		(destroy_nos();true).

melhorCaminhoStrongestPathConnectionApp(Origem,Destino):-
		asserta(strongestConnectionPathApp(_,-10000)),
		dfsStrongestPathConnectionApp(Origem,Destino,LCaminho,Forca),
		updateStrongestConnectionApp(LCaminho, Forca),
		fail.

updateStrongestConnectionApp(LCaminho,Forca):-
		strongestConnectionPathApp(_,N),
		Forca>N,retract(strongestConnectionPathApp(_,_)),
		asserta(strongestConnectionPathApp(LCaminho,Forca)).

