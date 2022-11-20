:- use_module(library(http/http_json)).
:- use_module(library(http/http_open)).
:- use_module(library(http/json)).
:- use_module(library(http/json_convert)).
:- use_module(library(http/http_client)).

% ----------------------------------------------------------
% SUGERIR
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


%UM CAMINHO PARA CADA
:-dynamic users/1.

suggestConnections(UserId, Nivel, Result) :-
            assert(users([UserId])),
            getNetwork2Suggest([[UserId]], Lista, Nivel),
            retract(users(_)),
            removeElements(Lista, Destinos),
            linearizarSuggest(Destinos, Final),
            findways(UserId,Final,Result),
            write(Result).

findways(_,[],[]) :- !.
findways(UserId,[X|Final],[[X,Result]|Caminhos]) :-
        dfsSuggest(UserId,X,Result),
        findways(UserId,Final,Caminhos).


getConnectedWithSuggest(UserId, ResultValue):- findall(X, ((ligacao(UserId, X, _, _);ligacao(X, UserId,_,_))), ResultValue).


% colocar os elementos da lista para o próximo nível
getNetwork2Suggest(X, X, 0) :- !.
getNetwork2Suggest([H|T],Lista,N) :-
        listaProximoNivelSuggest(H,H2),
        N1 is N-1,
        users(Aux),
        subtract(H2,Aux,Nivel),
        append(Nivel,Aux,NovoAux),
        retract(users(_)),
        assert(users(NovoAux)),
        getNetwork2Suggest([Nivel,H|T],Lista,N1).

% ver lista do proximo nivel
listaProximoNivelSuggest([],[]):- !.

listaProximoNivelSuggest([H|T],Seguinte):-
    listaProximoNivelSuggest(T, Seguinte1),
    getConnectedWithSuggest(H, Final),

    union(Final, Seguinte1, Seguinte).

removeElements(Lista, Destinos) :-
                    last(Lista, UserElem),
                    delete(Lista, UserElem, ListaSemUserElem),
                    last(ListaSemUserElem, Nivel1Elem),
                    delete(ListaSemUserElem, Nivel1Elem, Destinos).

%fazer tamanho da lista
linearizarSuggest([],[]).
linearizarSuggest(X,[X]):- \+ is_list(X).
linearizarSuggest([X|Y],Z):-linearizarSuggest(X,Z1),linearizarSuggest(Y,Z2),!,union(Z1,Z2,Z).

dfsSuggest(UserId,OtherUserId,Caminho):-no(UserId,_,Tags),dfs2Suggest(Tags,UserId,OtherUserId,[UserId],Caminho).

dfs2Suggest(_,OtherUserId,OtherUserId,ListaAuxiliar,Caminho):-!,reverse(ListaAuxiliar,Caminho).
dfs2Suggest(Tags,UserId,OtherUserId,ListaAuxiliar,Caminho):-
	(ligacao(UserId,X,_,_);ligacao(X,UserId,_,_)),
        \+ member(X,ListaAuxiliar),
        no(X,_,TagsX),
        intersection(Tags, TagsX, ListaTags),
        length(ListaTags, Tamanho),
        Tamanho>0,
        dfs2Suggest(ListaTags,X,OtherUserId,[X|ListaAuxiliar],Caminho).
