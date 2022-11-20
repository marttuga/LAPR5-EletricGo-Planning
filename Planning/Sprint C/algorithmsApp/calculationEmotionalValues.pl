calculateVariationEmotionalGroup(User, _, _, _, [], [], HopeValue, FearValue, ReliefValue, DisappointmentValue) :-
        nos(User, _, _, Moods),
        searchValuesGroup(Moods, HopeValue, FearValue, ReliefValue, DisappointmentValue),!.

calculateVariationEmotionalGroup(User, N, T, TagsObrig, PositiveList, [], HopeValue, FearValue, ReliefValue, DisappointmentValue) :-
        suggestGroup(User, N, T, TagsObrig, (_, ListGroup, _)),
        searchUsers(ListGroup, PositiveList, [], PositiveValue, _),
        nos(User, _, _, Moods),
        searchValuesGroup(Moods, OldHopeValue, FearValue, ReliefValue, OldDisappointmentValue),
        length(PositiveList, PositiveSize),
        NumWantedNotFound is PositiveSize - PositiveValue,
        RatioWantedValue is PositiveValue - NumWantedNotFound,
        HopeValueTemp is (OldHopeValue + (1-OldHopeValue) * (RatioWantedValue/PositiveSize)),
        DisappointmentValueTemp is (OldDisappointmentValue * (1-(RatioWantedValue/PositiveSize))),
        verifyValue(HopeValueTemp, HopeValue),
        verifyValue(DisappointmentValueTemp, DisappointmentValue), !.

calculateVariationEmotionalGroup(User, N, T, TagsObrig, [], NegativeList, HopeValue, FearValue, ReliefValue, DisappointmentValue) :-
        suggestGroup(User, N, T, TagsObrig, (_, ListGroup, _)),
        searchUsers(ListGroup, [], NegativeList, _, NegativeValue),
        nos(User, _, _, Moods),
        searchValuesGroup(Moods, HopeValue, OldFearValue, OldReliefValue, DisappointmentValue),
        length(NegativeList, NegativeSize),
        NumNotWantedNotFound is NegativeSize - NegativeValue,
        RatioNotWantedValue is NumNotWantedNotFound - NegativeValue,
        ReliefValueTemp is (OldReliefValue + (1-OldReliefValue) * (RatioNotWantedValue/NegativeSize)),
        FearValueTemp is (OldFearValue * (1-(RatioNotWantedValue/NegativeSize))),
        verifyValue(FearValueTemp, FearValue),
        verifyValue(ReliefValueTemp, ReliefValue), !.

calculateVariationEmotionalGroup(User, N, T, TagsObrig, PositiveList, NegativeList, HopeValue, FearValue, ReliefValue, DisappointmentValue) :-
        suggestGroup(User, N, T, TagsObrig, (_, ListGroup, _)),
        searchUsers(ListGroup, PositiveList, NegativeList, PositiveValue, NegativeValue),
        nos(User, _, _, Moods),
        searchValuesGroup(Moods, OldHopeValue, OldFearValue, OldReliefValue, OldDisappointmentValue),
        length(PositiveList, PositiveSize),
        NumWantedNotFound is PositiveSize - PositiveValue,
        RatioWantedValue is PositiveValue - NumWantedNotFound,
        HopeValueTemp is (OldHopeValue + (1-OldHopeValue) * (RatioWantedValue/PositiveSize)),
        DisappointmentValueTemp is (OldDisappointmentValue * (1-(RatioWantedValue/PositiveSize))),

        length(NegativeList, NegativeSize),
        NumNotWantedNotFound is NegativeSize - NegativeValue,
        RatioNotWantedValue is NumNotWantedNotFound - NegativeValue,
        ReliefValueTemp is (OldReliefValue + (1-OldReliefValue) * (RatioNotWantedValue/NegativeSize)),
        FearValueTemp is (OldFearValue * (1-(RatioNotWantedValue/NegativeSize))),
        verifyValue(HopeValueTemp, HopeValue),
        verifyValue(FearValueTemp, FearValue),
        verifyValue(ReliefValueTemp, ReliefValue),
        verifyValue(DisappointmentValueTemp, DisappointmentValue), !.

searchUsers([],_,_,0,0):- !.

searchUsers([(H,_)|T], PositiveList, NegativeList, PositiveValue, NegativeValue):-
                        member(H, PositiveList),
                        searchUsers(T, PositiveList, NegativeList, PositiveValue1, NegativeValue),
                        PositiveValue is PositiveValue1 + 1.

searchUsers([(H,_)|T], PositiveList, NegativeList, PositiveValue, NegativeValue):-
                        member(H, NegativeList),
                        searchUsers(T, PositiveList, NegativeList, PositiveValue, NegativeValue1),
                        NegativeValue is NegativeValue1 + 1.

