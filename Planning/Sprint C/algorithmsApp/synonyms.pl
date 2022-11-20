synonym("pedra", "rock").
synonym("rocknroll", "rock").

synonym("lusitania", "portugal").

synonym("traveller", "travel").
synonym("viajar", "travel").
synonym("viagem", "travel").

synonym("salada", "salads").
synonym("saladas", "salads").
synonym("salad", "salads").

synonym("musica", "music").


convertSynonym(Tag, Syno):-
    synonym(Tag, Syno).

convertSynonym(Tag, Tag).


convertSynonyms([], []):-!.

convertSynonyms([Tag|Tags], [Syn|Syns]):-
    synonym(Tag, Syn),
    convertSynonyms(Tags, Syns).

convertSynonyms([Tag|Tags], [Tag|Syns]):-
    convertSynonyms(Tags, Syns).

