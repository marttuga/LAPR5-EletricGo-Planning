:- consult('BCTrucks.pl').
:- consult('BCDeliveries.pl').
:- consult('BCDadosTrucks.pl').
:- consult('BCWarehouses.pl').
:- consult('BCRoutes.pl').


/* 
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

/* LLT: composta pela Load(carga do camião) + tara */
addTare(Tare,[],[Tare]):-!.
addTare(Tare, [Load|LL], [LoadTara|LLT]):- addTare(Tare,LL,LLT), LoadTara is Load + Tare.



/* O tempo necessário para concluir as viagens entre troços de armazéns que tem de fazer, para isso terá que saber a Load que o Truck
transporta, saber a sua tara, o peso total do Truck já cheio, ter em conta também a bateria com que se encontra e quanto demora para 
a carregar, para no final, calcular o tempo da viagem total  */
determineTime(Date, Truck, LW, Time):- getLoadTruck(Date, LW, LL,_),
                                       addTareTruck(Truck,LL, LLT),
                                       idArmazem('Matosinhos',Id),
                                       append([Id|LW],[Id],Route),
                                       carateristicasCam(Truck,Tare,CapacityLoad,BatteryLoad,_,ChargingTime), 
                                       Capacity is Tare + CapacityLoad,
                                       routeTime(Route, LLT,Capacity,BatteryLoad,BatteryLoad,ChargingTime,Date,Time),!.




/* Dado um troço entres 2 armazéns e a Load(carga) com que parte do armazém e a sua bateria, para um dado camião calcula-se a energia gasta nesse trajeto, o tempo que é necessário
que se calcula através do tempo máximo que nos é dada a partir da base de conhecimentos*Load com que sai do armazém pela sua capacidade */
routeTime([W1,W2],[Load1],Capacity, BatteryLoad,BatteriesFullCharged,_, _, Time):-dadosCam_t_e_ta(_, W1, W2, TravelTimeFullTruck, MaxWastedEnergy, ExtraTime),
                                                            TravelTime is TravelTimeFullTruck*Load1/Capacity,
                                                            WastedEnergy is MaxWastedEnergy*Load1/Capacity,
                                                            RemainingEnergy is BatteryLoad - WastedEnergy,
                                                            ((RemainingEnergy<(BatteriesFullCharged*0.2),
                                                            ExtraTimeNeeded is ExtraTime,!);
                                                            (ExtraTimeNeeded is 0)),
                                                            Time is TravelTime + ExtraTimeNeeded.

