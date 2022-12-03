
:- use_module(library(http/http_client)).

:- use_module(library(http/json_convert)).
:- use_module(library(http/http_json)).
:- use_module(library(http/json)).

url('http://localhost:5000').
url_users('/api/user/getAllProlog').



get_users(FileName):-
    format('File Name: '),
    format(FileName),
    format('~n~n'),

    url(URLHost),
    url_users(URLUsers),
    concat(URLHost, URLUsers, URL),

    http_get(URL,LUsers,[json_object(dict)]),

    escrever_nos(LUsers),

    open(FileName, write, File),
    guardar_nos(LUsers, File),
    %write(File, 'pleaseWork'),
    close(File), !.



escrever_nos([]):-!.
escrever_nos([User|LUsers]):-
    format('no('),
    format(User.id),
    format(','),
    format(User.userName),
    format(','),
    write_list(User.tags),
    format(').~n'),
    escrever_nos(LUsers).




guardar_nos([],_):-!.
guardar_nos([User|LUsers], File):-
    write_term(File, no(User.id, User.userName, User.tags),[fullstop(true),nl(true),quoted(true)]),
    guardar_nos(LUsers, File).




write_list([]):-
    format('[]'),!.
write_list(LTags):-
    format('['),
    write_list(LTags, 1).
write_list([], _):-
    format(']'),!.
write_list([Tag|LTags], 1):-
    format(Tag),
    write_list(LTags, 2).
write_list([Tag|LTags], 2):-
    format(','),
    format(Tag),
    write_list(LTags, 2).
