% Bibliotecas
:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_parameters)).
:- use_module(library(dcg/basics)).
:- use_module(library(http/http_cors)).

% Files Injections
:-consult('Algoritms.pl').
:-include('US1-AllRoutes.pl').
:-include('US2-BestRoute.pl').
:-include('US4-Heuristics.pl').
:-include('directory.pl').

:- consult('BCTrucks.pl').
:- consult('BCDeliveries.pl').
:- consult('BCDadosTrucks.pl').
:- consult('BCWarehouses.pl').
:- consult('BCRoutes.pl').
:-consult('BCDeliveries_2.pl').


% Rela��o entre pedidos HTTP e predicados que os processam
:- http_handler('/getAllRoutesOnDate', getAllRoutesOnDate, []).
:- http_handler('/getBestRoute', getBestRoute, []).
:- http_handler('/getHeuristics', getHeuristics, []).

:- http_handler('/importTrucks', importTrucks, []).
:- http_handler('/importWarehouses', importWarehouses, []).
:- http_handler('/importRoutes', importRoutes, []).
:- http_handler('/importDeliveries', importDeliveries, []).
:- http_handler('/importTrucksData', importTrucksData, []).


% Bibliotecas JSON
:- use_module(library(http/json_convert)).
:- use_module(library(http/http_json)).
:- use_module(library(http/http_cors)).
:- use_module(library(http/json)).

:- json_object plan_minlig(caminho_curto:list(string)).
:- json_object caminho_mais_forte(caminho_forte:list(string)).
:- json_object caminho_mais_forte_plus(caminho_forte_plus:list(string)).
:- json_object caminho_mais_seguro(caminho_mais_seguro:list(string)).
:- json_object suggested_users(users:list(string)).
:- json_object best_first(best_first:list(string)).
:- json_object best_First_With_Emotional_States(best_First_With_Emotional_States:list(string)).


%Cors
:-set_setting(http:cors, [*]).


% Cria��o de servidor HTTP no porto 'Port'
server(Port) :-
        http_server(http_dispatch, [port(Port)]).

trim(S, T) :-
  string_codes(S, C), phrase(trimmed(D), C), string_codes(T, D).
  
trimmed(S) --> blanks, string(S), blanks, eos, !.

% Tratamento de 'http://localhost:64172/getAllRoutesOnDate'
getAllRoutesOnDate(Request) :-
         cors_enable(Request, [methods([get])]),
        format('Content-type: text/plain~n~n'),
        getWorkingDirectory(Dir),
        concat(Dir, 'US1-AllRoutes.pl', Path),
        get_users(Path).

% Tratamento de 'http://localhost:64172/getBestRoute'
getBestRoute(Request) :-
         cors_enable(Request, [methods([get])]),
        format('Content-type: text/plain~n~n'),
        getWorkingDirectory(Dir),
        concat(Dir, 'US2-BestRoute.pl', Path),
        get_users_V2(Path).

% Tratamento de 'http://localhost:64172/getHeuristics'
getHeuristics(Request) :-
        cors_enable(Request, [methods([get])]),
        format('Content-type: text/plain~n~n'),
        getWorkingDirectory(Dir),
        concat(Dir, 'US4-Heuristics.pl', Path),
        get_connections(Path).
  


% Tratamento de 'http://localhost:64172/importTrucks'
importTrucks(Request) :-
        cors_enable(Request, [methods([get])]),
        format('Content-type: text/plain~n~n'),
        getWorkingDirectory(Dir),
        concat(Dir, 'BCTrucks.pl', Path),
        get_connections(Path).


% Tratamento de 'http://localhost:64172/importWarehouses'
importWarehouses(Request) :-
        cors_enable(Request, [methods([get])]),
        format('Content-type: text/plain~n~n'),
        getWorkingDirectory(Dir),
        concat(Dir, 'BCWarehouses.pl', Path),
        get_connections(Path).

% Tratamento de 'http://localhost:64172/importRoutes'
importRoutes(Request) :-
        cors_enable(Request, [methods([get])]),
        format('Content-type: text/plain~n~n'),
        getWorkingDirectory(Dir),
        concat(Dir, 'BCRoutes.pl', Path),
        get_connections(Path).


% Tratamento de 'http://localhost:64172/importDeliveries'
importDeliveries(Request) :-
        cors_enable(Request, [methods([get])]),
        format('Content-type: text/plain~n~n'),
        getWorkingDirectory(Dir),
        concat(Dir, 'BCDeliveries.pl', Path),
        get_connections(Path).


% Tratamento de 'http://localhost:64172/importTrucksData'
importTrucksData(Request) :-
        cors_enable(Request, [methods([get])]),
        format('Content-type: text/plain~n~n'),
        getWorkingDirectory(Dir),
        concat(Dir, 'BCDadosTrucks.pl', Path),
        get_connections(Path).





