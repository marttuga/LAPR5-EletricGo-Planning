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
:- json_object suggestedGroupDto(groupTags: list(string), groupUsers: list(userOfGroupDto), groupNrUsers:(integer)).
:- json_object userOfGroupDto(id: string, email: string).

:- http_handler(root(api/suggestGroup), suggestGroupController, []).

suggestGroupController(Request) :-
	cors_enable,
	http_parameters(Request, [origin(Origin,[string]),n(NrMinUsers,[integer]),t(NrMinTagsComum,[integer])]),
	http_read_data(Request, TagsObrigAtom, []),
	removeSingleQuote2(TagsObrigAtom, TagsObrig),
	getAllUsers(),
	suggestGroup(Origin, NrMinUsers, NrMinTagsComum, TagsObrig, SuggestedGroup),
	(destroy_nos();true),
	toSuggestGroupDto(SuggestedGroup, ListSuggestGroupDto),
	prolog_to_json(ListSuggestGroupDto, Json),
	reply_json(Json).

removeSingleQuote2([],[]).
removeSingleQuote2([H|T],[S|L]):-
	term_to_atom(H,M),
	atom_string(M,S),
	removeSingleQuote2(T,L).


toSuggestGroupDto((MaiorGrupoTags, MaiorGrupoUsers, MaiorGrupoNrUsers), Dto):-
	toUserOfGroupDtos(MaiorGrupoUsers, UserDtos),
	Dto = suggestedGroupDto(MaiorGrupoTags, UserDtos, MaiorGrupoNrUsers).

toUserOfGroupDtos([],[]):-!.
toUserOfGroupDtos([(Id, Email)|MaiorGrupoUsers], [Dto|UserDtos]):-
	Dto = userOfGroupDto(Id,Email),
	toUserOfGroupDtos(MaiorGrupoUsers, UserDtos).



suggestGroup(Origin, N, T, TagsObrigNoSyn, (MaiorGrupoTags, MaiorGrupoUsers, MaiorGrupoNrUsers)):-
    %Obter tags do user "origem"
    nos(Origin,_,OriginTagsNoSyn,_),

    %Converter as tags em sinonimos
    convertSynonyms(OriginTagsNoSyn, OriginTags),
    convertSynonyms(TagsObrigNoSyn, TagsObrig),

    %Verificar que o user inicial tem sequer as tags obrigatorias exigidas (se nao tiver, falha logo)
    intersection(TagsObrig, OriginTags, IntersectionTags),
    length(TagsObrig, Num), length(IntersectionTags, Num),

    %Se ha tags obrigatorias, essas nao vao para o calculo de combinacoes.
    %Ex.: se [a,b] sao obrigatorias e pedidas 5 tags, as combs vao ser [a,b,1,2,3], por isso so e preciso fazer combs 3 a 3
    subtract(OriginTags, TagsObrig, RestoTagsParaCombs),
    %Entao, para obter o numero de "3 a 3", vesse a length restante
    length(TagsObrig, LenTagsObrig),
    X is T - LenTagsObrig,
    %Se X der negativo, significa que foram dadas mais tags obrigatorias do que o numero de tags (T) que o grupo deve ter, o que nao faz sentido (falha)
    X >= 0,

    %Agora faz-se as combinacoes X a X do Resto das tags
    todas_combinacoes(X, RestoTagsParaCombs, ListCombsRestoTags),

    %Agora para dar as listas de tags de cada grupo, e preciso adicionar, a cada combinacao, de volta as tags obrigatorias
    juntaListaEmListas(TagsObrig, ListCombsRestoTags, ListCombs),

    %Procurar para cada comb (cada grupo), quantos e quais membros pertencem
    allUsersAllCombs(ListCombs, ListTodosUsersEmGrupos),

    %Obter o grupo com maior numero de utilizadores
    sort(ListTodosUsersEmGrupos, AscSorted),
    reverse(AscSorted, [(MaiorGrupoNrUsers, MaiorGrupoTags, MaiorGrupoUsers)|_] ),
    %sort(3, @>=, ListTodosUsersEmGrupos, [(MaiorGrupoTags, MaiorGrupoUsers, MaiorGrupoNrUsers)|_]),

    %Verificar se tem o numero minimo de utilizadores requerido
    MaiorGrupoNrUsers >= N.



% pegar na lista total e fazer combinacoes com X (providenciado pelos
% docentes)
todas_combinacoes(X,LTags,LcombXTags):-
    findall(L,combinacao(X,LTags,L),LcombXTags).

combinacao(0,_,[]):-!.
combinacao(X,[Tag|L],[Tag|T]):-
    X1 is X-1,
    combinacao(X1,L,T).
combinacao(X,[_|L],T):-
    combinacao(X,L,T).


juntaListaEmListas(_, [], []):-!.

juntaListaEmListas(Lista, [X|ListaListas], [R|Resultado]):-
	append(Lista, X, R),
	juntaListaEmListas(Lista, ListaListas, Resultado).



%para cada combinacao, ver se cada usuario possui (vai pra lista)

allUsersAllCombs([], []):-!.

allUsersAllCombs([Comb|ListCombs], [(Len,Comb,UsersWithComb)|ListTodosUsersEmGrupos]):-
    allUsersAllCombs(ListCombs, ListTodosUsersEmGrupos),
    allUsersWithComb(Comb, UsersWithComb),
    length(UsersWithComb, Len).



allUsersWithComb(Comb, UsersWithComb):-
    findall(
	(Id, Email),
	(
	    nos(Id,Email,UserTagsNoSyn,_),
	    convertSynonyms(UserTagsNoSyn, UserTags),
	    userHasComb(Comb, UserTags)
	),
	UsersWithComb).

userHasComb(Comb, UserTags):-
    intersection(Comb, UserTags, Intersecao),
    length(Comb, L), length(Intersecao, L).





