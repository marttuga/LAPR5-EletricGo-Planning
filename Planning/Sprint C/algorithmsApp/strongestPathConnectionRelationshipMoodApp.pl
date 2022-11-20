:-dynamic strongestConnectionRelationshipPathMoodApp/2.

:- use_module(library(http/http_json)).
:- use_module(library(http/http_open)).
:- use_module(library(http/json)).
:- use_module(library(http/json_convert)).
:- use_module(library(http/http_client)).
:- use_module(library(http/http_open)).
:- use_module(library(http/http_server)).
:- use_module(library(http/http_cors)).
:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_parameters)).
:- use_module(library(http/http_dispatch)).

:- http_handler(root(api/strongestPathConnectionRelationshipMood), home_strongest_path_connection_relationship_mood, []).

home_strongest_path_connection_relationship_mood(Request) :-
	cors_enable,
	http_parameters(Request, [origin(Origin,[string]),destination(Destination,[string])]),
	http_read_data(Request, Mood, []),
	removeSingleQuoteConnectionRelation(Mood,ListMood),
	planStrongestLigConnectionRelationshipMoodApp(Origin, Destination, ListMood, Cam, _),
	reply_json(Cam).

removeSingleQuoteConnectionRelation([],[]):-!.
removeSingleQuoteConnectionRelation([H|T],[M|L]):-
	term_to_atom(M,H),
	removeSingleQuoteConnectionRelation(T,L).

dfsStrongestPathConnectionRelationshipMoodApp(Origem,Destino,ListaEmocoes,Caminho,Forca):-dfs2StrongestPathConnectionRelationshipMoodPath(Origem,Destino,ListaEmocoes,[Origem],Caminho,Forca).

dfs2StrongestPathConnectionRelationshipMoodPath(Destino,Destino,_,ListaAuxiliar,Caminho,0):-!,reverse(ListaAuxiliar,Caminho).
dfs2StrongestPathConnectionRelationshipMoodPath(Act,Destino,ListaEmocoes,ListaAuxiliar,Caminho,FR):-
	nos(Act,_,_,_),
	(ligacoes(Act,X,ForcaCon,_,ForcaRel,_);ligacoes(X,Act,_,ForcaCon,_,ForcaRel)),
    nos(X,_,_,Lista),
    verificaEmocoesConnectionRelationMood(Lista,ListaEmocoes),
    \+ member(X,ListaAuxiliar),
    multicriterio(ForcaCon,ForcaRel,Resultado),
    dfs2StrongestPathConnectionRelationshipMoodPath(X,Destino,ListaEmocoes,[X|ListaAuxiliar],Caminho, FR1),
	FR is FR1 + Resultado.


planStrongestLigConnectionRelationshipMoodApp(Origem,Destino,ListaEmocoes,Json,N):-
		getAllUsers(),
		getAllConnections(),
		(melhorCaminhoStrongestPathConnectionRelationshipMoodApp(Origem,Destino,ListaEmocoes);true),
		retract(strongestConnectionRelationshipPathMoodApp(LCaminho,N)),
		createDto(LCaminho, Lista),
		prolog_to_json(Lista, Json),
		(destroy_ligacoes();true),
		(destroy_nos();true).

melhorCaminhoStrongestPathConnectionRelationshipMoodApp(Origem,Destino,ListaEmocoes):-
		asserta(strongestConnectionRelationshipPathMoodApp(_,-10000)),
		dfsStrongestPathConnectionRelationshipMoodApp(Origem,Destino,ListaEmocoes,LCaminho,Forca),
		updateStrongestConnectionRelationshipMoodApp(LCaminho, Forca),
		fail.

updateStrongestConnectionRelationshipMoodApp(LCaminho,Forca):-
		strongestConnectionRelationshipPathMoodApp(_,N),
		Forca>N,retract(strongestConnectionRelationshipPathMoodApp(_,_)),
		asserta(strongestConnectionRelationshipPathMoodApp(LCaminho,Forca)).

verificaEmocoesConnectionRelationMood(_, []):- !.

% o T vai ter o aspeto (emoção, valor)
verificaEmocoesConnectionRelationMood(Lista, [(Emocao,Valor)|L]):-
                                        percorreConnectionRelationEmotionalMood(Lista, Emocao, V),
                                        (V =< Valor; fail),
                                        verificaEmocoesConnectionRelationMood(Lista, L).

percorreConnectionRelationEmotionalMood([], _, _):- !.

percorreConnectionRelationEmotionalMood([(E, V)|_], E, V):- !.

percorreConnectionRelationEmotionalMood([(_, _)| T], Emocao, Valor):-
                                    percorreConnectionRelationEmotionalMood(T, Emocao, Valor).




