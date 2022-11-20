:- use_module(library(http/http_json)).
:- use_module(library(http/http_open)).
:- use_module(library(http/json)).
:- use_module(library(http/json_convert)).
:- use_module(library(http/http_client)).
:- use_module(library(http/http_server)).
:- use_module(library(http/http_json)).
:- use_module(library(http/http_cors)).
:- use_module(library(http/thread_httpd)).

:- http_handler(root(api/getNewJoyAndDistressValues), home_new_joy_distress_values, []).

home_new_joy_distress_values(Request) :-
	cors_enable,
	http_parameters(Request, [userId(UserId,[string]),sum(Sum,[integer])]),
	calculateVariationEmotionalJoyDistress(UserId, Sum, 200, Dto),
	reply_json(Dto).

calculateVariationEmotionalJoyDistress(User, Sum, SaturationValue, Dto) :-
            getAllUsers(),
            getAllConnections(),
            nos(User,_,_,X),
            searchValuesLikesDislikes(X, OldJoyValue, OldDistressValue),
            MinimumValue is min(Sum,SaturationValue),
            JoyValueTemp is (OldJoyValue + (1-OldJoyValue) * (MinimumValue/SaturationValue)),
            DistressValueTemp is (OldDistressValue * (1-(MinimumValue/SaturationValue))),
            verifyValue(JoyValueTemp, JoyValue),
            verifyValue(DistressValueTemp, DistressValue), !,
            createDtoJoyDistress(JoyValue, DistressValue, TempDto),
            prolog_to_json(TempDto, Dto),
            (destroy_ligacoes();true),
            (destroy_nos();true).

searchValuesLikesDislikes([], _, _):- !.

searchValuesLikesDislikes([(Emocao, Value)|L], Value, OldDistressValue) :-
                Emocao = "Joyful",
                searchValuesLikesDislikes(L, Value, OldDistressValue), !.

searchValuesLikesDislikes([(Emocao, Value)|L], OldJoyValue, Value) :-
                Emocao = "Distressed",
                searchValuesLikesDislikes(L, OldJoyValue, Value), !.

searchValuesLikesDislikes([(_, _)|L], OldJoyValue, OldDistressValue) :-
                searchValuesLikesDislikes(L, OldJoyValue, OldDistressValue), !.
