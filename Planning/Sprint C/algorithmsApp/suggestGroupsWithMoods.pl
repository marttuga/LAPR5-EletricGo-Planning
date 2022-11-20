:- use_module(library(http/http_json)).
:- use_module(library(http/http_open)).
:- use_module(library(http/json)).
:- use_module(library(http/json_convert)).
:- use_module(library(http/http_client)).
:- use_module(library(http/http_server)).
:- use_module(library(http/http_json)).
:- use_module(library(http/http_cors)).
:- use_module(library(http/thread_httpd)).


:- json_object suggestedGroupWithMoodsDto(
		   suggestedGroup: list(suggestedGroupDto),
                   hopeValue:	   float,
		   disappointmentValue: float,
                   reliefValue:    float,    fearValue:		  float,
                   prideValue:     float,
		   remorseValue:        float,
                   gratitudeValue: float,
		   angerValue:	  float).

:- json_object suggestedGroupDto(groupTags: list(string), groupUsers: list(userOfGroupDto), groupNrUsers:(integer)).
:- json_object userOfGroupDto(id: string, email: string).

:- http_handler(root(api/suggestGroupWithMoods), suggestGroupWithMoodsController, []).

suggestGroupWithMoodsController(Request) :-
	cors_enable,
	http_parameters(Request, [origin(Origin,[string]),n(NrMinUsers,[integer]),t(NrMinTagsComum,[integer])]),
	http_read_data(Request, json([tags=TagsObrigAtom,wanted=PositiveListAtom,notWanted=NegativeListAtom]), []),
	%http_read_data(Request, {tags:TagsObrig,wanted:PositiveList,notWanted:NegativeList}, []),
	atomsToStrings(TagsObrigAtom, TagsObrig),
	atomsToStrings(PositiveListAtom, PositiveList),
	atomsToStrings(NegativeListAtom, NegativeList),
	getAllUsers(),
	suggestGroupWithMoods(Origin, NrMinUsers, NrMinTagsComum, TagsObrig, PositiveList,  NegativeList, SuggestedGroup, HopeValue, FearValue, ReliefValue, DisappointmentValue, PrideValue, RemorseValue, GratitudeValue, AngerValue),
	(destroy_nos();true),
        toSuggestGroupWithMoodsDto(SuggestedGroup, HopeValue, FearValue, ReliefValue, DisappointmentValue, PrideValue, RemorseValue, GratitudeValue, AngerValue, FullDto),
	prolog_to_json(FullDto, Json),
	reply_json(Json).

atomsToStrings([],[]).
atomsToStrings([H|T],[S|L]):-
	%term_to_atom(H,M),
	atom_string(H,S),
	atomsToStrings(T,L).

toSuggestGroupWithMoodsDto(SuggestedGroup, HopeValue, FearValue, ReliefValue, DisappointmentValue,PrideValue, RemorseValue, GratitudeValue, AngerValue, R_FullDto):-
    toSuggestGroupDto2(SuggestedGroup, GroupDto),
    R_FullDto = suggestedGroupWithMoodsDto(
		   [GroupDto],  %so funciona se estiver numa lista (nao tirar)
                   HopeValue,
		   DisappointmentValue,
                   ReliefValue, FearValue,
                   PrideValue,
		   RemorseValue,
                   GratitudeValue,
		   AngerValue).

toSuggestGroupDto2((MaiorGrupoTags, MaiorGrupoUsers, MaiorGrupoNrUsers), Dto):-
	toUserOfGroupDtos2(MaiorGrupoUsers, UserDtos),
	Dto = suggestedGroupDto(MaiorGrupoTags, UserDtos, MaiorGrupoNrUsers).

toUserOfGroupDtos2([],[]):-!.
toUserOfGroupDtos2([(Id, Email)|MaiorGrupoUsers], [Dto|UserDtos]):-
	Dto = userOfGroupDto(Id,Email),
	toUserOfGroupDtos2(MaiorGrupoUsers, UserDtos).

suggestGroupWithMoods(Origin, NrMinUsers, NrMinTagsComum, TagsObrig, PositiveList, NegativeList, R_SuggestedGroup, R_HopeValue, R_FearValue, R_ReliefValue, R_DisappointmentValue,R_PrideValue, R_RemorseValue, R_GratitudeValue, R_AngerValue):-
    suggestGroup(Origin, NrMinUsers, NrMinTagsComum, TagsObrig, R_SuggestedGroup),
    calculateVariationEmotionalGroup(Origin, NrMinUsers, NrMinTagsComum, TagsObrig, PositiveList, NegativeList, R_HopeValue, R_FearValue, R_ReliefValue, R_DisappointmentValue),
    calculateVariationEmotionalTag(Origin, NrMinUsers, NrMinTagsComum, TagsObrig, PositiveList, NegativeList, R_PrideValue, R_RemorseValue, R_GratitudeValue, R_AngerValue).


