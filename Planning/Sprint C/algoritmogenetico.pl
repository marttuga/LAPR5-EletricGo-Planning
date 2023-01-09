% Bibliotecas
:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_parameters)).
:- use_module(library(dcg/basics)).
:- use_module(library(http/http_cors)).

% Files Injections
:-include('US1-AllRoutes.pl').
:-include('US2-BestRoute.pl').
:-include('US4-Heuristics.pl').

% Rela��o entre pedidos HTTP e predicados que os processam
:- http_handler('/getAllRoutesOnDate', getAllRoutesOnDate, []).
:- http_handler('/getBestRoute', getBestRoute, []).
:- http_handler('/getNearestWarehouse', getNearestWarehouse, []).
:- http_handler('/getRouteGreaterMass', getRouteGreaterMass, []).
:- http_handler('/getRouteBestRelation', getRouteBestRelation, []).

% Bibliotecas JSON
:- use_module(library(http/json_convert)).
:- use_module(library(http/http_json)).
:- use_module(library(http/http_cors)).
:- use_module(library(http/json)).

:- json_object finalRoute(final_route:list(string)).
:- json_object bestRoute(best_route:list(string)).
:- json_object bestRouteNearestWarehouse(route_nearest_warehouse:list(string)).
:- json_object bestRoutePlusMass(route_plus_mass:list(string)).
:- json_object bestRouteBestRelation(route_best_relation:list(string)).

:- consult('BCTrucks.pl').
:- consult('BCDeliveries_2.pl').
:- consult('BCDadosTrucks.pl').
:- consult('BCWarehouses.pl').
:- consult('BCRoutes.pl').

%Cors
:-set_setting(http:cors, [*]).


% Cria��o de servidor HTTP no porto 'Port'
server(Port) :-
        http_server(http_dispatch, [port(Port)]).

trim(S, T) :-
  string_codes(S, C), phrase(trimmed(D), C), string_codes(T, D).
  
trimmed(S) --> blanks, string(S), blanks, eos, !.



:-dynamic geracoes/1.
:-dynamic populacao/1.
:-dynamic prob_cruzamento/1.
:-dynamic prob_mutacao/1.



% deliveries(NDeliveries).
deliveries(5).

/*teremos que saber quantidade de novas geracoes, a dimensao de uma populacao,
 probabilidade de mutação e cruzamento para o algoritmo genetico*/

inicializa:-write('Numero de novas Geracoes: '),read(NG),
    (retract(geracoes(_));true), assert(geracoes(NG)),
	write('Dimensao da Populacao: '),read(DP),
	(retract(populacao(_));true), assert(populacao(DP)),
	write('Probabilidade de Cruzamento (%):'), read(P1),
	PC is P1/100, 
	(retract(prob_cruzamento(_));true), assert(prob_cruzamento(PC)),
	write('Probabilidade de Mutacao (%):'), read(P2),
	PM is P2/100, 
	(retract(prob_mutacao(_));true), assert(prob_mutacao(PM)).


gera:- inicializa,
	determineNumTrucks(NeededTrucks),
	distribution_of_deliveries(DistributionResult,NeededTrucks),
	gera_populacao(Pop),
	nl, write('Pop='),write(Pop),nl,
	valida_populacao(Pop,NeededTrucks,DistributionResult,[],PopAtualizada),
	avalia_populacao(PopAtualizada,PopAv,NeededTrucks,DistributionResult),
	/*viagens e tempo associado*/
	write('PopAv='),write(PopAv),nl,nl,
	ordena_populacao(PopAv,PopOrd),
	geracoes(NG),
	get_time(TempoExecucao),
	MaxTime is 3600,
	Estabilizacao is 1, 
	GeracoesIguais is 0,
	gera_geracao(0,NG,PopOrd,TempoExecucao,MaxTime,0,GeracoesIguais,Estabilizacao,BestRoute*RouteTime,NeededTrucks,DistributionResult),nl,nl,
	/* com base na melhor viagem e na heuristica de melhor tempo de viagem*/
	write('Melhor Viagem: '),write(BestRoute),nl,
	write('Tempo Viagem: '),write(RouteTime).
	

