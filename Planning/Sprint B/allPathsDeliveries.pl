:- ensure_loaded('BaseConhecimento.pl').

/*
Recebendo os dados das entregas a fazer por 1 camião e dos troços entre armazéns: 
gerar todas as trajetórias possíveis através de sequências de armazéns onde deverão ser feitas as entregas
*/

allPathsDeliveries():-