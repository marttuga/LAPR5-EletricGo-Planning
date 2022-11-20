:-dynamic total_list_tags/1.
:-dynamic no/3.

%total_list_tags([tag1, tag2, tag3]).

%Exemplo de resultado final
%[
%        [[musica, cinema, desporto],[u1,u4,u5]],
%        [[musica, cinema, desportio],[u1,u4,u5]],
%        [[musica, cinema, desportio],[u1,u4,u5]]
%]

users_common_x_tags(X, Result):-
    (make_total_tag_list();true),
    total_list_tags(Total),
    todas_combinacoes(X, Total, ListCombs),
    allUsersAllCombs(ListCombs, Result),
    write(Result).


%fazer lista total de tags
make_total_tag_list():-
    assert(total_list_tags([])),
    no(_,_,T),
    add_user_tags(T).


% Se a lista estiver vazia, dar fail para testar para o proximo user
add_user_tags([]):-
    fail.

% Se nao for elemento da total, adicionar a lista (remover a lista toda
% e colocar uma nova com esse elemento)
add_user_tags([X|L]):-
    total_list_tags(Total),
    \+member(X, Total),
    retract(total_list_tags(_)),
    assert(total_list_tags([X|Total])),
    add_user_tags(L).

%Se for elemento da lista, so avancar para a proxima tag do user
add_user_tags([_|L]):-
    add_user_tags(L).



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


%para cada combinacao, ver se cada usuario possui (vai pra lista)

allUsersAllCombs([], []):-!.

allUsersAllCombs([Comb|ListCombs], [[Comb,UsersWithComb]|Result1]):-
    allUsersAllCombs(ListCombs, Result1),
    allUsersWithComb(Comb, UsersWithComb).



allUsersWithComb(Comb, UsersWithComb):-
    findall(Name,(no(_,Name,UserTags),userHasComb(Comb, UserTags)),UsersWithComb).

userHasComb(Comb, UserTags):-
    intersecao(Comb, UserTags, Intersecao),
    length(Comb, L1),
    length(Intersecao, L2),
    L1 is L2.


intersecao([ ],_,[ ]).
intersecao([X|L1],L2,[X|LI]):-
    member(X,L2),!,
    intersecao(L1,L2,LI).
intersecao([_|L1],L2, LI):-
    intersecao(L1,L2,LI).





