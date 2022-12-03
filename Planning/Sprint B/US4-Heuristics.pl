
:-consult('BaseConhecimento.pl').



/* Começamos por procurar todos os armazens cujas deliveries foram feitas na data especificada
L - Lista de armazéns
WId - ID do armazém
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
finalRoute(Date,FWL):-routes(Date,LR), fullRoute(LR, FWL),write(FWL).




/*US 2


Avaliar essas trajetórias de acordo com o tempo para completar todas as entregas e 
voltar ao armazém base de Matosinhos e escolher a solução que permite a volta com o camião mais cedo 
*/

/* Numa dada data, com uma lista de armazéns guardada em LW e uma lista de Loads LL e Load do camião atual
Com isto vai buscar as entregas todas para essa dada data e vai usar as suas massas para fazer o cálculo da Load  */
getLoadTruck(_, [], [], 0):-!.
getLoadTruck(Date, [Warehouse|LW], [Load|LL], Load):-getLoadTruck(Date, LW, LL, LoadAux), entrega(_,Date,Mass,Warehouse,_,_), 
                                                        Load is Mass + LoadAux.

/* Para um dado camião, vai buscar a sua tara para posteriormente fazer a soma da tara  */
addTareTruck(TruckName, LL, LLT):- carateristicasCam(TruckName,Tare,_,_,_,_), addTare(Tare,LL,LLT).

/* LLT: composta pela Load + tara */
addTare(Tare,[],[Tare]):-!.
addTare(Tare, [Load|LL], [LoadTara|LLT]):- addTare(Tare,LL,LLT), LoadTara is Load + Tare.

/* Consoante os dados dos camioes, a sua capacidade total corresponde a tara e a capacidade de Load*/
getCapacityWLoadAndTare(Truck,Capacity):-carateristicasCam(Truck,Tare,CapacityLoad,_,_,_), 
                                                Capacity is Tare + CapacityLoad.

/* O tempo necessário para concluir as viagens entre troços de armazéns que tem de fazer, para isso terá que saber a Load que o Truck
transporta, saber a sua tara, o peso total do Truck já cheio, ter em conta também a bateria com que se encontra e quanto demora para 
a carregar, para no final, calcular o tempo da viagem total  */
determineTime(Date, Truck, LW, Time):- getLoadTruck(Date, LW, LL,_), addTareTruck(Truck,LL, LLT),
                                            idArmazem('Matosinhos',WId), append([WId|LW],[WId],Routes),
                                           getCapacityWLoadAndTare(Truck,Capacity),
                                           carateristicasCam(Truck,_,_,BatteryLoad,_,ChargingTime),
                                           routeTime(Routes, LLT,Capacity,BatteryLoad,BatteryLoad,ChargingTime,Date,Time),!.

/* Dado um troço entres 2 armazéns e a Load com que parte do armazém e a sua bateria, para um dado camião calcula-se a energia gasta nesse trajeto, o tempo que é necessário
que se calcula através do tempo máximo que nos é dada a partir da base de conhecimentos*Load com que sai do armazém pela sua capacidade */
routeTime([W1,W2],[Load1],Capacity, BatteryLoad,MaxLoad,_, _, Time):-dadosCam_t_e_ta(_, W1, W2, RouteMaxTime, MaxWastedEnergy, ExtraTime),
                                                            RouteTime is RouteMaxTime*Load1/Capacity,
                                                            RouteEnergy is MaxWastedEnergy*Load1/Capacity,
                                                            BatteriesEnergy is BatteryLoad - RouteEnergy,
                                                            ((BatteriesEnergy<(MaxLoad*0.2), ExtraTimeNeeded is ExtraTime,!);(ExtraTimeNeeded is 0)),
                                                            Time is RouteTime + ExtraTimeNeeded.

