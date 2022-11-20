:-dynamic strongestConnectionMoodPathApp/2.

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

:- http_handler(root(api/strongestPathConnectionMood), home_strongest_path_connection_mood, []).

home_strongest_path_connection_mood(Request) :-
	cors_enable,
	http_parameters(Request, [origin(Origin,[string]),destination(Destination,[string])]),
	http_read_data(Request, Mood, []),
	removeSingleQuote(Mood,ListMood),
	planStrongestLigConnectionMoodApp(Origin, Destination, ListMood, Cam, _),
	reply_json(Cam).

removeSingleQuote([],[]):-!.
removeSingleQuote([H|T],[M|L]):-
	term_to_atom(M,H),
	removeSingleQuote(T,L).

dfsStrongestPathConnectionMoodApp(Origem,Destino,ListaEmocoes,Caminho,Forca):-dfs2SafestPathConnectionMoodPath(Origem,Destino,ListaEmocoes,[Origem],Caminho,Forca).

dfs2SafestPathConnectionMoodPath(Destino,Destino,_,ListaAuxiliar,Caminho,0):-!,reverse(ListaAuxiliar,Caminho).
dfs2SafestPathConnectionMoodPath(Act,Destino,ListaEmocoes,ListaAuxiliar,Caminho,FR):-
	nos(Act,_,_,_),
	(ligacoes(Act,X,Forca,_,_,_);ligacoes(X,Act,_,Forca,_,_)),
    nos(X,_,_,Lista),
    verificaEmocoesConnectionMood(Lista,ListaEmocoes),
    \+ member(X,ListaAuxiliar),
    dfs2SafestPathConnectionMoodPath(X,Destino,ListaEmocoes,[X|ListaAuxiliar],Caminho, FR1),
	FR is FR1 + Forca.


planStrongestLigConnectionMoodApp(Origem,Destino,ListaEmocoes,Json,N):-
		getAllUsers(),
		getAllConnections(),
		(melhorCaminhoStrongestPathConnectionMoodApp(Origem,Destino,ListaEmocoes);true),
		retract(strongestConnectionMoodPathApp(LCaminho,N)),
		createDto(LCaminho, Lista),
		prolog_to_json(Lista, Json),
		(destroy_ligacoes();true),
		(destroy_nos();true).

melhorCaminhoStrongestPathConnectionMoodApp(Origem,Destino,ListaEmocoes):-
		asserta(strongestConnectionMoodPathApp(_,-10000)),
		dfsStrongestPathConnectionMoodApp(Origem,Destino,ListaEmocoes,LCaminho,Forca),
		updateStrongestConnectionMoodApp(LCaminho, Forca),
		fail.

updateStrongestConnectionMoodApp(LCaminho,Forca):-
		strongestConnectionMoodPathApp(_,N),
		Forca>N,retract(strongestConnectionMoodPathApp(_,_)),
		asserta(strongestConnectionMoodPathApp(LCaminho,Forca)).

verificaEmocoesConnectionMood(_, []):- !.

% o T vai ter o aspeto (emoção, valor)
verificaEmocoesConnectionMood(Lista, [(Emocao,Valor)|L]):-
                                        percorreConnectionEmotionalMood(Lista, Emocao, V),
                                        (V =< Valor; fail),
                                        verificaEmocoesConnectionMood(Lista, L).

percorreConnectionEmotionalMood([], _, _):- !.

percorreConnectionEmotionalMood([(E, V)|_], E, V):- !.

percorreConnectionEmotionalMood([(_, _)| T], Emocao, Valor):-
                                    percorreConnectionEmotionalMood(T, Emocao, Valor).









