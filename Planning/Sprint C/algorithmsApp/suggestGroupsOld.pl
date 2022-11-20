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

:-dynamic finalGroup/1.
:- json_object suggestGroupDto(id:string, email:string, userTags:list(string), tagsComuns:list(string)).

%:- http_handler(root(api/suggestGroups),
% suggestGroupController(Method), [ method(Method), methods([post])]).
:- http_handler(root(api/suggestGroups), suggestGroupController, []).

suggestGroupController(Request) :-
	cors_enable,
	http_parameters(Request, [origin(Origin,[string]),n(NrMinUsers,[integer]),t(NrMinTagsComum,[integer])]),
	http_read_data(Request, TagsObrigAtom, []),
	removeSingleQuote2(TagsObrigAtom, TagsObrig),
	getAllUsers(),
	suggestGroup(Origin, NrMinUsers, NrMinTagsComum, TagsObrig, ListUsers),
	(destroy_nos();true),
	toSuggestGroupDto(ListUsers, ListSuggestGroupDto),
	prolog_to_json(ListSuggestGroupDto, Json),
	reply_json(Json).

removeSingleQuote2([],[]).
removeSingleQuote2([H|T],[S|L]):-
	term_to_atom(H,M),
	atom_string(M,S),
	removeSingleQuote2(T,L).



suggestGroup(Origin, NrMinUsers, NrMinTagsComuns, TagsObrig, ListUsers):-
        nos(Origin,_,OriginTags,_),
	intersection(TagsObrig, OriginTags, IntersectionTags),
	length(TagsObrig, Num), length(IntersectionTags, Num),
	assert(finalGroup([])),
	(suggestGroup2(OriginTags, NrMinTagsComuns, TagsObrig);true),
	retract(finalGroup(ListUsers)),
	length(ListUsers, LengthListUsers),
	LengthListUsers >= NrMinUsers.

suggestGroup2(OriginTags, NrMinTagsComuns, TagsObrig):-
	nos(X, XEmail, XTags, _),
	%se ele proprio, nao
	intersection(OriginTags, XTags, TagsComuns),
	length(TagsComuns, LengthTagsComuns),
	LengthTagsComuns >= NrMinTagsComuns,
	intersection(TagsComuns, TagsObrig, TagsComunsObrig),
	length(TagsObrig, Num), length(TagsComunsObrig, Num),
	retract(finalGroup(ListUsers)),
	assert(finalGroup([(X, XEmail, XTags, TagsComuns)|ListUsers])),
	fail.


toSuggestGroupDto([],[]):-!.
toSuggestGroupDto([(UserId, UserEmail, UserTags, TagsComuns)|ListUsers], [Dto|ListDtos]):-
	Dto = suggestGroupDto(UserId, UserEmail, UserTags, TagsComuns),
	toSuggestGroupDto(ListUsers, ListDtos).