/* Depois de descarregar uma primeira vez as entregas, calcular com que capacidade ainda fica, a bateria que lhe resta e ver se é suficiente para prosseguir até à próxima paragem
(armazém), se não terá que carregar a bateria
É preciso ter em conta o tempo que se leva a descarregar o camião (tirar as encomendas)
Time1 vai ser o tempo da viagem entre o ultimo troço de armazéns */
routeTime([W1,W2,W3|Routes], [Load1,Load2|LLT],Capacity, BatteryLoad,MaxLoad,ChargingTime, Date, Time):-dadosCam_t_e_ta(_, W1, W2, RouteMaxTime, MaxWastedEnergy, ExtraTime),
                    RouteTime is RouteMaxTime*Load1/Capacity, RouteEnergy is MaxWastedEnergy*Load1/Capacity,
                    BatteriesEnergy is BatteryLoad - RouteEnergy,
                    ((BatteriesEnergy<(MaxLoad*0.2),BatteryEnergyArrivalWarehouse is (MaxLoad*0.2), 
                    ExtraTimeNeeded is ExtraTime,!);(BatteryEnergyArrivalWarehouse is BatteriesEnergy, ExtraTimeNeeded is 0)), 
                    entrega(_,Date,_,W2,_,DischaringTime),
                    dadosCam_t_e_ta(_, W2, W3, _,NextMaxWastedEnergy,_), 
                    NextNecessaryEnergy is NextMaxWastedEnergy * Load2 / Capacity,
                     idArmazem('Matosinhos',WId), ((W3 == WId, BatteryEnergyArrivalWarehouse - NextNecessaryEnergy < (MaxLoad*0.2), 
                    ChargingQuantity is ((MaxLoad*0.2) - (BatteryEnergyArrivalWarehouse - NextNecessaryEnergy) ), 
                    TimeCharging is ChargingQuantity*ChargingTime/(MaxLoad*0.6),
                    NextBatteryLoad is ChargingQuantity+BatteryEnergyArrivalWarehouse,!);
                    (((NextNecessaryEnergy>BatteryEnergyArrivalWarehouse,NextBatteryLoad is (MaxLoad*0.8),
                    TimeCharging is ((MaxLoad*0.8) - BatteryEnergyArrivalWarehouse)*ChargingTime/(MaxLoad*0.6),!);
                    ((BatteryEnergyArrivalWarehouse-NextNecessaryEnergy<(MaxLoad*0.2),
                    NextBatteryLoad is (MaxLoad*0.8), TimeCharging is ((MaxLoad*0.8) - BatteryEnergyArrivalWarehouse)*ChargingTime/(MaxLoad*0.6),!);
                    (NextBatteryLoad is BatteriesEnergy, TimeCharging is 0))))),
                    ((TimeCharging>DischaringTime, WaitingTime is TimeCharging,!);( WaitingTime is DischaringTime)),
                    routeTime([W2,W3|Routes],[Load2|LLT], Capacity, NextBatteryLoad, MaxLoad ,ChargingTime, Date, Time1),
                    Time is Time1 + RouteTime + ExtraTimeNeeded + WaitingTime.

/* A melhor viagem considerando o menor tempo*/
bestRoute(L,Time,Date,Truck):- get_time(Ti),
                                    (run(Date, Truck);true),lessTime(L,Time),
                                    get_time(Tf), TResult is Tf-Ti,
                                    write(TResult),nl.

/* retractall: Remove */
run(Date, Truck):- retractall(lessTime(_,_)), assertz(lessTime(_,1000000)),
        findall(Id, entrega(_,Date,_,Id,_,_),LF), permutation(LF,FLPerm),
        determineTime(Date,Truck,FLPerm,Time), update(FLPerm,Time),
        fail.

/* update o tempo para o menor tempo possivel */
update(FLPerm,Time):-
        lessTime(_,MinimumTime),((Time<MinimumTime,!,retract(lessTime(_,_)),
        assertz(lessTime(FLPerm,Time)));true).






 
/*US 4*/

deleteWarehouseVisited([W|RemainingWarehouses],NextWarehouse,MissingWarehouses):- delete([W|RemainingWarehouses],NextWarehouse,MissingWarehouses).