/* Depois de descarregar uma primeira vez as entregas, calcular com que capacidade ainda fica, a bateria que lhe resta e ver se é suficiente para prosseguir até à próxima paragem
(armazém), se não terá que carregar a bateria
É preciso ter em conta o tempo que se leva a descarregar o camião (tirar as encomendas)
Time1 vai ser o tempo da viagem entre o ultimo troço de armazéns 
Começa por pesquisar na base de conhecimento a cidade de onde parte e o seu primeiro destino de entrega*/
routeTime([W1,W2,W3|Route], [Load1,Load2|LLT],Capacity, BatteryLoad,BatteriesFullCharged,ChargingTime, Date, Time):-
                dadosCam_t_e_ta(_, W1, W2, TravelTimeFullTruck, MaxWastedEnergy, ExtraTime),
                /*Tempo que demora de W1 a W2 tendo em conta o que carrega*/
                TravelTime is TravelTimeFullTruck * Load1 / Capacity,
                /*Quantidade de energia gasta de W1 a W2 tendo em conta o que carrega*/
                WastedEnergy is MaxWastedEnergy * Load1 / Capacity,
                /*Quantidade de energia restante quandi chega a W2 considerando que estava completamente carregado em W1*/
                RemainingEnergy is BatteryLoad - WastedEnergy,
                /*Caso a energia restante seja menor que 20% da total, 
                é obrigado a carregar aé aos 20%, sendo que o tempo extra é apresentado no 6º agrumento do facto*/
                ((RemainingEnergy < (BatteriesFullCharged * 0.2) , 
                BatteryEnergyArrivalWarehouse is (BatteriesFullCharged*0.2), 
                ExtraTimeNeeded is ExtraTime,!);
                /*Caso seja maior, vamos verificar à frente se é suficiente para chegar ao próximo armazém */
                (BatteryEnergyArrivalWarehouse is RemainingEnergy, ExtraTimeNeeded is 0)),
                /* Vamos buscar o tempo de descarregameto da entrega 
                e a energia que se gasta no próximo troço caso o truck esteja cheio */ 
                entrega(_,Date,_,W2,_,UnloadingTime),
                dadosCam_t_e_ta(_, W2, W3, _,NextMaxWastedEnergy,_), 
                /* Calculo da energia gasta para o próximo troço considerando a carga do truck já com um descarregamento */
                NextNecessaryEnergy is NextMaxWastedEnergy * Load2 / Capacity,
                idArmazem('Matosinhos',ID),
                /* Verifica se o próximo armazém é o último, se for verifica se   */
                ((W3 == ID, BatteryEnergyArrivalWarehouse - NextNecessaryEnergy < (BatteriesFullCharged*0.2),
                /*Quantidade de energia que precisa de carregar quando chega a Matosinhos para chegar aos 20% */ 
                ChargingQuantity is ((BatteriesFullCharged*0.2) - (BatteryEnergyArrivalWarehouse - NextNecessaryEnergy) ),
                /* Como são precisos 60 minutos para carregar 60% do camião(48kw), 
                vamos calcular quanto tempo é preciso para carregar a quantidade em falta para chegar aos 20% */ 
                TimeCharging is ChargingQuantity*ChargingTime/(BatteriesFullCharged*0.6),
                /**/
                NextBatteryLoad is ChargingQuantity + BatteryEnergyArrivalWarehouse,!)
                ;
                /*Se a energia precisa é maior que a que temos, temos de carregar até aos 80% */
                (((NextNecessaryEnergy > BatteryEnergyArrivalWarehouse,
                NextBatteryLoad is (BatteriesFullCharged*0.8),
                /* Cálculo do tempo de carregamento vai ser igual à diferença entre o que nos falta para estar completamente carregado,
                 tendo em conta o tempo que demora um carregamento */
                TimeCharging is ((BatteriesFullCharged*0.8) - BatteryEnergyArrivalWarehouse)*ChargingTime/(BatteriesFullCharged*0.6),!)
                ;
                /*Se a diferença entre a bateria que temos e a necessária for menor que 20%, é obrigatório carregar até ao 80% */
                ((BatteryEnergyArrivalWarehouse-NextNecessaryEnergy < (BatteriesFullCharged*0.2),
                NextBatteryLoad is (BatteriesFullCharged*0.8), 
                /* Cálculo do tempo de carregamento vai ser igual à diferença entre o que nos falta para estar completamente carregado,
                 tendo em conta o tempo que demora um carregamento */
                TimeCharging is ((BatteriesFullCharged*0.8) - BatteryEnergyArrivalWarehouse)*ChargingTime/(BatteriesFullCharged*0.6),!)
                
                ;
                /* Se a energia necessária para chegar ao próximo destino é igual ao que tenho disponível, não gasto temp em carregar*/
                (NextBatteryLoad is RemainingEnergy, TimeCharging is 0))))),
                /* Caso o tempo de carregamento for superior ao tempo de descarga da encomenda, ou vice-versa,
                 o tempo de espera vai ser o maior dos dois tempos */
                ((TimeCharging>UnloadingTime, WaitingTime is TimeCharging,!)
                ;
                ( WaitingTime is UnloadingTime))
                ,
                /* Método recursivo*/
                routeTime([W2,W3|Route],[Load2|LLT], Capacity, NextBatteryLoad, BatteriesFullCharged ,ChargingTime, Date, Time1),
                Time is Time1 + TravelTime + ExtraTimeNeeded + WaitingTime.

/* retractall: Remove 
LW - Lista de aramazéns
LWPerm - Lista de armazéns permutada
*/
run(Date, Truck):- retractall(lessTime(_,_)), 
                assertz(lessTime(_,1000000)),
                findall(WId, entrega(_,Date,_,WId,_,_),LW),
                permutation(LW,LWPerm),
                determineTime(Date,Truck,LWPerm,Time),
                update(LWPerm,Time),
                fail.

/* update o tempo para o menor tempo possivel com as várias listas de viagens com os variados armazéns */
update(FLPerm,Time):-
        lessTime(_,MinimumTime),((Time<MinimumTime,!,retract(lessTime(_,_)),
        assertz(lessTime(FLPerm,Time)));true).

/* A melhor viagem considerando o menor tempo*/
bestRoute(Date,Truck,L,Time):- get_time(Ti),
                                (run(Date, Truck);true),lessTime(L,Time),
                                get_time(Tf), TResult is Tf-Ti,
                                write(TResult),nl.

