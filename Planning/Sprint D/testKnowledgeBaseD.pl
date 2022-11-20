%Base de Conhecimento

edge(a,b).
edge(a,c).
edge(a,d).
edge(a,e).
edge(b,e).
edge(d,e).
edge(c,d).
edge(c,f).
edge(c,i).
edge(d,f).
edge(f,h).
edge(f,m).
edge(f,i).
edge(i,m).
edge(e,f).
edge(e,g).
edge(g,h).
edge(g,l).
edge(g,j).
edge(h,m).
edge(h,n).
edge(h,l).
edge(j,l).
edge(j,o).
edge(l,n).
edge(l,o).
edge(m,n).
edge(m,p).
edge(n,p).
edge(n,r).
edge(o,n).
edge(o,q).
edge(p,r).

generate_random_edges():-
    edge(X,Y),
    random(1,101,FL1),
    random(1,101,FL2),
    random(-200,200,FR1),
    random(-200,200,FR2),
    assert(edge_com_forcas(X,Y,FL1,FL2,FR1,FR2)),
    format("Edge criada: edge_com_forcas(~a,~a,~a,~a,~a,~a)~n",[X,Y,FL1,FL2,FR1,FR2]),
    fail.

destroy_edges():-
    retract(edge_com_forcas(_,_,_,_,_,_)),
    fail.

show_edges():-
    edge_com_forcas(X,Y,FL1,FL2,FR1,FR2),
    format("Edge criada: edge_com_forcas(~a,~a,~a,~a,~a,~a)~n",[X,Y,FL1,FL2,FR1,FR2]),
    fail.


node(a,[(alegria,0.3),
        (angustia,0.1),
        (esperanca,0.7),
        (medo,0.2),
        (alivio,1),
        (dececao,0.4),
        (orgulho,0.6),
        (remorsos,0.1),
        (gratidao,0.6),
        (raiva,0.7)]).
node(b,[(alegria,0.3), 
        (angustia,0.5), 
        (esperanca,0.8),
        (medo,0.1),
        (alivio,0.5),
        (dececao,0.5),
        (orgulho,0.9),
        (remorsos,0.8),
        (gratidao,0.9),
        (raiva,0.2)]).
node(c,[(alegria,0.2), 
        (angustia,0.7), 
        (esperanca,0.8),
        (medo,0.9),
        (alivio,0.1),
        (dececao,0.2),
        (orgulho,0.2),
        (remorsos,0.4),
        (gratidao,0.8),
        (raiva,0.4)]).
node(d,[(alegria,0.9), 
        (angustia,0.1), 
        (esperanca,0.5),
        (medo,0.5),
        (alivio,0.3),
        (dececao,0.4),
        (orgulho,0.8),
        (remorsos,0.8),
        (gratidao,0.7),
        (raiva,0.4)]).
node(e,[(alegria,0.4), 
        (angustia,0.2), 
        (esperanca,0.9),
        (medo,0.8),
        (alivio,0.6),
        (dececao,0.5),
        (orgulho,0.2),
        (remorsos,0.1),
        (gratidao,0.0),
        (raiva,0.9)]).
node(f,[(alegria,0.9), 
        (angustia,0.0), 
        (esperanca,1),
        (medo,0.4),
        (alivio,0.5),
        (dececao,0.5),
        (orgulho,0.4),
        (remorsos,0.3),
        (gratidao,0.6),
        (raiva,0.2)]).
node(g,[(alegria,0.9), 
        (angustia,0.1), 
        (esperanca,0.3),
        (medo,0.5),
        (alivio,0.5),
        (dececao,0.2),
        (orgulho,0.4),
        (remorsos,0.6),
        (gratidao,0.7),
        (raiva,0.1)]).
node(h,[(alegria,0.2), 
        (angustia,0.4), 
        (esperanca,0.3),
        (medo,0.9),
        (alivio,0.1),
        (dececao,0.5),
        (orgulho,0.7),
        (remorsos,0.5),
        (gratidao,0.5),
        (raiva,0.6)]).