/* vai fazer o calculo do peso de todas as entregas para calcular o numero de camioes necessários*/
determineNumTrucks(NeededTrucks):- findall(Mass,entrega(_,20221205,Mass,_,_,_),Cargas),
	getTotalLoad(Cargas,0,TotalLoad),
	carateristicasCam(eTruck01,_,LoadCapacity,_,_,_),
	/*o numero de camiões será a carga total, ou seja, já com encomendas incluidas
	 a dividir pela capacidade que 1 camião pode transportar*/
	NumberOfTrucks is TotalLoad/LoadCapacity,
	number_of_trucks(NumberOfTrucks,NeededTrucks).

getTotalLoad([],TotalLoad,TotalLoad):-!.

getTotalLoad([H|T],TotalLoad1,TotalLoad):- TotalLoad2 is TotalLoad1+H,
	getTotalLoad(T,TotalLoad2,TotalLoad).

/*número de camiões necessários */
number_of_trucks(NumberOfTrucks,NeededTrucks):- ParteInteira is float_integer_part(NumberOfTrucks),
	ParteDecimal is float_fractional_part(NumberOfTrucks),
	((ParteDecimal > 0.75,NeededTrucks is ParteInteira+2);NeededTrucks is ParteInteira+1).

distribution_of_deliveries(DistributionResult,NeededTrucks):- deliveries(NEntregas),
	DistributionResultAux is NEntregas/NeededTrucks,
	DistributionResult is float_integer_part(DistributionResultAux).

gera_populacao(Pop):- populacao(TamPop),
	/*procura todas as entregas/tarefas*/
	findall(WarehouseChegada,entrega(_,20221205,_,WarehouseChegada,_,_),WarehousesL),
	length(WarehousesL, NumE),
	gera_populacao(TamPop,WarehousesL,NumE,Pop).


gera_populacao(0,_,_,[]):-!.

gera_populacao(TamPop,WarehousesL,NumE,[Ind|Resto]):- TamPop1 is TamPop-1,
	gera_populacao(TamPop1,WarehousesL,NumE,Resto),
	((TamPop1 == 0, bestRouteNearestWarehouse(20221205, eTruck01, Ind, _),!);
	((TamPop1 == 1, bestRouteBestRelation(20221205, eTruck01, Ind, _),!);
	(gera_individuo(WarehousesL,NumE,Ind)))),
	not(member(Ind,Resto)).
	
gera_populacao(TamPop,WarehousesL,NumE,L):- gera_populacao(TamPop,WarehousesL,NumE,L).

gera_individuo([G],1,[G]):-!.

gera_individuo(WarehousesL,NumT,[G|Resto]):- NumTemp is NumT + 1, % To use with random
	random(1,NumTemp,N),
	retira(N,WarehousesL,G,NovaLista),
	NumT1 is NumT-1,
	gera_individuo(NovaLista,NumT1,Resto).

/* Validation is 1: quando ele acabou as validações já não é valido*/
avalia_individuo(_,_,_,_,1,ViagemValida):- ViagemValida is 1,!.

avalia_individuo(_,_,_,_,-1,ViagemValida):- ViagemValida is 0,!.


avalia_individuo(Ind,AvaliacoesRealizadas,NeededTrucks,DistributionResult,0,ViagemValida):-
	((AvaliacoesRealizadas < (NeededTrucks), obter_x_elementos(DistributionResult,Ind,EntregasCamiao),
	/* Validation is 0: enquanto tem avaliações para fazer e ele ainda está válido*/
  getLoadTruck(20221205,EntregasCamiao,CargaViagem,TotalLoad), Validation is 0);
  /* Validation is -1: quando já acabou as avaliações todas e ele efetivamente é válido*/
  (getLoadTruck(20221205,Ind,CargaViagem,TotalLoad),Validation is -1)),
	/* valida se as cargas a comparar com 4300 para validar a viagem*/
	((TotalLoad > 4300,avalia_individuo(_,NeededTrucks,NeededTrucks,_,1,ViagemValida));
	(AvaliacaoAtualizada is AvaliacoesRealizadas+1,remover_x_elementos(DistributionResult,Ind,IndAtualizada),
	avalia_individuo(IndAtualizada,AvaliacaoAtualizada,NeededTrucks,DistributionResult,Validation,ViagemValida))).

