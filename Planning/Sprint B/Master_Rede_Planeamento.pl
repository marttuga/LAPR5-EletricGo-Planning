% Bibliotecas
:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_parameters)).
:- use_module(library(dcg/basics)).
:- use_module(library(http/http_cors)).

% Files Injections
:-consult('Algoritms.pl').
:-include('getUsers.pl').
:-include('getUsers_V2.pl').
:-include('getConnections.pl').
:-include('directory.pl').
:-include('Caminho_Mais_Curto_V2.pl').
:-include('Caminho_Mais_Forte_V2.pl').
:-include('Caminho_Mais_Forte_Relacao_V2 .pl').
:-include('Caminho_Mais_Seguro_V2.pl').
:-consult('usersBC.pl').
:-consult('connectionsBC.pl').
:-include('Suggest_users_V2.pl').
:-include('Best_First_V2.pl').
:-include('Best_First_With_EmotionalStates_V2.pl').

% Rela��o entre pedidos HTTP e predicados que os processam
:- http_handler('/importUsers', importUsers, []).
:- http_handler('/importUsersWithEmotionalStates', importUsersWithEmotionalStates, []).
:- http_handler('/importConnections', importConnections, []).
:- http_handler('/shortPath', shortest_path, []).
:- http_handler('/strongPathPlus', strong_path_plus, []).
:- http_handler('/strongPath', strong_path, []).
:- http_handler('/securePath', secure_path, []).
:- http_handler('/suggestUsers', suggested_users, []).
:- http_handler('/bestFirst', best_first, []).
:- http_handler('/bestFirstWithEmotionalStates',best_First_With_Emotional_States, []).


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

% Tratamento de 'http://localhost:5002/importUsers'
importUsers(Request) :-
         cors_enable(Request, [methods([get])]),
        format('Content-type: text/plain~n~n'),
        getWorkingDirectory(Dir),
        concat(Dir, 'usersBC.pl', Path),
        get_users(Path).

% Tratamento de 'http://localhost:5002/importUsersWithEmotionalStates'
importUsersWithEmotionalStates(Request) :-
         cors_enable(Request, [methods([get])]),
        format('Content-type: text/plain~n~n'),
        getWorkingDirectory(Dir),
        concat(Dir, 'usersBC_V2.pl', Path),
        get_users_V2(Path).

  
% Tratamento de 'http://localhost:5002/importConnections'
importConnections(Request) :-
        cors_enable(Request, [methods([get])]),
        format('Content-type: text/plain~n~n'),
        getWorkingDirectory(Dir),
        concat(Dir, 'connectionsBC.pl', Path),
        get_connections(Path).

% Tratamento de 'http://localhost:5002/shortPath'
shortest_path(Request) :-
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
        plan_minlig(O,D,List), /*write("Lista- "),
        write(List),format('~n'),*/
        prolog_to_json(plan_minlig(List),JSONObject),
        reply_json(JSONObject,[json_object(dict)]).
  
% Tratamento de 'http://localhost:5002/strongPath'
strong_path(Request) :-
    cors_enable(Request, [methods([get])]),
    http_parameters(Request,[orig(Orig, []),dest(Dest, [])]),
        /*format('Content-type: text/plain~n~n'),
        format("User Origem- "),*/
        trim(Orig,O),
      /*  format(O),
        format('~n'),*/
        trim(Dest,D),
        /*format("User Destino- "),
        format(D),     
        format('~n'),*/
        caminho_mais_forte(O,D,List,_),
       /* write(List),
        format('~n'),*/
        prolog_to_json(caminho_mais_forte(List),JSONObject),
        reply_json(JSONObject,[json_object(dict)]).

% Tratamento de 'http://localhost:5002/strongPathPlus'
strong_path_plus(Request) :-
    cors_enable(Request, [methods([get])]),
    http_parameters(Request,[orig(Orig, []),dest(Dest, [])]),
        /*format('Content-type: text/plain~n~n'),
        format("User Origem- "),*/
        trim(Orig,O),
      /*  format(O),
        format('~n'),*/
        trim(Dest,D),
        /*format("User Destino- "),
        format(D),     
        format('~n'),*/
        caminho_mais_forte_plus(O,D,List,_),
       /* write(List),
        format('~n'),*/
        prolog_to_json(caminho_mais_forte_plus(List),JSONObject),
        reply_json(JSONObject,[json_object(dict)]).


% Tratamento de 'http://localhost:5002/securePath'
secure_path(Request) :-
    cors_enable(Request, [methods([get])]),
    http_parameters(Request,
    [orig(Orig, []),
    dest(Dest, []),value(Value,[])
    ]),
        trim(Orig,O),
        trim(Dest,D),
        trim(Value,Val),
        number_string(V,Val),
        caminho_mais_seguro(O,D,List,_,V),       
        prolog_to_json(caminho_mais_seguro(List),JSONObject),
        reply_json(JSONObject,[json_object(dict)]).


% Tratamento de 'http://localhost:5002/suggestUsers'
suggested_users(Request) :-
    cors_enable(Request, [methods([get])]),
    http_parameters(Request
    ,[id(Id, []),
    level(Level, [])
    ]),
        trim(Id,I),   
        trim(Level,L),
        number_string(Lnumber,L),
        suggest_users(I, Lnumber, List),
        prolog_to_json(suggested_users(List),JSONObject),
        reply_json(JSONObject,[json_object(dict)]).


% Tratamento de 'http://localhost:5002/bestFirst?orig=PP&dest=Joana&value=3'
best_first(Request) :-
    cors_enable(Request, [methods([get])]),
    http_parameters(Request, [orig(Orig,[]),dest(Dest,[]),value(Value,[])]),
        trim(Orig,O),
        trim(Dest,D),
        trim(Value,Val),
        number_string(V,Val),
        bestfs1(O,D,V,List,_),       
        prolog_to_json(best_first(List),JSONObject),
        reply_json(JSONObject,[json_object(dict)]).


% Tratamento de 'http://localhost:5002/bestFirstWithEmotionalStates?orig=PP&dest=Joana&value=3'
best_First_With_Emotional_States(Request) :-
    cors_enable(Request, [methods([get])]),
    http_parameters(Request, [orig(Orig,[]),dest(Dest,[]),value(Value,[])]),
        trim(Orig,O),
        trim(Dest,D),
        trim(Value,Val),
        number_string(V,Val),
        bestfs13(O,D,V,List,_),       
        prolog_to_json(best_First_With_Emotional_States(List),JSONObject),
        reply_json(JSONObject,[json_object(dict)]).

