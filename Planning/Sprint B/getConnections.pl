
:- use_module(library(http/http_client)).

:- use_module(library(http/json_convert)).
:- use_module(library(http/http_json)).
:- use_module(library(http/json)).

url_connections('/api/connection/getAllProlog').



get_connections(FileName):-
    format('File Name: '),
    format(FileName),
    format('~n~n'),

    url(URLHost),
    url_connections(URLConnections),
    concat(URLHost, URLConnections, URL),

    http_get(URL,LConnections,[json_object(dict)]),

    escrever_nos_connections(LConnections),

    open(FileName, write, File),
    guardar_nos_connections(LConnections, File),
    %write(File, 'pleaseWork'),
    close(File), !.



escrever_nos_connections([]):-!.
escrever_nos_connections([Connection|LConnections]):-
    format('ligacao('),
    format(Connection.u1),
    format(','),
    format(Connection.u2),
    format(','),
    format(Connection.cs1),
    format(','),
    format(Connection.cs2),
    format(','),
    format(Connection.rs1),
    format(','),
    format(Connection.rs2),
    format(').~n'),
    escrever_nos_connections(LConnections).




guardar_nos_connections([],_):-!.
guardar_nos_connections([Connection|LConnections], File):-
    write_term(File, ligacao(Connection.u1, Connection.u2, Connection.cs1, Connection.cs2, Connection.rs1, Connection.rs2),[fullstop(true),nl(true),quoted(true)]),
    guardar_nos_connections(LConnections, File).
