:- use_module(library(http/json)).
:- use_module(library(http/json_convert)).
:- use_module(library(http/http_server)).
:- use_module(library(http/http_dispatch)).


:-dynamic nos/4.
:-dynamic ligacoes/6.
:- json_object dto(id:string, email:string).
:- json_object joyDistressDto(joy:float, distress:float).

:- initialization
    http_server(http_dispatch,[port(4201)]).

getAllUsers() :-
	%Make sure it's clear beforehand
	(destroy_nos();true),

	configNmdUrl(HostUrl),
	atom_concat(HostUrl, '/api/users/GetAll', Url),
	http_open(Url, ResultJSON, []),
	json_read_dict(ResultJSON, ResultObj),
	getIdUser(ResultObj, ResultValue),
	createDynamicUsers(ResultValue),
	close(ResultJSON).


getIdUser([],[]).
getIdUser([H|T],[H.id,H.email,H.tags,Mood|L]):-
	getMoodUser(H.mood.moodTypes,Mood),
	getIdUser(T, L).

getMoodUser([],[]).
getMoodUser([M|T],[(M.type,M.value)|L]):-
	getMoodUser(T,L).


createDynamicUsers([]).
createDynamicUsers([I,E,T,M|L]):-
	assert(nos(I,E,T,M)),
	createDynamicUsers(L).

getAllConnections() :-
	%Make sure it's clear beforehand
        (destroy_ligacoes();true),

	configNmdUrl(HostUrl),
	atom_concat(HostUrl, '/api/connections/GetAll', Url),
	http_open(Url, ResultJSON, []),
	json_read_dict(ResultJSON, ResultObj),
	getConnectionInformation(ResultObj, ResultValue),
	getRelationship(ResultValue, Result),
	createDynamicConnections(Result),
	close(ResultJSON).

getConnectionInformation([],[]).
getConnectionInformation([H|T],[H.requester,H.target,H.conStrengthAtoC,H.conStrengthCtoA|L]):-S="ApprovedConnection",
	A=H.state,
	S==A,
	getConnectionInformation(T, L).
getConnectionInformation([_|T],L):-getConnectionInformation(T,L).

getRelationship([],[]).
getRelationship([Requester,Target,ConAC,ConCA|T],[Requester,Target,ConAC,ConCA,RelAC,RelCA|L]):-
	configNmdUrl(HostUrl),
	atom_concat(HostUrl, '/api/posts/GetRelationshipStrengthWithUser/userId=', Url1),
	atom_concat(Url1, Requester, Url2),
	atom_concat(Url2, '&friendId=', Url3),
	atom_concat(Url3, Target, Url4),
	http_open(Url4, ResultJSON, []),
	json_read_dict(ResultJSON, RelAC),
	close(ResultJSON),
	configNmdUrl(HostUrl1),
	atom_concat(HostUrl1, '/api/posts/GetRelationshipStrengthWithUser/userId=', Url5),
	atom_concat(Url5, Target, Url6),
	atom_concat(Url6, '&friendId=', Url7),
	atom_concat(Url7, Requester, Url8),
	http_open(Url8, ResultJSON1, []),
	json_read_dict(ResultJSON1, RelCA),
	close(ResultJSON1),
	getRelationship(T,L).

createDynamicConnections([]).
createDynamicConnections([I1,I2,C12,C21,R12,R21|T]):-
	assert(ligacoes(I1,I2,C12,C21,R12,R21)),
	createDynamicConnections(T).

destroy_ligacoes():-
    retract(ligacoes(_,_,_,_,_,_)),
    fail.

destroy_nos():-
	retract(nos(_,_,_,_)),
	fail.

getEmailPath([],[]).
getEmailPath([H|T],[I|L]):-nos(H,I,_,_),
	getEmailPath(T,L).

createDto([],[]).
createDto([Id|LCaminho], [Object|ListaJson]):-
	getEmailPath([Id],[E]),
	Object = dto(Id,E),
	createDto(LCaminho, ListaJson).

createDtoJoyDistress(Joy, Distress, Dto):-
	Dto=joyDistressDto(Joy, Distress).

multicriterio(CustoX,CustoRelX,Resultado):-
    CustoRelX1 is CustoRelX + 200,
    CustoRelX2 is CustoRelX1 / 400,
    CustoRelX3 is CustoRelX2 * 100,
    Resultado is (CustoRelX3 + CustoX)/2.

verifyValue(Temp, Value):-
			Temp > 1.0,
			Value is 1.0.

verifyValue(Temp, Value):-
			Temp < 0.0,
			Value is 0.0.


verifyValue(Value, Value).

