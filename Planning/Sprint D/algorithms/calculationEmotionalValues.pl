calculateVariationEmotionalJoyDistress(User, Likes, Dislikes, SaturationValue, JoyValue, DistressValue) :-
            node(User, X),
            searchValuesLikesDislikes(X, OldJoyValue, OldDistressValue),
            MinimumValue is min((Likes-Dislikes),SaturationValue),
            JoyValueTemp is (OldJoyValue + (1-OldJoyValue) * (MinimumValue/SaturationValue)),
            DistressValueTemp is (OldDistressValue * (1-(MinimumValue/SaturationValue))),
            verifyValue(JoyValueTemp, JoyValue),
            verifyValue(DistressValueTemp, DistressValue), !.

searchValuesLikesDislikes([], _, _):- !.

searchValuesLikesDislikes([(Emocao, Value)|L], Value, OldDistressValue) :-
                Emocao = 'alegria',
                searchValuesLikesDislikes(L, Value, OldDistressValue), !.

searchValuesLikesDislikes([(Emocao, Value)|L], OldJoyValue, Value) :-
                Emocao = 'angustia',
                searchValuesLikesDislikes(L, OldJoyValue, Value), !.

searchValuesLikesDislikes([(_, _)|L], OldJoyValue, OldDistressValue) :-
                searchValuesLikesDislikes(L, OldJoyValue, OldDistressValue), !.


%=================================================================================================
calculateVariationEmotionalGroup(User, ListGroup, PositiveList, [], HopeValue, FearValue, ReliefValue, DisappointmentValue) :-
        searchUsers(ListGroup, PositiveList, [], PositiveValue, _),
        node(User, X),
        searchValuesGroup(X, OldHopeValue, FearValue, ReliefValue, OldDisappointmentValue),
        length(PositiveList, PositiveSize),
        NumWantedNotFound is PositiveSize - PositiveValue,
        RatioWantedValue is PositiveValue - NumWantedNotFound,
        HopeValueTemp is (OldHopeValue + (1-OldHopeValue) * (RatioWantedValue/PositiveSize)),
        DisappointmentValueTemp is (OldDisappointmentValue * (1-(RatioWantedValue/PositiveSize))),
        verifyValue(HopeValueTemp, HopeValue),
        verifyValue(DisappointmentValueTemp, DisappointmentValue), !.

calculateVariationEmotionalGroup(User, ListGroup, [], NegativeList, HopeValue, FearValue, ReliefValue, DisappointmentValue) :-
        searchUsers(ListGroup, [], NegativeList, _, NegativeValue),
        node(User, X),
        searchValuesGroup(X, HopeValue, OldFearValue, OldReliefValue, DisappointmentValue),
        length(NegativeList, NegativeSize),
        NumNotWantedNotFound is NegativeSize - NegativeValue,
        RatioNotWantedValue is NumNotWantedNotFound - NegativeValue,
        ReliefValueTemp is (OldReliefValue + (1-OldReliefValue) * (RatioNotWantedValue/NegativeSize)),
        FearValueTemp is (OldFearValue * (1-(RatioNotWantedValue/NegativeSize))),
        verifyValue(FearValueTemp, FearValue),
        verifyValue(ReliefValueTemp, ReliefValue), !.

calculateVariationEmotionalGroup(User, ListGroup, PositiveList, NegativeList, HopeValue, FearValue, ReliefValue, DisappointmentValue) :-
        searchUsers(ListGroup, PositiveList, NegativeList, PositiveValue, NegativeValue),
        node(User, X),
        searchValuesGroup(X, OldHopeValue, OldFearValue, OldReliefValue, OldDisappointmentValue),
        length(PositiveList, PositiveSize),
        length(NegativeList, NegativeSize),
        NumWantedNotFound is PositiveSize - PositiveValue,
        RatioWantedValue is PositiveValue - NumWantedNotFound,
        HopeValueTemp is (OldHopeValue + (1-OldHopeValue) * (RatioWantedValue/PositiveSize)),
        DisappointmentValueTemp is (OldDisappointmentValue * (1-(RatioWantedValue/PositiveSize))),

        NumNotWantedNotFound is NegativeSize - NegativeValue,
        RatioNotWantedValue is NumNotWantedNotFound - NegativeValue,
        ReliefValueTemp is (OldReliefValue + (1-OldReliefValue) * (RatioNotWantedValue/NegativeSize)),
        FearValueTemp is (OldFearValue * (1-(RatioNotWantedValue/NegativeSize))),
        verifyValue(HopeValueTemp, HopeValue),
        verifyValue(FearValueTemp, FearValue),
        verifyValue(ReliefValueTemp, ReliefValue),
        verifyValue(DisappointmentValueTemp, DisappointmentValue), !.

