% ----------------------------------------------------------
% CAMINHO MAIS FORTE COM FORÇA DE LIGAÇÃO E DE RELAÇÃO
% ----------------------------------------------------------

:-dynamic strongestConnectionRelationshipPathApp/2.

:- use_module(library(http/http_json)).
:- use_module(library(http/http_open)).
:- use_module(library(http/json)).
:- use_module(library(http/json_convert)).
:- use_module(library(http/http_client)).
:- use_module(library(http/http_open)).
:- use_module(library(http/http_server)).
:- use_module(library(http/http_cors)).
:- use_module(library(http/thread_httpd)).


:- http_handler(root(api/strongestPathConnectionRelationship), home_strongest_path_connection_relationship, []).

home_strongest_path_connection_relationship(Request) :-
	cors_enable,
	http_parameters(Request, [origin(Origin,[string]),destination(Destination,[string])]),
	planStrongestLigConnectionRelationshipApp(Origin, Destination, Cam, _),
	reply_json(Cam).

dfsStrongestPathConnectionRelationshipApp(Origem,Destino,Caminho,Forca):-dfs2StrongestPathConnectionRelationshipPath(Origem,Destino,[Origem],Caminho,Forca).

dfs2StrongestPathConnectionRelationshipPath(Destino,Destino,ListaAuxiliar,Caminho,0):-!,reverse(ListaAuxiliar,Caminho).
dfs2StrongestPathConnectionRelationshipPath(Act,Destino,ListaAuxiliar,Caminho,FR):-
	nos(Act,_,_,_),
	(ligacoes(Act,X,ForcaCon,_,ForcaRel,_);ligacoes(X,Act,_,ForcaCon,_,ForcaRel)),
    nos(X,_,_,_),
    \+ member(X,ListaAuxiliar),
    multicriterio(ForcaCon,ForcaRel,Resultado),
    dfs2StrongestPathConnectionRelationshipPath(X,Destino,[X|ListaAuxiliar],Caminho, FR1),
	FR is FR1 + Resultado.


planStrongestLigConnectionRelationshipApp(Origem,Destino,Json,N):-
		getAllUsers(),
		getAllConnections(),
		(melhorCaminhoStrongestPathConnectionRelationshipApp(Origem,Destino);true),
		retract(strongestConnectionRelationshipPathApp(LCaminho,N)),
		createDto(LCaminho, Lista),
		prolog_to_json(Lista, Json),
		(destroy_ligacoes();true),
		(destroy_nos();true).

melhorCaminhoStrongestPathConnectionRelationshipApp(Origem,Destino):-
		asserta(strongestConnectionRelationshipPathApp(_,-10000)),
		dfsStrongestPathConnectionRelationshipApp(Origem,Destino,LCaminho,Forca),
		updateStrongestConnectionRelationshipApp(LCaminho, Forca),
		fail.

updateStrongestConnectionRelationshipApp(LCaminho,Forca):-
		strongestConnectionRelationshipPathApp(_,N),
		Forca>N,retract(strongestConnectionRelationshipPathApp(_,_)),
		asserta(strongestConnectionRelationshipPathApp(LCaminho,Forca)).

