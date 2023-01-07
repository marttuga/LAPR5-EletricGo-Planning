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
:-include('directory.pl').

:-include('getDeliveryDatabase.pl').
:-include('getRoutesDatabase.pl').
:-include('getTrucksDatabase.pl').
:-include('getWarehousesDatabase.pl').

:- consult('BCTrucks.pl').
:- consult('BCDeliveries.pl').
:- consult('BCDadosTrucks.pl').
:- consult('BCWarehouses.pl').
:- consult('BCRoutes.pl').
:-consult('BCDeliveries_2.pl').


% Rela��o entre pedidos HTTP e predicados que os processam
:- http_handler('/getAllRoutesOnDate', getAllRoutesOnDate, []).
:- http_handler('/getBestRoute', getBestRoute, []).
# :- http_handler('/getHeuristics', getHeuristics, []).
:- http_handler('/getNearestWarehouse', getNearestWarehouse, []).
:- http_handler('/getRouteGreaterMass', getRouteGreaterMass, []).
:- http_handler('/getRouteBestRelation', getRouteBestRelation, []).

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

:- json_object finalRoute(final_route:list(string)).
:- json_object bestRoute(best_route:list(string)).
:- json_object bestRouteNearestWarehouse(route_nearest_warehouse:list(string)).
:- json_object bestRoutePlusMass(route_plus_mass:list(string)).
:- json_object bestRouteBestRelation(route_best_relation:list(string)).


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
    http_parameters(Request,
                    [ orig(Orig, []),
                      dest(Dest, [])
                    ]),
        %format('Content-type: text/plain~n~n'),
  /* format("User Origem- "),*/
        trim(Orig,O),
        /*write(O),*/
        /*format('~n'),
        format("User Destino- "),*/
        trim(Dest,D),
        /*format(D),        
        format('~n'),*/
        finalRoute(O,D,List), /*write("Lista- "),
        write(List),format('~n'),*/
        prolog_to_json(finalRoute(List),JSONObject),
        reply_json(JSONObject,[json_object(dict)]).

% Tratamento de 'http://localhost:64172/getBestRoute'
getBestRoute(Request) :-
    cors_enable(Request, [methods([get])]),
    http_parameters(Request,
                    [ orig(Orig, []),
                      dest(Dest, [])
                    ]),
        %format('Content-type: text/plain~n~n'),
  /* format("User Origem- "),*/
        trim(Orig,O),
        /*write(O),*/
        /*format('~n'),
        format("User Destino- "),*/
        trim(Dest,D),
        /*format(D),        
        format('~n'),*/
        bestRoute(O,D,List), /*write("Lista- "),
        write(List),format('~n'),*/
        prolog_to_json(bestRoute(List),JSONObject),
        reply_json(JSONObject,[json_object(dict)]).

% Tratamento de 'http://localhost:64172/getNearestWarehouse'
getNearestWarehouse(Request) :-
    cors_enable(Request, [methods([get])]),
    http_parameters(Request,
                    [ orig(Orig, []),
                      dest(Dest, [])
                    ]),
        %format('Content-type: text/plain~n~n'),
  /* format("User Origem- "),*/
        trim(Orig,O),
        /*write(O),*/
        /*format('~n'),
        format("User Destino- "),*/
        trim(Dest,D),
        /*format(D),        
        format('~n'),*/
        bestRouteNearestWarehouse(O,D,List), /*write("Lista- "),
        write(List),format('~n'),*/
        prolog_to_json(bestRouteNearestWarehouse(List),JSONObject),
        reply_json(JSONObject,[json_object(dict)]).

% Tratamento de 'http://localhost:64172/getRouteGreaterMass'
getRouteGreaterMass(Request) :-
    cors_enable(Request, [methods([get])]),
    http_parameters(Request,
                    [ orig(Orig, []),
                      dest(Dest, [])
                    ]),
        %format('Content-type: text/plain~n~n'),
  /* format("User Origem- "),*/
        trim(Orig,O),
        /*write(O),*/
        /*format('~n'),
        format("User Destino- "),*/
        trim(Dest,D),
        /*format(D),        
        format('~n'),*/
       bestRoutePlusMass(O,D,List), /*write("Lista- "),
        write(List),format('~n'),*/
        prolog_to_json(bestRoutePlusMass(List),JSONObject),
        reply_json(JSONObject,[json_object(dict)]).

