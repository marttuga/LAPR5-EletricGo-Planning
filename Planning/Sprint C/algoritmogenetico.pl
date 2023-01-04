:-dynamic geracoes/1.
:-dynamic populacao/1.
:-dynamic prob_cruzamento/1.
:-dynamic prob_mutacao/1.

:- consult('BCTrucks.pl').
:- consult('BCDeliveries.pl').
:- consult('BCDadosTrucks.pl').
:- consult('BCWarehouses.pl').
:- consult('BCRoutes.pl').


% tarefa(Id,TempoProcessamento,TempConc,PesoPenalizacao).
tarefa(t1,2,5,1).
tarefa(t2,4,7,6).
tarefa(t3,1,11,2).
tarefa(t4,3,9,3).
tarefa(t5,3,8,2).

% tarefas(NTarefas).
tarefas(5).

% parameterizacao - informacao pedida ao user 
inicializa:-write('Numero de novas Geracoes: '),read(NG), 
    (retract(geracoes(_));true), asserta(geracoes(NG)),
	write('Dimensao da Populacao: '),read(DP),
	(retract(populacao(_));true), asserta(populacao(DP)),
	write('Probabilidade de Cruzamento (%):'), read(P1),
	PC is P1/100, 
	(retract(prob_cruzamento(_));true), asserta(prob_cruzamento(PC)),
	write('Probabilidade de Mutacao (%):'), read(P2),
	PM is P2/100, 
	(retract(prob_mutacao(_));true), asserta(prob_mutacao(PM)).


gera:- inicializa,
	gera_populacao(Pop),
	write('Pop='),write(Pop),nl,
	avalia_populacao(Pop,PopAv),
	write('PopAv='),write(PopAv),nl,
	ordena_populacao(PopAv,PopOrd),
	geracoes(NG),
	get_time(TempoExecucao), TempoMaximo is 3600,
	Estabilizacao is 1, 
	GeracoesIguais is 0,
	gera_geracao(0,NG,PopOrd,TempoExecucao,TempoMaximo,0,GeracoesIguais,Estabilizacao,BestRoute*RouteTime),nl,nl,
	write('Melhor Viagem: '),write(BestRoute),nl,
	write('Tempo Viagem: '),write(RouteTime).

gera_populacao(Pop):-
	populacao(TamPop),
	/*procura todas as tarefas*/
	findall(ArmEntrega,entrega(_,'20230109',_,ArmEntrega,_,_),ListaArmazens),
	length(ListaArmazens, NumE),
	gera_populacao(TamPop,ListaArmazens,NumE,Pop).


gera_populacao(0,_,_,[]):-!.


gera_populacao(TamPop,ListaArmazens,NumE,[Ind|Resto]):-
	TamPop1 is TamPop-1,
	gera_populacao(TamPop1,ListaArmazens,NumE,Resto),
	((TamPop1 == 0, bestRouteNearestWarehouse('20230109', eTruck01, Ind, _),!);
	((TamPop1 == 1, bestRouteBestRelation('20230109', eTruck01, Ind, _),!);
	(gera_individuo(ListaArmazens,NumE,Ind)))),
	not(member(Ind,Resto)).
	
gera_populacao(TamPop,ListaArmazens,NumE,L):-
	gera_populacao(TamPop,ListaArmazens,NumE,L).

gera_individuo([G],1,[G]):-!.

gera_individuo(ListaArmazens,NumT,[G|Resto]):-
	NumTemp is NumT + 1, % To use with random
	random(1,NumTemp,N),
	retira(N,ListaArmazens,G,NovaLista),
	NumT1 is NumT-1,
	gera_individuo(NovaLista,NumT1,Resto).

retira(1,[G|Resto],G,Resto).
retira(N,[G1|Resto],G,[G1|Resto1]):-
	N1 is N-1,
	retira(N1,Resto,G,Resto1).

/*quando chegar a lista vazia para avaliar*/
avalia_populacao([],[]). 
/*avalia(Ind,V): para cada individuo, que pode ser solução ou rota, calcula a sua avaliacao*/
avalia_populacao([Ind|Resto],[Ind*V|Resto1]):-
	determinarTempo('20230109',eTruck01, Ind, V),
	avalia_populacao(Resto,Resto1).

/*seq: sequencia genética do individuo
V: a avaliação feita relativa a soma pesada dos atrasos*/
avalia(Seq,V):- avalia(Seq,0,V).