verifyValue(Temp, Value):-
			Temp > 1.0,
			Value is 1.0.

verifyValue(Temp, Value):-
			Temp < 0.0,
			Value is 0.0.


verifyValue(Value, Value).

searchUsers([],_,_,0,0):- !.

searchUsers([H|T], PositiveList, NegativeList, PositiveValue, NegativeValue):-
                        member(H, PositiveList),
                        searchUsers(T, PositiveList, NegativeList, PositiveValue1, NegativeValue),
                        PositiveValue is PositiveValue1 + 1.

searchUsers([H|T], PositiveList, NegativeList, PositiveValue, NegativeValue):-
                        member(H, NegativeList),
                        searchUsers(T, PositiveList, NegativeList, PositiveValue, NegativeValue1),
                        NegativeValue is NegativeValue1 + 1.

searchUsers([_|T], PositiveList, NegativeList, PositiveValue, NegativeValue):-
                        searchUsers(T, PositiveList, NegativeList, PositiveValue, NegativeValue).

searchValuesGroup([], _, _, _, _):- !.

searchValuesGroup([(Emocao, Value)|L], Value, OldFearValue, OldReliefValue, OldDisappointmentValue) :-
                Emocao = 'esperanca',
                searchValuesGroup(L, Value, OldFearValue, OldReliefValue, OldDisappointmentValue), !.

searchValuesGroup([(Emocao, Value)|L], OldHopeValue, Value, OldReliefValue, OldDisappointmentValue) :-
                Emocao = 'medo',
                searchValuesGroup(L, OldHopeValue, Value, OldReliefValue, OldDisappointmentValue), !.

searchValuesGroup([(Emocao, Value)|L], OldHopeValue, OldFearValue, Value, OldDisappointmentValue) :-
                Emocao = 'alivio',
                searchValuesGroup(L, OldHopeValue, OldFearValue, Value, OldDisappointmentValue), !.

searchValuesGroup([(Emocao, Value)|L], OldHopeValue, OldFearValue, OldReliefValue, Value) :-
                Emocao = 'dececao',
                searchValuesGroup(L, OldHopeValue, OldFearValue, OldReliefValue, Value), !.

searchValuesGroup([(_, _)|L], OldHopeValue, OldFearValue, OldReliefValue, OldDisappointmentValue) :-
                searchValuesGroup(L, OldHopeValue, OldFearValue, OldReliefValue, OldDisappointmentValue), !.


%=================================================================================================
calculateVariationEmotionalTag(User, _, _, [], _, _, OldPrideValue, OldRemorseValue, OldGratitudeValue, OldAngerValue):-
        node(User,Moods),
        searchValuesTag(Moods, OldPrideValue, OldRemorseValue, OldGratitudeValue, OldAngerValue).

calculateVariationEmotionalTag(User, _, _, _, [], [], OldPrideValue, OldRemorseValue, OldGratitudeValue, OldAngerValue):-
        node(User, Moods),
        searchValuesTag(Moods, OldPrideValue, OldRemorseValue, OldGratitudeValue, OldAngerValue).

