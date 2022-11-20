:- use_module(library(http/http_json)).
:- use_module(library(http/http_open)).
:- use_module(library(http/json)).
:- use_module(library(http/json_convert)).
:- use_module(library(http/http_client)).
:- use_module(library(http/http_open)).
:- use_module(library(http/http_server)).
:- use_module(library(http/http_cors)).
:- use_module(library(http/thread_httpd)).

% ----------------------------------------------------------
% SUGERIR
% ----------------------------------------------------------

%UM CAMINHO PARA CADA
:-dynamic users/1.

:- http_handler(root(api/getSuggestedFriends), home_suggested_friends, []).

home_suggested_friends(Request) :-
	cors_enable,
	http_parameters(Request, [origin(Origin,[string])]),
	suggestConnections(Origin,Result),
	reply_json(Result).

suggestConnections(UserId, Json) :-
	    getAllUsers(),
	    getAllConnections(),
            findall(Other, (nos(UserId,_,TagsUser,_),
	nos(Other,_,TagsOther,_),
	(\+ligacoes(UserId,Other,_,_,_,_);\+ligacoes(Other,UserId,_,_,_,_)),
	intersection(TagsUser, TagsOther, ListaTags),
        length(ListaTags, Tamanho),
        Tamanho>0), List),
	    takeOffRepeatedElements(UserId,List,FinalList),
	    createDto(FinalList, Dto),
		prolog_to_json(Dto, Json),
	    (destroy_ligacoes();true),
	    (destroy_nos();true).

takeOffRepeatedElements(_, [], []).
takeOffRepeatedElements(User, [H|L], List) :- member(H,L), takeOffRepeatedElements(User,L,List).
takeOffRepeatedElements(H, [H|L], List) :- takeOffRepeatedElements(H,L,List).
takeOffRepeatedElements(User, [H|L], [H|List]) :- \+member(H,L), takeOffRepeatedElements(User,L,List).