searchUsers([_|T], PositiveList, NegativeList, PositiveValue, NegativeValue):-
                        searchUsers(T, PositiveList, NegativeList, PositiveValue, NegativeValue).

searchValuesGroup([], _, _, _, _):- !.

searchValuesGroup([(Emocao, Value)|L], Value, OldFearValue, OldReliefValue, OldDisappointmentValue) :-
                Emocao = "Hopeful",
                searchValuesGroup(L, Value, OldFearValue, OldReliefValue, OldDisappointmentValue), !.

searchValuesGroup([(Emocao, Value)|L], OldHopeValue, Value, OldReliefValue, OldDisappointmentValue) :-
                Emocao = "Fearful",
                searchValuesGroup(L, OldHopeValue, Value, OldReliefValue, OldDisappointmentValue), !.

searchValuesGroup([(Emocao, Value)|L], OldHopeValue, OldFearValue, Value, OldDisappointmentValue) :-
                Emocao = "Relieve",
                searchValuesGroup(L, OldHopeValue, OldFearValue, Value, OldDisappointmentValue), !.

searchValuesGroup([(Emocao, Value)|L], OldHopeValue, OldFearValue, OldReliefValue, Value) :-
                Emocao = "Disappointed",
                searchValuesGroup(L, OldHopeValue, OldFearValue, OldReliefValue, Value), !.

searchValuesGroup([(_, _)|L], OldHopeValue, OldFearValue, OldReliefValue, OldDisappointmentValue) :-
                searchValuesGroup(L, OldHopeValue, OldFearValue, OldReliefValue, OldDisappointmentValue), !.


%=================================================================================================

calculateVariationEmotionalTag(User, _, _, [], _, _, OldPrideValue, OldRemorseValue, OldGratitudeValue, OldAngerValue):-
        nos(User, _, _, Moods),
        searchValuesTag(Moods, OldPrideValue, OldRemorseValue, OldGratitudeValue, OldAngerValue).

calculateVariationEmotionalTag(User, _, _, _, [], [], OldPrideValue, OldRemorseValue, OldGratitudeValue, OldAngerValue):-
        nos(User, _, _, Moods),
        searchValuesTag(Moods, OldPrideValue, OldRemorseValue, OldGratitudeValue, OldAngerValue).

calculateVariationEmotionalTag(User, N, T, TagsObrig, PositiveList, [], PrideValue, RemorseValue, GratitudeValue, AngerValue):-
        nos(User, _, _, Moods),
        searchValuesTag(Moods, OldPrideValue, OldRemorseValue, GratitudeValue, AngerValue),
        suggestGroup(User, N, T, [], (_, MaiorGrupoSemTags, _)),
        suggestGroup(User, N, T, TagsObrig, (_ ,MaiorGrupoUsers, _)),
        subtract(MaiorGrupoSemTags,MaiorGrupoUsers,UsersPerdidos),
        subtract(MaiorGrupoUsers,MaiorGrupoSemTags,UsersGanhos),

        searchUsers(UsersPerdidos, PositiveList, [], UsersPerdidosQueQuero, _),
        searchUsers(UsersGanhos, PositiveList, [], UsersGanhosQueQuero, _),
        %intersection(UsersPerdidos,PositiveList,ListaUsersPerdidosQueQuero),
        %intersection(UsersGanhos,PositiveList,ListaUsersGanhosQueQuero),
        %length(ListaUsersGanhosQueQuero, UsersGanhosQueQuero),
        %length(ListaUsersPerdidosQueQuero, UsersPerdidosQueQuero),

        ValueUsersQueQuero is UsersGanhosQueQuero - UsersPerdidosQueQuero,
        length(PositiveList, TamanhoPositive),
        PrideValueTemp is (OldPrideValue + (1-OldPrideValue) * (ValueUsersQueQuero/TamanhoPositive)),
        RemorseValueTemp is (OldRemorseValue * (1-(ValueUsersQueQuero/TamanhoPositive))),
        verifyValue(PrideValueTemp, PrideValue),
        verifyValue(RemorseValueTemp, RemorseValue), !.