valida_populacao([],_,_,PopResultante,PopAtualizada):- PopAtualizada = PopResultante,!.

/*no resultado da distribuição vamos encontrar as entregas por camiao*/
valida_populacao([P1|Resto],NeededTrucks,DistributionResult,PopResultante,Solucao):-
	avalia_individuo(P1,1,NeededTrucks,DistributionResult,0,ViagemValida),
	((ViagemValida == 1, random_permutation(P1,NovoMembro),append(Resto,[NovoMembro],PopNova),
	 valida_populacao(PopNova,NeededTrucks,DistributionResult,PopResultante,Solucao));
	 (append(PopResultante,[P1],PopAtualizada),valida_populacao(Resto,NeededTrucks,DistributionResult,PopAtualizada,Solucao))).


obter_x_elementos(0.0,_,[]):-!.	

obter_x_elementos(X,[H|T],[H|Resto]):-
	X1 is X-1,
	obter_x_elementos(X1,T,Resto).

remover_x_elementos(_, [], []) :- !.
remover_x_elementos(0.0, L, L) :- !.
remover_x_elementos(N, [_|T], L) :-
    N1 is N - 1,
    remover_x_elementos(N1, T, L).

retira(1,[G|Resto],G,Resto).
retira(N,[G1|Resto],G,[G1|Resto1]):-
	N1 is N-1,
	retira(N1,Resto,G,Resto1).

/*quando chegar a lista vazia para avaliar*/
avalia_populacao([],[],_,_). 
/*vai chamar o avalia do tempo para obter qual é o tempo da viagem para ficar guardado em cada individuo(camiao) da populacao, 
que tem associado a ele as varias entregas e o tempo */
/* vai avaliar todos os indivíduos da população (cada indivíduo é uma lista com todas as tarefas) e coloca o tempo de cada viagem no
respetivo individuo*/
avalia_populacao([Ind|Resto],[Ind*V|Resto1],NeededTrucks,DistributionResult):-
	Camioes is truncate(NeededTrucks),
  determineTime(20221205,eTruck01, Ind, V),
	avalia_populacao(Resto,Resto1,NeededTrucks,DistributionResult).

time_of_travel(_,Time,Camioes,Camioes,_,TempoMaior):- TempoMaior is Time, !.

/*obtem o tempo de viagem*/
time_of_travel(Ind,Time,TemposCalculados,NeededTrucks,DistributionResult,TempoMaior):-
	((TemposCalculados < (NeededTrucks - 1), obter_x_elementos(DistributionResult,Ind,EntregasCamiao),
	/*determina o tempo com base no sprint passado*/
  determineTime(20221205,eTruck01, EntregasCamiao, TempoViagem));
  (determineTime(20221205,eTruck01, Ind, TempoViagem))),
	((TempoViagem > Time, NovoTempo is TempoViagem);(NovoTempo is Time)),
	remover_x_elementos(DistributionResult,Ind,IndAtualizada),
	VezesCalculadas is TemposCalculados+1,
	time_of_travel(IndAtualizada,NovoTempo,VezesCalculadas,NeededTrucks,DistributionResult,TempoMaior).

/*Ordenação dos elementos da população em ordem crescente das avaliações pelo tempo associado*/
ordena_populacao(PopAv,PopAvOrd):- bsort(PopAv,PopAvOrd).

bsort([X],[X]):-!.

bsort([X|Xs],Ys):-
	bsort(Xs,Zs),
	btroca([X|Zs],Ys).


btroca([X],[X]):-!.

btroca([X*VX,Y*VY|L1],[Y*VY|L2]):- VX>VY,!,
	btroca([X*VX|L1],L2).

btroca([X|L1],[X|L2]):-btroca(L1,L2).

ordena_populacao_probabilidade(PopAv,PopAvOrd):-
	bsort_probabilidade(PopAv,PopAvOrd).

