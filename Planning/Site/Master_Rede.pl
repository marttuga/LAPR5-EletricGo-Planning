% Bibliotecas
:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_parameters)).
:- use_module(library(dcg/basics)).
:- use_module(library(http/http_cors)).

% Files Injections
:-include('US1-AllRoutes.pl').
:-include('US2-BestRoute.pl').
:-include('US4-Heuristics.pl').

% Rela��o entre pedidos HTTP e predicados que os processam
:- http_handler('/getAllRoutesOnDate', getAllRoutesOnDate, []).
:- http_handler('/getBestRoute', getBestRoute, []).
:- http_handler('/getNearestWarehouse', getNearestWarehouse, []).
:- http_handler('/getRouteGreaterMass', getRouteGreaterMass, []).
:- http_handler('/getRouteBestRelation', getRouteBestRelation, []).

% Bibliotecas JSON
:- use_module(library(http/json_convert)).
:- use_module(library(http/http_json)).
:- use_module(library(http/http_cors)).
:- use_module(library(http/json)).

:- json_object finalRoute(final_route:list(string)).
:- json_object bestRoute(best_route:list(string)).
:- json_object bestRouteNearestWarehouse(route_nearest_warehouse:list(string)).
:- json_object bestRoutePlusMass(route_plus_mass:list(string)).
:- json_object bestRouteBestRelation(route_best_relation:list(string)).

:- consult('BCTrucks.pl').
:- consult('BCDeliveries.pl').
:- consult('BCDadosTrucks.pl').
:- consult('BCWarehouses.pl').
:- consult('BCRoutes.pl').

%Cors
:-set_setting(http:cors, [*]).


% Cria��o de servidor HTTP no porto 'Port'
server(Port) :-
        http_server(http_dispatch, [port(Port)]).

trim(S, T) :-
  string_codes(S, C), phrase(trimmed(D), C), string_codes(T, D).
  
trimmed(S) --> blanks, string(S), blanks, eos, !.

% Tratamento de 'http://localhost:64172/getAllRoutesOnDate?date=20221205'
getAllRoutesOnDate(Request) :-
    cors_enable(Request, [methods([get])]),
    http_parameters(Request,
                    [ date(Date, []) ]),
      
        trim(Date,O),
        atom_number(O,X),
       
        finalRoute(X,List), 
       
        prolog_to_json(finalRoute(List),JSONObject),
        reply_json(JSONObject,[json_object(dict)]).

% Tratamento de 'http://localhost:64172/getBestRoute?date=20221205&truck=eTruck01'
getBestRoute(Request) :-
    cors_enable(Request, [methods([get])]),
    http_parameters(Request,
                    [ date(Date, []),
                      truck(Truck, [])
                    ]),
      
      
        trim(Date,O),
    
    
        number_string(X,O),
      /*  trim(Truck,T),*/
     

        bestRoute(X,Truck,List,_),
      
      
        prolog_to_json(bestRoute(List),JSONObject),
        reply_json(JSONObject,[json_object(dict)]).
      
    
% Tratamento de 'http://localhost:64172/getNearestWarehouse?date=20221205&truck=eTruck01'
getNearestWarehouse(Request) :-
    cors_enable(Request, [methods([get])]),
    http_parameters(Request,
                    [ date(Date, []),
                      truck(Truck, [])
                    ]),

        trim(Date,O),
        atom_number(O,D),
       
        /*trim(Truck,T),*/

        bestRouteNearestWarehouse(D,Truck,List,_), 
      
        prolog_to_json(bestRouteNearestWarehouse(List),JSONObject),
        reply_json(JSONObject,[json_object(dict)]).


% Tratamento de 'http://localhost:64172/getRouteGreaterMass?date=20221205&truck=eTruck01'
getRouteGreaterMass(Request) :-
    cors_enable(Request, [methods([get])]),
   http_parameters(Request,
                    [ date(Date, []),
                      truck(Truck, [])
                    ]),

        trim(Date,O),
        atom_number(O,D),
       
        /*trim(Truck,T),*/

       bestRoutePlusMass(D,Truck,List,_), 
    
  
        prolog_to_json(bestRoutePlusMass(List),JSONObject),
        reply_json(JSONObject,[json_object(dict)]).



% Tratamento de 'http://localhost:64172/getRouteBestRelation?date=20221205&truck=eTruck01'
getRouteBestRelation(Request) :-
     cors_enable(Request, [methods([get])]),
   http_parameters(Request,
                    [ date(Date, []),
                      truck(Truck, [])
                    ]),

        trim(Date,O),
        atom_number(O,D),
       
        /*trim(Truck,T),*/

        bestRouteBestRelation(D,Truck,List,_), 
      
        prolog_to_json(bestRouteBestRelation(List),JSONObject),
        reply_json(JSONObject,[json_object(dict)]).


