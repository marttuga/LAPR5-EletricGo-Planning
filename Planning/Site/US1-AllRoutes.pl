
/* :-consult('BaseConhecimento.pl').*/


/*
Recebendo os dados das entregas a fazer por 1 camião e dos troços entre armazéns: 
gerar todas as trajetórias possíveis através de sequências de armazéns onde deverão ser feitas as entregas
*/

/* Começamos por procurar todos os armazens cujas deliveries foram feitas na data especificada
L - Lista de armazéns
WId - ID do armazém
findall é O(n)
*/
warehouseRoute(Date,L):-findall(WId, entrega(_,Date,_,WId,_,_),L). 

/* Retorna todas as permutações possíveis entre os armazéns cujas entregas se realizam nessa data 
LR - Lista de rotas
LW - Lista de armazéns
*/
routes(Date,LR):- warehouseRoute(Date,LW), findall(Route, permutation(LW, Route), LR).

/* Retorna todas a permutações possiveis mas começando e acabando em Matosinhos 
V - Primeira rota da lista de rotas
R - Primeira rota completa
*/
fullRoute([],[]).
fullRoute([V|LR], [R|FW]):- idArmazem('Matosinhos',WId), append([WId|V],[WId],R), fullRoute(LR, FW).

/* Retorna a lista final com todas as routes possíveis
FWL- Lista final de armazéns
LR- List de rotas
*/
finalRoute(Date,FWL):-routes(Date,LR), fullRoute(LR, FWL).