bsort_probabilidade([X],[X]):-!.
bsort_probabilidade([X|Xs],Ys):-
	bsort_probabilidade(Xs,Zs),
	btroca_probabilidade([X|Zs],Ys).

btroca_probabilidade([X],[X]):-!.

btroca_probabilidade([X*VX*VZ,Y*VY*VW|L1],[Y*VY*VW|L2]):-
	VZ>VW,!,
	btroca_probabilidade([X*VX*VZ|L1],L2).

btroca_probabilidade([X|L1],[X|L2]):-btroca_probabilidade(L1,L2).

gera_geracao(G,G,Pop,_,_,0,_,_,BestRoute,_,_):-!,
	Pop = [BestRoute|_],
	write('Geracao '), write(G), write(':'), nl, write(Pop), nl.

gera_geracao(G,_,Pop,_,_,1,_,_,BestRoute,_,_):-!,
	Pop = [BestRoute|_], nl.
	/*write('Geracao '), write(G), write(':'), nl, write(Pop), nl,
	write('Tempo Maximo Atingido.'),nl.*/

gera_geracao(G,_,Pop,_,_,0,Estabilizacao,Estabilizacao,BestRoute,_,_):-!,
	Pop = [BestRoute|_], nl.
	/*write('Geracao '), write(G), write(':'), nl, write(Pop), nl,
	write('Geracao Estabilizada.'),nl.*/

gera_geracao(N,G,Pop,TempoInicial,MaxTime,0,GeracoesIguaisAnt,Estabilizacao,BestRoute,NeededTrucks,DistributionResult):-
write('Geracao '), write(N), write(':'), nl, write(Pop), nl,
	random_permutation(Pop,PopAleatoria),
	cruzamento(PopAleatoria,NPop1),
	mutacao(NPop1,NPop),
	valida_populacao(NPop,NeededTrucks,DistributionResult,[],PopAtualizada),
	avalia_populacao(PopAtualizada,NPopAv,NeededTrucks,DistributionResult),
	append(Pop, NPopAv, Populacao),
	sort(Populacao, Aux),
	ordena_populacao(Aux,NPopOrd),
	best_to_next(NPopOrd,2,Melhores,Restantes),
	prob_other_elem(Restantes,ProbRestantes),
	ordena_populacao_probabilidade(ProbRestantes,ProbRestantesOrd),
	populacao(TamPop),
	ElementosEmFalta is TamPop-2,
	choose_from_remaining(ProbRestantesOrd,ElementosEmFalta,ListaEscolhidos),
	append(Melhores,ListaEscolhidos,ProxGeracao),
	ordena_populacao(ProxGeracao,ProxGeracaoOrd),
	N1 is N+1,
	get_time(Tf),
	TempEx is Tf-TempoInicial,
	executionTime(TempEx,MaxTime,ValidationFim),
	stabilized_pop(Pop,ProxGeracaoOrd,GeracoesIguaisAnt,GeracoesIguais),
	gera_geracao(N1,G,ProxGeracaoOrd,TempoInicial,MaxTime,ValidationFim,GeracoesIguais,Estabilizacao,BestRoute,NeededTrucks,DistributionResult).


executionTime(TempEx,MaxTime,ValidationFim):- ((TempEx < MaxTime, ValidationFim is 0);(ValidationFim is 0)).

/*para uma populaçao ser considerada estabilizada, a geracao resultante tem de ser igual à anterior
Para isso, recorre-se ao método semelhanca para verificar essa igualdade */
stabilized_pop(Pop,ProxGeracaoOrd,GeracoesIguaisAnt,GeracoesIguais):-
	((equality_between_pop(Pop,ProxGeracaoOrd), !, GeracoesIguais is GeracoesIguaisAnt+1);
	(GeracoesIguais is 0)).

/*verifica se existe semelhanca entre as populaçoes*/
equality_between_pop([],[]):-!.
equality_between_pop([P1|Populacao],[P2|ProxGeracao]):- P1=P2, 
	equality_between_pop(Populacao,ProxGeracao).

