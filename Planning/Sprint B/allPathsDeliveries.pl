:- ensure_loaded('BaseConhecimento.pl').

/*
Recebendo os dados das entregas a fazer por 1 camião e dos troços entre armazéns: 
gerar todas as trajetórias possíveis através de sequências de armazéns onde deverão ser feitas as entregas
*/

/* Todos os armazens, que guarda numa lista (L) que procura (findall) pelo Id do armazém correspondente nas entregas
a fazer numa determinada data */
armazensViagem(L,Data):-findall(Id, entrega(_,Data,_,Id,_,_),L). 

/* Juntar o armazém de Matosinhos sempre como armazém inicial e final */
adicionarMatosinhos(WI, WF):-cidadeArmazem(Id), append([Id|WI],[Id],WF).

/* As trajetórias possiveis, com permutação de uma lista de viagens */
viagens(LV,Data):- armazensViagem(LW,Data), findall(Viagem, permutation(LW, Viagem), LV).

/* Viagem tendo em conta os troços e com Matosinhos que adiciona no inicio e no final */
viagensCompleta([],[]).
viagensCompleta([V|LV], [R|WF]):- adicionarMatosinhos(V, R),write(R),nl, viagensCompleta(LV, WF).

/* Todas as viagens possíveis para uma certa data, tendo em conta o armazém de Matosinhos*/
viagensFinal(WF,Data):-viagens(LV,Data), viagensCompleta(LV, WF).