/*HEURISTICA 1- MAIS PROXIMO TEMPO OU DISTANCIA

#retorna o armazem mais proximo. Recebe o armazem de origem, a lista de todos os armazens e o tempo. Vai entao procurar o camiao que tem o mesmo armazem de origem, o de destino e o mesmo tempo.
#calcula o menor tempo entre os armazens, relativamente ao de origem e o que tiver menor fica o armazem escolhido mais proximo*/

nearestWarehouse(_, [], 0,_):-!.
nearestWarehouse(Departure,[W1|Warehouses],LessTime,Warehouse):-nearestWarehouse(Departure,Warehouses,LessTime1,Warehouse1), dadosCam_t_e_ta(_,Departure,W1,Time,_,_),
                                                        ((Time<LessTime1,!, LessTime is Time, Warehouse = W1);LessTime is LessTime1, Warehouse = Warehouse1).



/*
(bfs)-best first search
#mais rapido e eficiente q o breadth
# recebe o armazem de origem, lista de armazens e retorna a lista com os troços entre os armazens mais proximos
#a partir do armazem,cidade origem e da lista vai buscar o armazem mais proximo da origem, de seguida apaga esse ja visto da lista dos armazens e manda o armazem mais proximo da origem encontrado como origem para o bfs*/

bfsNearestWarehouse(_,[],[]):-!.
bfsNearestWarehouse(Departure,[W|RemainingWarehouses],[NextWarehouse|Route]):-nearestWarehouse(Departure,[W|RemainingWarehouses],_,NextWarehouse),deleteWarehouseVisited([W|RemainingWarehouses],
                                                                                NextWarehouse,MissingWarehouses), bfsNearestWarehouse(NextWarehouse,MissingWarehouses,Route).



/*#tendo em conta a Date, o camiao, a lista dos troços de armazens(as viagens) e o tempo, obter a melhor viagem
# vai entao começar por arranjar todos os armazens (onde devam ser feitas entregas naquela Date), numa lista, de seguida arranja o armazem,cidade origem, que vai ser utilizado no bfs para obter a lista de viagens 
# finalmente a partir da Date , camiao e viagens, vai determinar os tempos para poder comparar e descobrir o melhor*/

bestRouteNearestWarehouse(Date,Truck,Route,Time):-warehouseRoute(Date,VisitWarehouse),idArmazem('Matosinhos',WId),bfsNearestWarehouse(WId,VisitWarehouse,Route),
                                               determineTime(Date,Truck,Route,Time), ! , format('Fastest Time rounded: ~3f~n', [Time]).



/*##### HEURISTICA 2- ENTREGA MAIOR MASSA

#para determinar o armazem cuja entrega tem maior massa
# recebe a lista de armazens, Date e a massa para a posterior comparaçao 
# começa por receber os dados e compará-los com os da entrega, neste caso comparar a GreaterMass1 com a massa da entrega respetiva naquela Date e para o armazem fornecido W1*/

deliveryPlusMass([],_, 0,_):-!.
deliveryPlusMass([W1|Warehouses],Date,GreaterMass,Warehouse):-deliveryPlusMass(Warehouses,Date,GreaterMass1,Warehouse1),entrega(_,Date,Mass,W1,_,_),
                                                           ((Mass>GreaterMass1,!, GreaterMass is Mass, Warehouse = W1);GreaterMass is GreaterMass1, Warehouse = Warehouse1),!.


/*# recebe a Date, lista de armazens e retorna a lista com os troços entre os armazens mais proximos
#a partir da Date e da lista vai buscar a entrega com maior massa para esse armazem, de seguida apaga esse ja visto da lista dos armazens e manda a Date e os armazens seguintes para o bfs*/

bfsWarehousePlusMass(_,[],[]):-!.
bfsWarehousePlusMass(Date,[W|RemainingWarehouses],[NextWarehouse|Route]):-deliveryPlusMass([W|RemainingWarehouses],Date,_,NextWarehouse),deleteWarehouseVisited([W|RemainingWarehouses],
                                                                        NextWarehouse,MissingWarehouses), bfsWarehousePlusMass(Date, MissingWarehouses,Route).