/*obtem os melhores para a proxima geracao*/
best_to_next([H|NPopOrd], 0, [],[H|NPopOrd]).
best_to_next([Ind|NPopOrd],P,[Ind|Melhores],Restantes):-
	P1 is P-1,
	best_to_next(NPopOrd,P1,Melhores,Restantes).

/*o resto dos elementos terá uma probabilidade igual ao numero aleatorio entre o 0 ou o 1 vezes o tempo*/
prob_other_elem([],[]):-!.
prob_other_elem([Ind*Time|Restantes],[Ind*Time*Prob|ListaProb]):-
	prob_other_elem(Restantes,ListaProb), 
	random(0.0,1.0,NumAl), Prob is NumAl * Time.



choose_from_remaining([H|ListaProdutoRestantesOrd], 0, []).
/*Lista dos escolhidos será a lista dos que permanecem para a proxima geraçao
tendo em conta que serão sempre igual ao numero do tamanho da populacao menos os 2 melhores que já estao decididos */
choose_from_remaining([Ind*Time*Prob|ListaProdutoRestantesOrd],NP,[Ind*Time|ListaEscolhidos]):- NP1 is NP-1,
	choose_from_remaining(ListaProdutoRestantesOrd,NP1,ListaEscolhidos).


/* geração dos pontos de cruzamento P1 (onde começa o corte) e P2 (onde acaba o corte), 
por exemplo se P1 for 2 e P2 for 4 os pontos de corte serão entre o 1o e 2o gene e entre 
o 4o e 5o gene.
Notar que tal como está implementado não há cortes que fiquem apenas com 1 gene a meio, 
por causa do P11 ser diferente do P21*/
gerar_pontos_cruzamento(P1,P2):- gerar_pontos_cruzamento1(P1,P2).

gerar_pontos_cruzamento1(P1,P2):- deliveries(N),
	NTemp is N+1,
	random(1,NTemp,P11),
	random(1,NTemp,P21),
	P11\==P21,!,
	((P11<P21,!,P1=P11,P2=P21);(P1=P21,P2=P11)).

gerar_pontos_cruzamento1(P1,P2):- gerar_pontos_cruzamento1(P1,P2).

/*O cruzamento é tentado sobre indivíduos sucessivos 2 a 2 da população, o que pode ser uma limitação*/
cruzamento([],[]).
cruzamento([Ind*_],[Ind]).
cruzamento([Ind1*_,Ind2*_|Resto],[NInd1,NInd2|Resto1]):- gerar_pontos_cruzamento(P1,P2),
	prob_cruzamento(Pcruz),random(0.0,1.0,Pc),
	/*Para saber se se realiza o cruzamento gera-se um no aleatório entre 0 e 1 e compara-se com a 
	probabilidade de cruzamento parametrizada, se for inferior faz-se o cruzamento*/
	((Pc =< Pcruz,!,
        cruzar(Ind1,Ind2,P1,P2,NInd1),
	  cruzar(Ind2,Ind1,P1,P2,NInd2))
	;
	(NInd1=Ind1,NInd2=Ind2)),
	cruzamento(Resto,Resto1).


/*Predicados auxiliares para fazer o cruzamento order crossover, que é o adequado para o 
sequenciamento de tarefas*/
preencheh([],[]).

preencheh([_|R1],[h|R2]):- preencheh(R1,R2).

sublista(L1,I1,I2,L):- I1 < I2,!,
	sublista1(L1,I1,I2,L).

sublista(L1,I1,I2,L):- sublista1(L1,I2,I1,L).

sublista1([X|R1],1,1,[X|H]):-!,
	preencheh(R1,H).

sublista1([X|R1],1,N2,[X|R2]):-!,
	N3 is N2 - 1,
	sublista1(R1,1,N3,R2).

sublista1([_|R1],N1,N2,[h|R2]):- N3 is N1 - 1, N4 is N2 - 1,
	sublista1(R1,N3,N4,R2).

rotate_right(L,K,L1):- deliveries(N),
	T is N - K,
	rr(T,L,L1).

rr(0,L,L):-!.

