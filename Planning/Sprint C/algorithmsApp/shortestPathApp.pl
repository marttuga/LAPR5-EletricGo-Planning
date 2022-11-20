% ----------------------------------------------------------
% CAMINHO MAIS CURTO
% ----------------------------------------------------------
:- use_module(library(http/http_json)).
:- use_module(library(http/http_open)).
:- use_module(library(http/json)).
:- use_module(library(http/json_convert)).
:- use_module(library(http/http_client)).
:- use_module(library(http/http_server)).
:- use_module(library(http/http_json)).
:- use_module(library(http/http_cors)).
:- use_module(library(http/thread_httpd)).

:-dynamic shortestConnectionPathApp/2.

%:- set_setting(http:cors, [*]).

:-dynamic melhor_sol_minlig/2.

:- http_handler(root(api/shortestPath), home_page, []).

home_page(Request) :-
	cors_enable,
	http_parameters(Request, [origin(Origin,[string]),destination(Destination,[string])]),
	planShortestLigApp(Origin, Destination, Cam, _),
	reply_json(Cam).

dfsCaminhoCurtoApp(Origem,Destino,Caminho):-dfs2CaminhoCurtoApp(Origem,Destino,[Origem],Caminho).

dfs2CaminhoCurtoApp(Destino,Destino,ListaAuxiliar,Caminho):-!,reverse(ListaAuxiliar,Caminho).
dfs2CaminhoCurtoApp(Act,Destino,ListaAuxiliar,Caminho):-
	nos(Act,_,_,_),
	(ligacoes(Act,NX,_,_,_,_);ligacoes(NX,Act,_,_,_,_)),
	nos(NX,_,_,_),
    \+ member(NX,ListaAuxiliar),
    dfs2CaminhoCurtoApp(NX,Destino,[NX|ListaAuxiliar],Caminho).


planShortestLigApp(Origem,Destino,Json,N):-
		getAllUsers(),
		getAllConnections(),
		(melhorCaminhoShortestPathApp(Origem,Destino);true),
		retract(shortestConnectionPathApp(LCaminho_minlig,N)),
		createDto(LCaminho_minlig, Lista),
		prolog_to_json(Lista, Json),
		(destroy_ligacoes();true),
		(destroy_nos();true).

melhorCaminhoShortestPathApp(Origem,Destino):-
		asserta(shortestConnectionPathApp(_,10000)),
		dfsCaminhoCurtoApp(Origem,Destino,LCaminho),
		updateShortestPathApp(LCaminho),
		fail.

updateShortestPathApp(LCaminho):-
		shortestConnectionPathApp(_,N),
		length(LCaminho,C),
		C<N,retract(shortestConnectionPathApp(_,_)),
		asserta(shortestConnectionPathApp(LCaminho,C)).
