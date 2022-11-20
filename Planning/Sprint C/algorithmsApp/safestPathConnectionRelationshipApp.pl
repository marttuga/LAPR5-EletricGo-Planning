% =================================================
% CAMINHO MAIS SEGURO COM FORÇA DE LIGAÇÃO E RELAÇÃO
% =================================================

:-dynamic safestConnectionRelationshipPathApp/2.

:- use_module(library(http/http_json)).
:- use_module(library(http/http_open)).
:- use_module(library(http/json)).
:- use_module(library(http/json_convert)).
:- use_module(library(http/http_client)).
:- use_module(library(http/http_open)).
:- use_module(library(http/http_server)).
:- use_module(library(http/http_cors)).
:- use_module(library(http/thread_httpd)).


:- http_handler(root(api/safestPathConnectionRelationship), home_safest_path_connection_relationship, []).

home_safest_path_connection_relationship(Request) :-
	cors_enable,
	http_parameters(Request, [origin(Origin,[string]),destination(Destination,[string]),strength(Strength,[integer])]),
	planSafestLigConnectionRelationshipApp(Origin, Destination, Cam, _, Strength),
	reply_json(Cam).

dfsSafestPathConnectionRelationshipApp(Origem,Destino,Caminho,Forca,MinimoForca):-dfs2SafestPathConnectionRelationshipPath(Origem,Destino,[Origem],Caminho,Forca,MinimoForca).

dfs2SafestPathConnectionRelationshipPath(Destino,Destino,ListaAuxiliar,Caminho,0,_):-!,reverse(ListaAuxiliar,Caminho).
dfs2SafestPathConnectionRelationshipPath(Act,Destino,ListaAuxiliar,Caminho,FR,MinimoForca):-
	nos(Act,_,_,_),
	(ligacoes(Act,X,ForcaCon,_,ForcaRel,_);ligacoes(X,Act,_,ForcaCon,_,ForcaRel)),
        nos(X,_,_,_),
        \+ member(X,ListaAuxiliar),
	multicriterio(ForcaCon,ForcaRel,Resultado),
        Resultado >= MinimoForca,
        dfs2SafestPathConnectionRelationshipPath(X,Destino,[X|ListaAuxiliar],Caminho, FR1, MinimoForca),
	FR is FR1 + Resultado.


planSafestLigConnectionRelationshipApp(Origem,Destino,Json,N,MinimoForca):-		        getAllUsers(),
		getAllConnections(),
		(melhorCaminhoSafestPathConnectionRelationshipApp(Origem,Destino,MinimoForca);true),
		retract(safestConnectionRelationshipPathApp(LCaminho,N)),
		createDto(LCaminho, Lista),
		prolog_to_json(Lista, Json),
		(destroy_ligacoes();true),
		(destroy_nos();true).

melhorCaminhoSafestPathConnectionRelationshipApp(Origem,Destino,MinimoForca):-
		asserta(safestConnectionRelationshipPathApp(_,-10000)),
		dfsSafestPathConnectionRelationshipApp(Origem,Destino,LCaminho,Forca,MinimoForca),
		updateSafestConnectionRelationshipApp(LCaminho, Forca),
		fail.

updateSafestConnectionRelationshipApp(LCaminho,Forca):-
		safestConnectionRelationshipPathApp(_,N),
		Forca>N,retract(safestConnectionRelationshipPathApp(_,_)),
		asserta(safestConnectionRelationshipPathApp(LCaminho,Forca)).