calculateVariationEmotionalTag(User, N, T, TagsObrig, [], NegativeList, PrideValue, RemorseValue, GratitudeValue, AngerValue):-
        nos(User, _, _, Moods),
        searchValuesTag(Moods, PrideValue, RemorseValue, OldGratitudeValue, OldAngerValue),
        suggestGroup(User, N, T, [], (_, MaiorGrupoSemTags, _)),
        suggestGroup(User, N, T, TagsObrig, (_ ,MaiorGrupoUsers, _)),
        subtract(MaiorGrupoSemTags,MaiorGrupoUsers,UsersPerdidos),
        subtract(MaiorGrupoUsers,MaiorGrupoSemTags,UsersGanhos),

        searchUsers(UsersPerdidos, [], NegativeList, _, UsersPerdidosQueNaoQuero),
        searchUsers(UsersGanhos, [], NegativeList, _, UsersGanhosQueNaoQuero),
        %intersection(UsersPerdidos,NegativeList,ListaUsersPerdidosQueNaoQuero),
        %intersection(UsersGanhos,NegativeList,ListaUsersGanhosQueNaoQuero),
        %length(ListaUsersPerdidosQueNaoQuero, UsersPerdidosQueNaoQuero),
        %length(ListaUsersGanhosQueNaoQuero, UsersGanhosQueNaoQuero),

        ValueUsersQueNaoQuero is UsersPerdidosQueNaoQuero - UsersGanhosQueNaoQuero,
        length(NegativeList, TamanhoNegative),
        GratitudeValueTemp is (OldGratitudeValue + (1-OldGratitudeValue) * (ValueUsersQueNaoQuero/TamanhoNegative)),
        AngerValueTemp is (OldAngerValue * (1-(ValueUsersQueNaoQuero/TamanhoNegative))),
        verifyValue(GratitudeValueTemp, GratitudeValue),
        verifyValue(AngerValueTemp, AngerValue), !.

calculateVariationEmotionalTag(User, N, T, TagsObrig, PositiveList, NegativeList, PrideValue, RemorseValue, GratitudeValue, AngerValue):-
        nos(User, _, _, Moods),
        searchValuesTag(Moods, OldPrideValue, OldRemorseValue, OldGratitudeValue, OldAngerValue),
        suggestGroup(User, N, T, [], (_, MaiorGrupoSemTags, _)),
        suggestGroup(User, N, T, TagsObrig, (_ ,MaiorGrupoUsers, _)),
        subtract(MaiorGrupoSemTags,MaiorGrupoUsers,UsersPerdidos),
        subtract(MaiorGrupoUsers,MaiorGrupoSemTags,UsersGanhos),

        searchUsers(UsersPerdidos, PositiveList, NegativeList, UsersPerdidosQueQuero, UsersPerdidosQueNaoQuero),
        searchUsers(UsersGanhos, PositiveList, NegativeList, UsersGanhosQueQuero, UsersGanhosQueNaoQuero),
        %intersection(UsersPerdidos,PositiveList,ListaUsersPerdidosQueQuero),
        %intersection(UsersGanhos,PositiveList,ListaUsersGanhosQueQuero),
        %length(ListaUsersGanhosQueQuero, UsersGanhosQueQuero),
        %length(ListaUsersPerdidosQueQuero, UsersPerdidosQueQuero),

        ValueUsersQueQuero is UsersGanhosQueQuero - UsersPerdidosQueQuero,
        length(PositiveList, TamanhoPositive),
        %percorreGrupo(MaiorGrupoUsers, MaiorGrupoSemTags, NumeroUsersEncontrados, NumeroUsersNaoEncontrados),
        %write(MaiorGrupoUsers),nl, write(MaiorGrupoSemTags),nl,
        %NumeroUsersEncontrados >= NumeroUsersNaoEncontrados,
        %length(MaiorGrupoUsers, Tamanho),
        PrideValueTemp is (OldPrideValue + (1-OldPrideValue) * (ValueUsersQueQuero/TamanhoPositive)),
        RemorseValueTemp is (OldRemorseValue * (1-(ValueUsersQueQuero/TamanhoPositive))),

        %intersection(UsersPerdidos,NegativeList,ListaUsersPerdidosQueNaoQuero),
        %intersection(UsersGanhos,NegativeList,ListaUsersGanhosQueNaoQuero),
        %length(ListaUsersPerdidosQueNaoQuero, UsersPerdidosQueNaoQuero),
        %length(ListaUsersGanhosQueNaoQuero, UsersGanhosQueNaoQuero),

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
                 Emocao = "Proud",
                searchValuesTag(L, Value, OldRemorseValue, OldGratitudeValue, OldAngerValue), !.

searchValuesTag([(Emocao, Value)|L], OldPrideValue, Value, OldGratitudeValue, OldAngerValue) :-
                Emocao = "Remorseful",
                searchValuesTag(L, OldPrideValue, Value, OldGratitudeValue, OldAngerValue), !.

searchValuesTag([(Emocao, Value)|L], OldPrideValue, OldRemorseValue, Value, OldAngerValue) :-
                Emocao = "Grateful",
                searchValuesTag(L, OldPrideValue, OldRemorseValue, Value, OldAngerValue), !.

searchValuesTag([(Emocao, Value)|L], OldPrideValue, OldRemorseValue, OldGratitudeValue, Value) :-
                Emocao = "Angry",
                searchValuesTag(L, OldPrideValue, OldRemorseValue, OldGratitudeValue, Value), !.

searchValuesTag([(_, _)|L], OldPrideValue, OldRemorseValue, OldGratitudeValue, OldAngerValue) :-
                searchValuesTag(L, OldPrideValue, OldRemorseValue, OldGratitudeValue, OldAngerValue), !.