% Tratamento de 'http://localhost:64172/getRouteBestRelation'
getRouteBestRelation(Request) :-
    cors_enable(Request, [methods([get])]),
    http_parameters(Request,
                    [ orig(Orig, []),
                      dest(Dest, [])
                    ]),
        %format('Content-type: text/plain~n~n'),
  /* format("User Origem- "),*/
        trim(Orig,O),
        /*write(O),*/
        /*format('~n'),
        format("User Destino- "),*/
        trim(Dest,D),
        /*format(D),        
        format('~n'),*/
        bestRouteBestRelation(O,D,List), /*write("Lista- "),
        write(List),format('~n'),*/
        prolog_to_json(bestRouteBestRelation(List),JSONObject),
        reply_json(JSONObject,[json_object(dict)]).







% Tratamento de 'http://localhost:64172/importTrucks'
importTrucks(Request) :-
        cors_enable(Request, [methods([get])]),
        format('Content-type: text/plain~n~n'),
        getWorkingDirectory(Dir),
        concat(Dir, 'BCTrucks.pl', Path),
        get_trucks(Path).


% Tratamento de 'http://localhost:64172/importWarehouses'
importWarehouses(Request) :-
        cors_enable(Request, [methods([get])]),
        format('Content-type: text/plain~n~n'),
        getWorkingDirectory(Dir),
        concat(Dir, 'BCWarehouses.pl', Path),
        get_warehouses(Path).

% Tratamento de 'http://localhost:64172/importRoutes'
importRoutes(Request) :-
        cors_enable(Request, [methods([get])]),
        format('Content-type: text/plain~n~n'),
        getWorkingDirectory(Dir),
        concat(Dir, 'BCRoutes.pl', Path),
        get_routes(Path).


% Tratamento de 'http://localhost:64172/importDeliveries'
importDeliveries(Request) :-
        cors_enable(Request, [methods([get])]),
        format('Content-type: text/plain~n~n'),
        getWorkingDirectory(Dir),
        concat(Dir, 'BCDeliveries.pl', Path),
        get_deliveries(Path).*/


/* base de conhecimento dinâmica: obtem as entregas e os camioes do MDWM e do MDL*/
importarInformacao():-
    addWarehouses(),
    addTrucks(),
    addDeliveries().

addWarehouses():-
	http_open('https://localhost:5001/api/warehouse/getAll', ResultJSON, []),
	json_read_dict(ResultJSON, ResultObj),
	warehouseInfo(ResultObj, ResultValue),
	createWarehouse(ResultValue),
	close(ResultJSON).

/* dá os pormenores relativos aos armazens */
warehouseInfo([],[]).
warehouseInfo([H|T],[H.id,H.designacaoArmazem.designation|L]):-
	warehouseInfo(T, L).

createWarehouse([]).
createWarehouse([I,D|L]):-
	assert(idArmazem(I,D)),
	createWarehouse(L).

deleteWarehouse():-
    retract(idArmazem(_,_)),
    fail.

addTrucks():- http_open('http://localhost:3000/api/truck/getAll', ResultJSON, []),
	json_read_dict(ResultJSON, ResultObj),
	truckInfo(ResultObj, ResultValue),
	createTruck(ResultValue),
	close(ResultJSON).

truckInfo([],[]).
truckInfo([H|T],[Designacao,H.tare,H.capacity,H.maxBatteryCapacity,H.autonomy,H.chargingTime|L]):-
	atom_string(H.designation, X),
  	atom_string(Designacao, X),
	truckInfo(T, L).

createTruck([]).
createTruck([D,T,MC,MB,A,CT|L]):- write(D),nl,
	assert(carateristicasCam(D,T,MC,MB,A,CT)),
	createTruck(L).

deleteTruck():- retract(carateristicasCam(_,_,_,_,_,_)),
    fail.

/* obtem as entregas do MDWM*/
addDeliveries():- http_open('https://localhost:5001/api/Deliveries/getAll', ResultJSON, []),
	json_read_dict(ResultJSON, ResultObj),
	deliveryInfo(ResultObj, ResultValue),
	/*cria a entrega*/
	createDelivery(ResultValue),
	close(ResultJSON).

deliveryInfo([],[]).
deliveryInfo([H|T],[(H.deliveryId, date, H.mass.valor, H.armazemID.value, H.tempoCarga.minutos, H.tempoDescarga.minutos)|L]):-
  atom_number(H.data, X),
  atom_number(date, X),
  deliveryInfo(T, L).

createDelivery([]).
createDelivery([(DeliveryId,Date,Mass, WarehouseId,TimeLoad,TimeUnload)|L]):-
	assert(entrega(DeliveryId,Date,Mass,WarehouseId,TimeLoad,TimeUnload)),
	createDelivery(L).

deleteDelivery():- retract(entrega(_,_,_,_,_,_)), fail.





