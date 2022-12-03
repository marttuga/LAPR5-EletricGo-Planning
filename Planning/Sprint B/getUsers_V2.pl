
:- use_module(library(http/http_client)).

:- use_module(library(http/json_convert)).
:- use_module(library(http/http_json)).
:- use_module(library(http/json)).

url1('http://localhost:5000').
url_users1('/api/user/getAllProlog').



get_users_V2(FileName):-
    format('File Name: '),
    format(FileName),
    format('~n~n'),

    url1(URLHost),
    url_users1(URLUsers),
    concat(URLHost, URLUsers, URL),

    http_get(URL,LUsers,[json_object(dict)]),

    escrever_nos1(LUsers),

    open(FileName, write, File),
    guardar_nos1(LUsers, File),
    %write(File, 'pleaseWork'),
    close(File), !.



escrever_nos1([]):-!.
escrever_nos1([User|LUsers]):-
    format('no('),
    format(User.id),
    format(','),
    format(User.userName),
    format(','),
    write_list1(User.tags),
    format(').~n'),
    escrever_nos1(LUsers).




guardar_nos1([],_):-!.
guardar_nos1([User|LUsers], File):-
    write_term(File, noV2(User.id, User.userName, User.tags,0.5,0.5,0.5,0.5,0.5),[fullstop(true),nl(true),quoted(true)]),
    guardar_nos1(LUsers, File).




write_list1([]):-
    format('[]'),!.
write_list1(LTags):-
    format('['),
    write_list1(LTags, 1).
write_list1([], _):-
    format(']'),!.
write_list1([Tag|LTags], 1):-
    format(Tag),
    write_list1(LTags, 2).
write_list1([Tag|LTags], 2):-
    format(','),
    format(Tag),
    write_list1(LTags, 2).