rr(N,[X|R],R2):- N1 is N - 1,
	append(R,[X],R1),
	rr(N1,R1,R2).


elimina([],_,[]):-!.

elimina([X|R1],L,[X|R2]):- not(member(X,L)),!,
	elimina(R1,L,R2).

elimina([_|R1],L,R2):- elimina(R1,L,R2).

insere([],L,_,L):-!.

insere([X|R],L,N,L2):- deliveries(T),
	((N>T,!,N1 is N mod T);N1 = N),
	insere1(X,N1,L,L1),
	N2 is N + 1,
	insere(R,L1,N2,L2).


insere1(X,1,L,[X|L]):-!.

insere1(X,N,[Y|L],[Y|L1]):- N1 is N-1,
	insere1(X,N1,L,L1).

cruzar(Ind1,Ind2,P1,P2,NInd11):- sublista(Ind1,P1,P2,Sub1),
	deliveries(NumT),
	R is NumT-P2,
	rotate_right(Ind2,R,Ind21),
	elimina(Ind21,Sub1,Sub2),
	P3 is P2 + 1,
	insere(Sub2,Sub1,P3,NInd1),
	eliminah(NInd1,NInd11).


eliminah([],[]).

eliminah([h|R1],R2):-!,
	eliminah(R1,R2).

eliminah([X|R1],[X|R2]):-
	eliminah(R1,R2).

/*Para saber se se realiza a mutação gera-se um no aleatório entre 0 e 1 e compara-se com a probabilidade
 de mutação parametrizada, se for inferior faz-se a mutação*/
mutacao([],[]).
mutacao([Ind|Rest],[NInd|Rest1]):- prob_mutacao(Pmut),
	random(0.0,1.0,Pm),
	((Pm < Pmut,!,mutacao1(Ind,NInd));NInd = Ind),
	mutacao(Rest,Rest1).

mutacao1(Ind,NInd):- gerar_pontos_cruzamento(P1,P2),
	mutacao22(Ind,P1,P2,NInd).

mutacao22([G1|Ind],1,P2,[G2|NInd]):-!,
	P21 is P2-1,
	mutacao23(G1,P21,Ind,G2,NInd).

mutacao22([G|Ind],P1,P2,[G|NInd]):- P11 is P1-1, P21 is P2-1,
	mutacao22(Ind,P11,P21,NInd).

mutacao23(G1,1,[G2|Ind],G2,[G1|Ind]):-!.

mutacao23(G1,P,[G|Ind],G2,[G|NInd]):- P1 is P-1,
	mutacao23(G1,P1,Ind,G2,NInd).


% ____________________________________________________

warehouseRoute(Date,L):-findall(WId, entrega(_,Date,_,WId,_,_),L). 

routes(Date,LR):- warehouseRoute(Date,LW), findall(Route, permutation(LW, Route), LR).

fullRoute([],[]).
fullRoute([V|LR], [R|FW]):- idArmazem('Matosinhos',WId), append([WId|V],[WId],R), fullRoute(LR, FW).

finalRoute(Date,FWL):-routes(Date,LR), fullRoute(LR, FWL),write(FWL).

getLoadTruck(_, [], [], 0):-!.
getLoadTruck(Date, [Warehouse|LW], [Load|LL], Load):-getLoadTruck(Date, LW, LL, LoadAux), entrega(_,Date,Mass,Warehouse,_,_), 
                                                        Load is Mass + LoadAux.

addTareTruck(TruckName, LL, LLT):- carateristicasCam(TruckName,Tare,_,_,_,_), addTare(Tare,LL,LLT).

addTare(Tare,[],[Tare]):-!.
addTare(Tare, [Load|LL], [Loadtare|LLT]):- addTare(Tare,LL,LLT), Loadtare is Load + Tare.

determineTime(Date, Truck, LW, Time):- getLoadTruck(Date, LW, LL,_),
                                       addTareTruck(Truck,LL, LLT),
                                       idArmazem('Matosinhos',Id),
                                       append([Id|LW],[Id],Route),
                                       carateristicasCam(Truck,Tare,CapacityLoad,BatteryLoad,_,ChargingTime), 
                                       Capacity is Tare + CapacityLoad,
                                       routeTime(Route, LLT,Capacity,BatteryLoad,BatteryLoad,ChargingTime,Date,Time),!.