calculateVariationEmotionalTag(User, N, T, TagsObrig, PositiveList, [], PrideValue, RemorseValue, GratitudeValue, AngerValue):-
        node(User, X),
        searchValuesTag(X, OldPrideValue, OldRemorseValue, GratitudeValue, AngerValue),
        suggestGroup(User, N, T, [], MaiorGrupoSemTags),
        suggestGroup(User, N, T, TagsObrig, MaiorGrupoUsers),
        subtract(MaiorGrupoSemTags,MaiorGrupoUsers,UsersPerdidos),
        subtract(MaiorGrupoUsers,MaiorGrupoSemTags,UsersGanhos),
        intersection(UsersPerdidos,PositiveList,ListaUsersPerdidosQueQuero),
        intersection(UsersGanhos,PositiveList,ListaUsersGanhosQueQuero),
        length(ListaUsersGanhosQueQuero, UsersGanhosQueQuero),
        length(ListaUsersPerdidosQueQuero, UsersPerdidosQueQuero),
        ValueUsersQueQuero is UsersGanhosQueQuero - UsersPerdidosQueQuero,
        length(PositiveList, TamanhoPositive),
        PrideValueTemp is (OldPrideValue + (1-OldPrideValue) * (ValueUsersQueQuero/TamanhoPositive)),
        RemorseValueTemp is (OldRemorseValue * (1-(ValueUsersQueQuero/TamanhoPositive))),
        verifyValue(PrideValueTemp, PrideValue),
        verifyValue(RemorseValueTemp, RemorseValue), !.

calculateVariationEmotionalTag(User, N, T, TagsObrig, [], NegativeList, PrideValue, RemorseValue, GratitudeValue, AngerValue):-
        node(User, X),
        searchValuesTag(X, PrideValue, RemorseValue, OldGratitudeValue, OldAngerValue),
        suggestGroup(User, N, T, [], MaiorGrupoSemTags),
        suggestGroup(User, N, T, TagsObrig, MaiorGrupoUsers),
        subtract(MaiorGrupoSemTags,MaiorGrupoUsers,UsersPerdidos),
        subtract(MaiorGrupoUsers,MaiorGrupoSemTags,UsersGanhos),
        intersection(UsersPerdidos,NegativeList,ListaUsersPerdidosQueNaoQuero),
        intersection(UsersGanhos,NegativeList,ListaUsersGanhosQueNaoQuero),
        length(ListaUsersPerdidosQueNaoQuero, UsersPerdidosQueNaoQuero),
        length(ListaUsersGanhosQueNaoQuero, UsersGanhosQueNaoQuero),
        ValueUsersQueNaoQuero is UsersPerdidosQueNaoQuero - UsersGanhosQueNaoQuero,
        length(NegativeList, TamanhoNegative),
        GratitudeValueTemp is (OldGratitudeValue + (1-OldGratitudeValue) * (ValueUsersQueNaoQuero/TamanhoNegative)),
        AngerValueTemp is (OldAngerValue * (1-(ValueUsersQueNaoQuero/TamanhoNegative))),
        verifyValue(GratitudeValueTemp, GratitudeValue),
        verifyValue(AngerValueTemp, AngerValue), !.

calculateVariationEmotionalTag(User, N, T, TagsObrig, PositiveList, NegativeList, PrideValue, RemorseValue, GratitudeValue, AngerValue):-
        node(User, X),
        searchValuesTag(X, OldPrideValue, OldRemorseValue, OldGratitudeValue, OldAngerValue),
        suggestGroup(User, N, T, [], MaiorGrupoSemTags),
        suggestGroup(User, N, T, TagsObrig, MaiorGrupoUsers),
        subtract(MaiorGrupoSemTags,MaiorGrupoUsers,UsersPerdidos),
        subtract(MaiorGrupoUsers,MaiorGrupoSemTags,UsersGanhos),
        intersection(UsersPerdidos,PositiveList,ListaUsersPerdidosQueQuero),
        intersection(UsersGanhos,PositiveList,ListaUsersGanhosQueQuero),
        length(ListaUsersGanhosQueQuero, UsersGanhosQueQuero),
        length(ListaUsersPerdidosQueQuero, UsersPerdidosQueQuero),
        ValueUsersQueQuero is UsersGanhosQueQuero - UsersPerdidosQueQuero,
        length(PositiveList, TamanhoPositive),
        %percorreGrupo(MaiorGrupoUsers, MaiorGrupoSemTags, NumeroUsersEncontrados, NumeroUsersNaoEncontrados),
        %write(MaiorGrupoUsers),nl, write(MaiorGrupoSemTags),nl,
        %NumeroUsersEncontrados >= NumeroUsersNaoEncontrados,
        %length(MaiorGrupoUsers, Tamanho),
        PrideValueTemp is (OldPrideValue + (1-OldPrideValue) * (ValueUsersQueQuero/TamanhoPositive)),
        RemorseValueTemp is (OldRemorseValue * (1-(ValueUsersQueQuero/TamanhoPositive))),

        intersection(UsersPerdidos,NegativeList,ListaUsersPerdidosQueNaoQuero),
        intersection(UsersGanhos,NegativeList,ListaUsersGanhosQueNaoQuero),
        length(ListaUsersPerdidosQueNaoQuero, UsersPerdidosQueNaoQuero),
        length(ListaUsersGanhosQueNaoQuero, UsersGanhosQueNaoQuero),
        ValueUsersQueNaoQuero is UsersPerdidosQueNaoQuero - UsersGanhosQueNaoQuero,
        length(NegativeList, TamanhoNegative),
        GratitudeValueTemp is (OldGratitudeValue + (1-OldGratitudeValue) * (ValueUsersQueNaoQuero/TamanhoNegative)),
        AngerValueTemp is (OldAngerValue * (1-(ValueUsersQueNaoQuero/TamanhoNegative))),
        verifyValue(PrideValueTemp, PrideValue),
        verifyValue(RemorseValueTemp, RemorseValue),
        verifyValue(GratitudeValueTemp, GratitudeValue),
        verifyValue(AngerValueTemp, AngerValue), !.