/*quando chegar ao fim ou a avaliação (V) for 0 ou quando o percurso chegar ao fim*/
avalia([],_,0).

/*Avlia o tempo para cada individuo*/
avalia(Seq,Inst,V):- determineTime(_,_,Seq,Tempo), V is Tempo. 

/*avalia 1 a 1 os individuos 
Inst: começa a 0
para cada tarefa*/
avalia([T|Resto],Inst,V):- tarefa(T,Dur,Prazo,Pen), 
	InstFim is Inst+Dur,
	avalia(Resto,InstFim,VResto),
	(
		/*InstFim: soma Inst e duração (soma das duracoes) */
		(InstFim =< Prazo,!, VT is 0)
  ;
		(VT is (InstFim-Prazo)*Pen)
	),
	/*Resto: lista com os restamtes individuos
	VResto começa em 0 (soma das VT), vai ser só definido depois por ser um resultado de tudo, é uma avaliação*/
	V is VT+VResto.

ordena_populacao(PopAv,PopAvOrd):- bsort(PopAv,PopAvOrd).

bsort([X],[X]):-!.

bsort([X|Xs],Ys):-
	bsort(Xs,Zs),
	btroca([X|Zs],Ys).


btroca([X],[X]):-!.

btroca([X*VX,Y*VY|L1],[Y*VY|L2]):- VX>VY,!,
	btroca([X*VX|L1],L2).

btroca([X|L1],[X|L2]):-btroca(L1,L2).



gera_geracao(G,G,Pop,_,_,0,_,_,BestRoute):-!,
	Pop = [BestRoute|_],
	write('Geracao '), write(G), write(':'), nl, write(Pop), nl.

gera_geracao(G,_,Pop,_,_,1,_,_,BestRoute):-!,
	Pop = [BestRoute|_],
	write('Geracao '), write(G), write(':'), nl, write(Pop), nl,
	write('Tempo Maximo Atingido.'),nl.

gera_geracao(G,_,Pop,_,_,0,Estabilizacao,Estabilizacao,BestRoute):-!,
	Pop = [BestRoute|_],
	write('Geracao '), write(G), write(':'), nl, write(Pop), nl,

	gera_geracao(N,G,Pop,TempoInicial,TempoMaximo,0,GeracoesIguaisAnt,Estabilizacao,BestRoute):-
	write('Geracao '), write(N), write(':'), nl, write(Pop), nl,
	random_permutation(Pop,PopAleatoria),
	cruzamento(PopAleatoria,NPop1),
	mutacao(NPop1,NPop),
	avalia_populacao(NPop,NPopAv),
	append(Pop, NPopAv, Populacao),
	sort(Populacao, Aux),
	ordena_populacao(Aux,NPopOrd),
	obter_melhores(NPopOrd,2,Melhores,Restantes),
	probabilidade_restantes(Restantes,ProbRestantes),
	ordena_populacao_probabilidade(ProbRestantes,ProbRestantesOrd),
	populacao(TamPop),
	ElementosEmFalta is TamPop-2,
	retirar_elementos_extra(ProbRestantesOrd,ElementosEmFalta,ListaMelhores),
	append(Melhores,ListaMelhores,ProxGeracao),
	ordena_populacao(ProxGeracao,ProxGeracaoOrd),
	N1 is N+1,
	get_time(Tf),
	TempEx is Tf-TempoInicial,
	verificar_tempo_execucao(TempEx,TempoMaximo,FlagFim),
	verificar_populacao_estabilizada(Pop,ProxGeracaoOrd,GeracoesIguaisAnt,GeracoesIguais),
	gera_geracao(N1,G,ProxGeracaoOrd,TempoInicial,TempoMaximo,FlagFim,GeracoesIguais,Estabilizacao,BestRoute).
	write('Geracao Estabilizada.'),nl.

gerar_pontos_cruzamento(P1,P2):- gerar_pontos_cruzamento1(P1,P2).

gerar_pontos_cruzamento1(P1,P2):- entregas(N),
	NTemp is N+1,
	random(1,NTemp,P11),
	random(1,NTemp,P21),
	P11\==P21,!,
	((P11<P21,!,P1=P11,P2=P21);(P1=P21,P2=P11)).

gerar_pontos_cruzamento1(P1,P2):- gerar_pontos_cruzamento1(P1,P2).