node(i,[(alegria,0.4), 
        (angustia,0.7), 
        (esperanca,0.6),
        (medo,0.5),
        (alivio,0.3),
        (dececao,0.9),
        (orgulho,0.1),
        (remorsos,0.1),
        (gratidao,0.9),
        (raiva,0.7)]).
node(j,[(alegria,0.8), 
        (angustia,0.2), 
        (esperanca,0.3),
        (medo,0.8),
        (alivio,0.7),
        (dececao,0.6),
        (orgulho,0.5),
        (remorsos,0.6),
        (gratidao,0.5),
        (raiva,0.7)]).
node(l,[(alegria,0.4), 
        (angustia,0.3), 
        (esperanca,0.5),
        (medo,0.5),
        (alivio,0.7),
        (dececao,0.8),
        (orgulho,0.6),
        (remorsos,0.5),
        (gratidao,0.3),
        (raiva,0.1)]).
node(m,[(alegria,0.6), 
        (angustia,0.5), 
        (esperanca,0.7),
        (medo,0.8),
        (alivio,0.9),
        (dececao,0.2),
        (orgulho,0.3),
        (remorsos,0.8),
        (gratidao,0.6),
        (raiva,0.7)]).
node(n,[(alegria,0.1), 
        (angustia,0.1), 
        (esperanca,0.5),
        (medo,0.5),
        (alivio,0.6),
        (dececao,0.4),
        (orgulho,0.5),
        (remorsos,0.8),
        (gratidao,0.7),
        (raiva,0.6)]).
node(o,[(alegria,0.8), 
        (angustia,0.9), 
        (esperanca,0.4),
        (medo,0.5),
        (alivio,0.7),
        (dececao,0.3),
        (orgulho,0.6),
        (remorsos,0.4),
        (gratidao,0.7),
        (raiva,0.6)]).
node(p,[(alegria,0.7), 
        (angustia,0.8), 
        (esperanca,0.9),
        (medo,0.6),
        (alivio,0.5),
        (dececao,0.5),
        (orgulho,0.3),
        (remorsos,0.7),
        (gratidao,0.8),
        (raiva,0.6)]).
node(q,[(alegria,0.5), 
        (angustia,0.5), 
        (esperanca,0.6),
        (medo,0.4),
        (alivio,0.8),
        (dececao,0.7),
        (orgulho,0.6),
        (remorsos,0.5),
        (gratidao,0.8),
        (raiva,0.7)]).
node(r,[(alegria,0.9), 
        (angustia,0.7), 
        (esperanca,0.8),
        (medo,0.6),
        (alivio,0.4),
        (dececao,0.6),
        (orgulho,0.5),
        (remorsos,0.7),
        (gratidao,0.8),
        (raiva,0.5)]).

grupo(a, [c,m,g,e]).
grupo(b, [g,r,i]).
grupo(c, [a,q,p,r]).
grupo(d, [h,o]).
grupo(e, [j,g,f]).
grupo(f, [c,l,q]).
grupo(g, [i,l,b]).
grupo(h, [g,o,n]).
grupo(i, [m,p]).
grupo(j, [l,e,b]).
grupo(l, [n,q,f]).
grupo(m, [o,r]).
grupo(n, [c,e]).
grupo(o, [p,d,f]).
grupo(p, [e,i,f,a,m,n]).
grupo(q, [d,h]).
grupo(r, [j,h,d]).


tags(a, [rock, saladas]).
tags(b, [comida,musica,animais]).
tags(c, [rock,saladas,flauta,erva]).
tags(d, [algav,musica]).
tags(e, [coelho,passarinho,gato,panda]).
tags(f, [coelho,flauta,animais]).
tags(g, [comida,musica,animais]).
tags(h, [rock,olhos,noite]).
tags(i, [macaco,pera]).
tags(j, [pera,erva,bola]).
tags(l, [passarinho,panda,flauta]).
tags(m, [macaco,olhos,rock]).
tags(n, [rock, saladas]).
tags(o, [pera,macaco,saladas]).
tags(p, [erva,irmaos,flauta,amigos,macaco,noite]).
tags(q, [bola,olhos,comida]).
tags(r, [animais,algav,gato,pera]).