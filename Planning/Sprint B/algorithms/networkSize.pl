:- use_module(library(http/http_json)).
:- use_module(library(http/http_open)).
:- use_module(library(http/json)).
:- use_module(library(http/json_convert)).
:- use_module(library(http/http_client)).

% ----------------------------------------------------------
% TAMANHO DA REDE DE UTILIZADOR
% ----------------------------------------------------------

% =================================================
% Encontra todos os vizinhos de ordem 1 do utilizador
% =================================================
%getConnectedWith(UserId, ResultValue) :-
%	atom_concat('http://localhost:5000/api/connections/getconnectedwith/', UserId, FullUrl),
%	http_open(FullUrl, ResultJSON, []),
%	json_read_dict(ResultJSON, ResultObj, []),
%	get_dict(id, ResultObj, ResultValue),
%	close(ResultJSON).
%
:- dynamic players/1.

getConnectedWith(UserId, ResultValue):- findall(X, ((ligacao(UserId, X, _, _);ligacao(X, UserId,_,_))), ResultValue).

getNetwork(UserId, Tamanho, Nivel):-assert(players([UserId])),getNetwork2([[UserId]], Lista, Nivel), linearizar(Lista, Final), length(Final,Tamanho1), Tamanho is Tamanho1-1.

%fazer tamanho da lista
linearizar([],[]).
linearizar(X,[X]):- \+ is_list(X).
linearizar([X|Y],Z):-linearizar(X,Z1),linearizar(Y,Z2),!,union(Z1,Z2,Z).

% colocar os elementos da lista para o proximo nivel
getNetwork2(X, X, 0):- !.

getNetwork2([H|T],Lista,N):-
        listaProximoNivel(H,H2),
        N1 is N-1,
        players(Aux),
        subtract(H2,Aux,Nivel),
        append(Nivel,Aux,NovoAux),
        retract(players(_)),
        assert(players(NovoAux)),
        getNetwork2([Nivel,H|T],Lista,N1).

% ver lista do proximo nivel
listaProximoNivel([],[]):- !.

listaProximoNivel([H|T],Seguinte):-
    listaProximoNivel(T, Seguinte1),
    getConnectedWith(H, Final),
    union(Final, Seguinte1, Seguinte).


