cruzamento([],[]).
cruzamento([Ind*_],[Ind]).
cruzamento([Ind1*_,Ind2*_|Resto],[NInd1,NInd2|Resto1]):- gerar_pontos_cruzamento(P1,P2),
	prob_cruzamento(Pcruz),random(0.0,1.0,Pc),
	((Pc =< Pcruz,!,
        cruzar(Ind1,Ind2,P1,P2,NInd1),
	  cruzar(Ind2,Ind1,P1,P2,NInd2))
	;
	(NInd1=Ind1,NInd2=Ind2)),
	cruzamento(Resto,Resto1).

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

rotate_right(L,K,L1):- entregas(N),
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

insere([X|R],L,N,L2):- entregas(T),
	((N>T,!,N1 is N mod T);N1 = N),
	insere1(X,N1,L,L1),
	N2 is N + 1,
	insere(R,L1,N2,L2).


insere1(X,1,L,[X|L]):-!.

insere1(X,N,[Y|L],[Y|L1]):- N1 is N-1,
	insere1(X,N1,L,L1).

cruzar(Ind1,Ind2,P1,P2,NInd11):- sublista(Ind1,P1,P2,Sub1),
	tarefas(NumT),
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
addTare(Tare, [Load|LL], [LoadTara|LLT]):- addTare(Tare,LL,LLT), LoadTara is Load + Tare.

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
                                               determineTime(Date,Truck,Route,Time), ! , format('Fastest Time rounded: ~3f~n', [Time]).


/*##### HEURISTICA 2- ENTREGA MAIOR MASSA*/

deliveryPlusMass([],_, 0,_):-!.
deliveryPlusMass([W1|Warehouses],Date,GreaterMass,Warehouse):-deliveryPlusMass(Warehouses,Date,GreaterMass1,Warehouse1),entrega(_,Date,Mass,W1,_,_),
                                                           ((Mass>GreaterMass1,!, GreaterMass is Mass, Warehouse = W1);GreaterMass is GreaterMass1, Warehouse = Warehouse1),!.


bfsWarehousePlusMass(_,[],[]):-!.
bfsWarehousePlusMass(Date,[W|RemainingWarehouses],[NextWarehouse|Route]):-deliveryPlusMass([W|RemainingWarehouses],Date,_,NextWarehouse),deleteWarehouseVisited([W|RemainingWarehouses],
                                                                        NextWarehouse,MissingWarehouses), bfsWarehousePlusMass(Date, MissingWarehouses,Route).


bestRoutePlusMass(Date,Truck,Route,Time):-warehouseRoute(Date,VisitWarehouse),bfsWarehousePlusMass(Date,VisitWarehouse,Route),
                                        determineTime(Date,Truck,Route,Time), !,deliveryPlusMass(VisitWarehouse,Date,GreaterMass,_), format('Greater Mass: ~0f~n', [GreaterMass]), format('Fastest Time rounded: ~3f~n', [Time]).


/*##### HEURISTICA 3- COMBINAR TEMPO COM MASSA */

bestRelationDelivery(_,[],_, 0,_):-!.
bestRelationDelivery(Departure,[W1|Warehouses],Date,BestRelation,Warehouse):-bestRelationDelivery(Departure,Warehouses,Date,BestRelation1,Warehouse1), dadosCam_t_e_ta(_,Departure,W1,Time,_,_),entrega(_,Date,Mass,W1,_,_),
                                                           (((Mass/Time)>BestRelation1,!, BestRelation is (Mass/Time), Warehouse = W1);BestRelation is BestRelation1, Warehouse = Warehouse1),!.


bfsBestRelation(_,_,[],[]):-!.
bfsBestRelation(Date,Departure,[W|RemainingWarehouses],[NextWarehouse|Route]):-bestRelationDelivery(Departure,[W|RemainingWarehouses],Date,_,NextWarehouse),deleteWarehouseVisited([W|RemainingWarehouses],
                                                                                NextWarehouse,MissingWarehouses),bfsBestRelation(Date,NextWarehouse,MissingWarehouses,Route).


bestRouteBestRelation(Date,Truck,Route,Time):-warehouseRoute(Date,VisitWarehouse),idArmazem('Matosinhos',WId),bfsBestRelation(Date,WId,VisitWarehouse,Route),
                                             determineTime(Date,Truck,Route,Time), !,bestRelationDelivery(WId,VisitWarehouse,Date,BestRelation,_), format('Best Relation Mass/Time: ~3f~n', [BestRelation]), format('Fastest Time rounded: ~3f~n', [Time]).