routeTime([W1,W2],[Load1],Capacity, BatteryLoad,BatteriesFullCharged,_, _, Time):-dadosCam_t_e_ta(_, W1, W2, TravelTimeFullTruck, MaxWastedEnergy, ExtraTime),
                                                            TravelTime is TravelTimeFullTruck*Load1/Capacity,
                                                            WastedEnergy is MaxWastedEnergy*Load1/Capacity,
                                                            RemainingEnergy is BatteryLoad - WastedEnergy,
                                                            ((RemainingEnergy<(BatteriesFullCharged*0.2),
                                                            ExtraTimeNeeded is ExtraTime,!);
                                                            (ExtraTimeNeeded is 0)),
                                                            Time is TravelTime + ExtraTimeNeeded.

routeTime([W1,W2,W3|Route], [Load1,Load2|LLT],Capacity, BatteryLoad,BatteriesFullCharged,ChargingTime, Date, Time):-
                dadosCam_t_e_ta(_, W1, W2, TravelTimeFullTruck, MaxWastedEnergy, ExtraTime),
                TravelTime is TravelTimeFullTruck * Load1 / Capacity,
                WastedEnergy is MaxWastedEnergy * Load1 / Capacity,
                RemainingEnergy is BatteryLoad - WastedEnergy,
                ((RemainingEnergy < (BatteriesFullCharged * 0.2) , 
                BatteryEnergyArrivalWarehouse is (BatteriesFullCharged*0.2), 
                ExtraTimeNeeded is ExtraTime,!);
                (BatteryEnergyArrivalWarehouse is RemainingEnergy, ExtraTimeNeeded is 0)),
                entrega(_,Date,_,W2,_,UnloadingTime),
                dadosCam_t_e_ta(_, W2, W3, _,NextMaxWastedEnergy,_), 
                NextNecessaryEnergy is NextMaxWastedEnergy * Load2 / Capacity,
                idArmazem('Matosinhos',ID),
                ((W3 == ID, BatteryEnergyArrivalWarehouse - NextNecessaryEnergy < (BatteriesFullCharged*0.2),
                ChargingQuantity is ((BatteriesFullCharged*0.2) - (BatteryEnergyArrivalWarehouse - NextNecessaryEnergy) ),
                TimeCharging is ChargingQuantity*ChargingTime/(BatteriesFullCharged*0.6),
                NextBatteryLoad is ChargingQuantity + BatteryEnergyArrivalWarehouse,!);
                (((NextNecessaryEnergy > BatteryEnergyArrivalWarehouse,
                NextBatteryLoad is (BatteriesFullCharged*0.8),
       
                TimeCharging is ((BatteriesFullCharged*0.8) - BatteryEnergyArrivalWarehouse)*ChargingTime/(BatteriesFullCharged*0.6),!)
                ;
                ((BatteryEnergyArrivalWarehouse-NextNecessaryEnergy < (BatteriesFullCharged*0.2),
                NextBatteryLoad is (BatteriesFullCharged*0.8), 

                TimeCharging is ((BatteriesFullCharged*0.8) - BatteryEnergyArrivalWarehouse)*ChargingTime/(BatteriesFullCharged*0.6),!)
                ;
            	(NextBatteryLoad is RemainingEnergy, TimeCharging is 0))))),
                ((TimeCharging>UnloadingTime, WaitingTime is TimeCharging,!)
                ;
                ( WaitingTime is UnloadingTime)),
                routeTime([W2,W3|Route],[Load2|LLT], Capacity, NextBatteryLoad, BatteriesFullCharged ,ChargingTime, Date, Time1),
                Time is Time1 + TravelTime + ExtraTimeNeeded + WaitingTime.



deleteWarehouseVisited([W|RemainingWarehouses],NextWarehouse,MissingWarehouses):- delete([W|RemainingWarehouses],NextWarehouse,MissingWarehouses).