percorreGrupo([],_,0,0):- !.
percorreGrupo(_,[],0,0):- !.
percorreGrupo([H|T], Lista, NumeroUsersEncontrados, NumeroUsersNaoEncontrados):-
        member(H, Lista),
        percorreGrupo(T, Lista, NumeroUsersEncontrados1, NumeroUsersNaoEncontrados),
        NumeroUsersEncontrados is NumeroUsersEncontrados1 + 1.

percorreGrupo([_|T], Lista, NumeroUsersEncontrados, NumeroUsersNaoEncontrados):-
        percorreGrupo(T, Lista, NumeroUsersEncontrados, NumeroUsersNaoEncontrados1),
        NumeroUsersNaoEncontrados is NumeroUsersNaoEncontrados1 + 1.

searchValuesTag([], _, _, _, _):- !.

searchValuesTag([(Emocao, Value)|L], Value, OldRemorseValue, OldGratitudeValue, OldAngerValue) :-
                Emocao = 'orgulho',
                searchValuesTag(L, Value, OldRemorseValue, OldGratitudeValue, OldAngerValue), !.

searchValuesTag([(Emocao, Value)|L], OldPrideValue, Value, OldGratitudeValue, OldAngerValue) :-
                Emocao = 'remorsos',
                searchValuesTag(L, OldPrideValue, Value, OldGratitudeValue, OldAngerValue), !.

searchValuesTag([(Emocao, Value)|L], OldPrideValue, OldRemorseValue, Value, OldAngerValue) :-
                Emocao = 'gratidao',
                searchValuesTag(L, OldPrideValue, OldRemorseValue, Value, OldAngerValue), !.

searchValuesTag([(Emocao, Value)|L], OldPrideValue, OldRemorseValue, OldGratitudeValue, Value) :-
                Emocao = 'raiva',
                searchValuesTag(L, OldPrideValue, OldRemorseValue, OldGratitudeValue, Value), !.

searchValuesTag([(_, _)|L], OldPrideValue, OldRemorseValue, OldGratitudeValue, OldAngerValue) :-
                searchValuesTag(L, OldPrideValue, OldRemorseValue, OldGratitudeValue, OldAngerValue), !.

%--------------------------------------------------------------------

suggestGroup(Origin, N, T, TagsObrig, MaiorGrupoUsers):-
    tags(Origin,OriginTags),

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
    reverse(AscSorted, [(MaiorGrupoNrUsers, _, MaiorGrupoUsers)|_] ),
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
    findall(Id,(node(Id,_),tags(Id,UserTags),userHasComb(Comb, UserTags)),UsersWithComb).

userHasComb(Comb, UserTags):-
    intersection(Comb, UserTags, Intersecao),
    length(Comb, L), length(Intersecao, L).