/*#tendo em conta a Date, o camiao, a lista dos troços de armazens(as viagens) e o tempo, obter a melhor viagem
# vai entao começar por arranjar todos os armazens (onde devam ser feitas entregas naquela Date), numa lista, de seguida vai mandar essa lista e a Date para o bfs e vai obter a lista de viagens 
# finalmente a partir da Date , camiao e viagens, vai determinar os tempos para poder comparar e descobrir o melhor*/

bestRoutePlusMass(Date,Truck,Route,Time):-warehouseRoute(Date,VisitWarehouse),bfsWarehousePlusMass(Date,VisitWarehouse,Route),
                                        determineTime(Date,Truck,Route,Time), !,deliveryPlusMass(VisitWarehouse,Date,GreaterMass,_), format('Greater Mass: ~0f~n', [GreaterMass]), format('Fastest Time rounded: ~3f~n', [Time]).





/*##### HEURISTICA 3- COMBINAR TEMPO COM MASSA 

# obter o armazem cuja entrega tem melhor relacao entre o tempo e a massa 
# recebe o armazem,cidade origem, a lista dos armazens, a Date e a relaçao(para posterior comparaçao),
# começa entao por receber os dados e vai buscar o tempo do camiao (cujo armazem de origem e destino sao os mesmos que os recebidos na funçao) e vai buscar a massa da entrega( cuja Date e armazem de destino sao os mesmos recebidos na funçao e do camiao)
# faz-se a comparaçao entre a relaçao massa da entrega tempo camiao e a relacao dos valores iniciais para obter o armazem 
massa/tempo -> melhor relacao é comn maior massa chega mais rapido
*/

bestRelationDelivery(_,[],_, 0,_):-!.
bestRelationDelivery(Departure,[W1|Warehouses],Date,BestRelation,Warehouse):-bestRelationDelivery(Departure,Warehouses,Date,BestRelation1,Warehouse1), dadosCam_t_e_ta(_,Departure,W1,Time,_,_),entrega(_,Date,Mass,W1,_,_),
                                                           (((Mass/Time)>BestRelation1,!, BestRelation is (Mass/Time), Warehouse = W1);BestRelation is BestRelation1, Warehouse = Warehouse1),!.


/*# recebe a Date, o armazem,cidade origem, lista de armazens e retorna a lista com os troços entre os armazens mais proximos
#a partir do armazem,cidade origem , da lista e da Date vai buscar a entrega com maior massa para esse armazem, de seguida apaga esse ja visto da lista dos armazens e manda a Date e os armazens seguintes para o bfs*/

bfsBestRelation(_,_,[],[]):-!.
bfsBestRelation(Date,Departure,[W|RemainingWarehouses],[NextWarehouse|Route]):-bestRelationDelivery(Departure,[W|RemainingWarehouses],Date,_,NextWarehouse),deleteWarehouseVisited([W|RemainingWarehouses],
                                                                                NextWarehouse,MissingWarehouses),bfsBestRelation(Date,NextWarehouse,MissingWarehouses,Route).


/*#tendo em conta a Date, o camiao, a lista dos troços de armazens(as viagens) e o tempo, obter a melhor viagem com a melhor relacao tempo e massa
# vai entao começar por arranjar todos os armazens (onde devam ser feitas entregas naquela Date), numa lista, de seguida vai buscar a cidade/armazem origem e vai mandar a origem, a lista e a Date para o bfs e vai obter a lista de viagens 
# finalmente a partir da Date , camiao e viagens, vai determinar os tempos para poder comparar e descobrir o melhor*/

bestRouteBestRelation(Date,Truck,Route,Time):-warehouseRoute(Date,VisitWarehouse),idArmazem('Matosinhos',WId),bfsBestRelation(Date,WId,VisitWarehouse,Route),
                                             determineTime(Date,Truck,Route,Time), !,bestRelationDelivery(WId,VisitWarehouse,Date,BestRelation,_), format('Best Relation Mass/Time: ~3f~n', [BestRelation]), format('Fastest Time rounded: ~3f~n', [Time]).