

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
                                               determineTime(Date,Truck,Route,Time), ! .



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
                                        determineTime(Date,Truck,Route,Time), !.





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
                                             determineTime(Date,Truck,Route,Time), !.