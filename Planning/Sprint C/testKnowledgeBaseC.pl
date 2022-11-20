%Base de Conhecimento

:- dynamic edge_com_forcas/6.

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
    random(-200,201,FR1),
    random(-200,201,FR2),
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

node(a).
node(b).
node(c).
node(d).
node(e).
node(f).
node(g).
node(h).
node(i).
node(j).
node(l).
node(m).
node(n).
node(o).
node(p).
node(q).
node(r).