/*HEURISTICA 1- MAIS PROXIMO TEMPO OU DISTANCIA*/

nearestWarehouse(_, [], 10000,_):-!.
nearestWarehouse(Departure,[W1|Warehouses],LessTime,Warehouse):-nearestWarehouse(Departure,Warehouses,LessTime1,Warehouse1), dadosCam_t_e_ta(_,Departure,W1,Time,_,_),
                                                        ((Time<LessTime1,!, LessTime is Time, Warehouse = W1);LessTime is LessTime1, Warehouse = Warehouse1),!.


bfsNearestWarehouse(_,[],[]):-!.
bfsNearestWarehouse(Departure,[W|RemainingWarehouses],[NextWarehouse|Route]):-nearestWarehouse(Departure,[W|RemainingWarehouses],_,NextWarehouse),deleteWarehouseVisited([W|RemainingWarehouses],
                                                                                NextWarehouse,MissingWarehouses), bfsNearestWarehouse(NextWarehouse,MissingWarehouses,Route) .


bestRouteNearestWarehouse(Date,Truck,Route,Time):-warehouseRoute(Date,VisitWarehouse),idArmazem('Matosinhos',WId),bfsNearestWarehouse(WId,VisitWarehouse,Route),
                                               determineTime(Date,Truck,Route,Time), !.


/*##### HEURISTICA 2- ENTREGA MAIOR MASSA*/

deliveryPlusMass([],_, 0,_):-!.
deliveryPlusMass([W1|Warehouses],Date,GreaterMass,Warehouse):-deliveryPlusMass(Warehouses,Date,GreaterMass1,Warehouse1),entrega(_,Date,Mass,W1,_,_),
                                                           ((Mass>GreaterMass1,!, GreaterMass is Mass, Warehouse = W1);GreaterMass is GreaterMass1, Warehouse = Warehouse1),!.


bfsWarehousePlusMass(_,[],[]):-!.
bfsWarehousePlusMass(Date,[W|RemainingWarehouses],[NextWarehouse|Route]):-deliveryPlusMass([W|RemainingWarehouses],Date,_,NextWarehouse),deleteWarehouseVisited([W|RemainingWarehouses],
                                                                        NextWarehouse,MissingWarehouses), bfsWarehousePlusMass(Date, MissingWarehouses,Route).


bestRoutePlusMass(Date,Truck,Route,Time):-warehouseRoute(Date,VisitWarehouse),bfsWarehousePlusMass(Date,VisitWarehouse,Route),
                                        determineTime(Date,Truck,Route,Time), !,deliveryPlusMass(VisitWarehouse,Date,GreaterMass,_).


/*##### HEURISTICA 3- COMBINAR TEMPO COM MASSA */

bestRelationDelivery(_,[],_, 0,_):-!.
bestRelationDelivery(Departure,[W1|Warehouses],Date,BestRelation,Warehouse):-bestRelationDelivery(Departure,Warehouses,Date,BestRelation1,Warehouse1), dadosCam_t_e_ta(_,Departure,W1,Time,_,_),entrega(_,Date,Mass,W1,_,_),
                                                           (((Mass/Time)>BestRelation1,!, BestRelation is (Mass/Time), Warehouse = W1);BestRelation is BestRelation1, Warehouse = Warehouse1),!.


bfsBestRelation(_,_,[],[]):-!.
bfsBestRelation(Date,Departure,[W|RemainingWarehouses],[NextWarehouse|Route]):-bestRelationDelivery(Departure,[W|RemainingWarehouses],Date,_,NextWarehouse),deleteWarehouseVisited([W|RemainingWarehouses],
                                                                                NextWarehouse,MissingWarehouses),bfsBestRelation(Date,NextWarehouse,MissingWarehouses,Route).


bestRouteBestRelation(Date,Truck,Route,Time):-warehouseRoute(Date,VisitWarehouse),idArmazem('Matosinhos',WId),bfsBestRelation(Date,WId,VisitWarehouse,Route),
                                             determineTime(Date,Truck,Route,Time), !,bestRelationDelivery(WId,VisitWarehouse,Date,BestRelation,_).











