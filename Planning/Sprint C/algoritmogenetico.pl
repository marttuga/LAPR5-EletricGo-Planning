:- use_module(library(http/json)).
:- use_module(library(http/json_convert)).
:- use_module(library(http/http_server)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_open)).
:- use_module(library(http/http_cors)).
:- use_module(library(http/http_json)).
:- use_module(library(http/http_client)).
:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_parameters)).
:- use_module(library(dcg/basics)).

:- set_setting(http:cors, [*]).


:- consult('BCTrucks.pl').
:- consult('BCDeliveries.pl').
:- consult('BCDadosTrucks.pl').
:- consult('BCWarehouses.pl').
:- consult('BCRoutes.pl').
:-include('directory.pl').

%cidadeArmazem(<codigo>).
cidadeArmazem("005").

%dadosCam_t_e_ta(<cidade_origem>,<cidade_destino>,<tempo>,<energia>,<tempo_adicional>).
dadosCam_t_e_ta("001","002",122,42,0).
dadosCam_t_e_ta("001","003",122,46,0).
dadosCam_t_e_ta("001","004",151,54,25).
dadosCam_t_e_ta("001","005",147,52,25).
dadosCam_t_e_ta("001","006",74,24,0).
dadosCam_t_e_ta("001","007",116,35,0).
dadosCam_t_e_ta("001","008",141,46,0).
dadosCam_t_e_ta("001","009",185,74,53).
dadosCam_t_e_ta("001","010",97,30,0).
dadosCam_t_e_ta("001","011",164,64,40).
dadosCam_t_e_ta("001","012",76,23,0).
dadosCam_t_e_ta("001","013",174,66,45).
dadosCam_t_e_ta("001","014",59,18,0).
dadosCam_t_e_ta("001","015",132,51,24).
dadosCam_t_e_ta("001","016",181,68,45).
dadosCam_t_e_ta("001","017",128,45,0).

dadosCam_t_e_ta("002","001",116,42,0).
dadosCam_t_e_ta("002","003",55,22,0).
dadosCam_t_e_ta("002","004",74,25,0).
dadosCam_t_e_ta("002","005",65,22,0).
dadosCam_t_e_ta("002","006",69,27,0).
dadosCam_t_e_ta("002","007",74,38,0).
dadosCam_t_e_ta("002","008",61,18,0).
dadosCam_t_e_ta("002","009",103,44,0).
dadosCam_t_e_ta("002","010",36,14,0).
dadosCam_t_e_ta("002","011",88,41,0).
dadosCam_t_e_ta("002","012",61,19,0).
dadosCam_t_e_ta("002","013",95,42,0).
dadosCam_t_e_ta("002","014",78,34,0).
dadosCam_t_e_ta("002","015",69,30,0).
dadosCam_t_e_ta("002","016",99,38,0).
dadosCam_t_e_ta("002","017",46,14,0).

dadosCam_t_e_ta("003","001",120,45,0).
dadosCam_t_e_ta("003","002",50,22,0).
dadosCam_t_e_ta("003","004",46,15,0).
dadosCam_t_e_ta("003","005",46,14,0).
dadosCam_t_e_ta("003","006",74,37,0).
dadosCam_t_e_ta("003","007",63,23,0).
dadosCam_t_e_ta("003","008",38,8,0).
dadosCam_t_e_ta("003","009",84,36,0).
dadosCam_t_e_ta("003","010",59,28,0).
dadosCam_t_e_ta("003","011",61,27,0).
dadosCam_t_e_ta("003","012",67,32,0).
dadosCam_t_e_ta("003","013",67,29,0).
dadosCam_t_e_ta("003","014",82,38,0).
dadosCam_t_e_ta("003","015",34,8,0).
dadosCam_t_e_ta("003","016",80,30,0).
dadosCam_t_e_ta("003","017",36,10,0).

dadosCam_t_e_ta("004","001",149,54,25).
dadosCam_t_e_ta("004","002",65,24,0).
dadosCam_t_e_ta("004","003",46,16,0).
dadosCam_t_e_ta("004","005",27,10,0).
dadosCam_t_e_ta("004","006",103,47,0).
dadosCam_t_e_ta("004","007",55,27,0).
dadosCam_t_e_ta("004","008",36,10,0).
dadosCam_t_e_ta("004","009",50,26,0).
dadosCam_t_e_ta("004","010",78,34,0).
dadosCam_t_e_ta("004","011",42,19,0).
dadosCam_t_e_ta("004","012",97,42,0).
dadosCam_t_e_ta("004","013",44,11,0).
dadosCam_t_e_ta("004","014",111,48,0).
dadosCam_t_e_ta("004","015",32,13,0).
dadosCam_t_e_ta("004","016",53,14,0).
dadosCam_t_e_ta("004","017",38,11,0).

dadosCam_t_e_ta("005","001",141,51,24).
dadosCam_t_e_ta("005","002",55,20,0).
dadosCam_t_e_ta("005","003",48,14,0).
dadosCam_t_e_ta("005","004",25,9,0).
dadosCam_t_e_ta("005","006",97,44,0).
dadosCam_t_e_ta("005","007",55,28,0).
dadosCam_t_e_ta("005","008",29,7,0).
dadosCam_t_e_ta("005","009",48,24,0).
dadosCam_t_e_ta("005","010",69,30,0).
dadosCam_t_e_ta("005","011",53,26,0).
dadosCam_t_e_ta("005","012",95,36,0).
dadosCam_t_e_ta("005","013",63,20,0).
dadosCam_t_e_ta("005","014",105,45,0).
dadosCam_t_e_ta("005","015",34,14,0).
dadosCam_t_e_ta("005","016",46,18,0).
dadosCam_t_e_ta("005","017",27,7,0).

dadosCam_t_e_ta("006","001",69,23,0).
dadosCam_t_e_ta("006","002",71,27,0).
dadosCam_t_e_ta("006","003",74,38,0).
dadosCam_t_e_ta("006","004",103,46,0).
dadosCam_t_e_ta("006","005",99,44,0).
dadosCam_t_e_ta("006","007",88,48,0).
dadosCam_t_e_ta("006","008",92,38,0).
dadosCam_t_e_ta("006","009",134,66,45).
dadosCam_t_e_ta("006","010",42,14,0).
dadosCam_t_e_ta("006","011",116,56,30).
dadosCam_t_e_ta("006","012",23,9,0).
dadosCam_t_e_ta("006","013",126,58,33).
dadosCam_t_e_ta("006","014",25,9,0).
dadosCam_t_e_ta("006","015",84,44,0).
dadosCam_t_e_ta("006","016",132,60,35).
dadosCam_t_e_ta("006","017",80,38,0).

dadosCam_t_e_ta("007","001",116,36,0).
dadosCam_t_e_ta("007","002",71,38,0).
dadosCam_t_e_ta("007","003",61,22,0).
dadosCam_t_e_ta("007","004",53,26,0).
dadosCam_t_e_ta("007","005",53,28,0).
dadosCam_t_e_ta("007","006",88,48,0).
dadosCam_t_e_ta("007","008",59,26,0).
dadosCam_t_e_ta("007","009",88,48,0).
dadosCam_t_e_ta("007","010",84,44,0).
dadosCam_t_e_ta("007","011",74,22,0).
dadosCam_t_e_ta("007","012",82,42,0).
dadosCam_t_e_ta("007","013",76,31,0).
dadosCam_t_e_ta("007","014",97,49,21).
dadosCam_t_e_ta("007","015",29,16,0).
dadosCam_t_e_ta("007","016",84,42,0).
dadosCam_t_e_ta("007","017",69,30,0).

dadosCam_t_e_ta("008","001",134,46,0).
dadosCam_t_e_ta("008","002",59,18,0).
dadosCam_t_e_ta("008","003",32,6,0).
dadosCam_t_e_ta("008","004",34,10,0).
dadosCam_t_e_ta("008","005",32,7,0).
dadosCam_t_e_ta("008","006",88,38,0).
dadosCam_t_e_ta("008","007",57,26,0).
dadosCam_t_e_ta("008","009",69,30,0).
dadosCam_t_e_ta("008","010",65,26,0).
dadosCam_t_e_ta("008","011",53,22,0).
dadosCam_t_e_ta("008","012",82,34,0).
dadosCam_t_e_ta("008","013",61,24,0).
dadosCam_t_e_ta("008","014",97,40,0).
dadosCam_t_e_ta("008","015",36,12,0).
dadosCam_t_e_ta("008","016",65,23,0).
dadosCam_t_e_ta("008","017",32,6,0).

dadosCam_t_e_ta("009","001",181,72,50).
dadosCam_t_e_ta("009","002",95,41,0).
dadosCam_t_e_ta("009","003",86,35,0).
dadosCam_t_e_ta("009","004",55,24,0).
dadosCam_t_e_ta("009","005",48,23,0).
dadosCam_t_e_ta("009","006",134,65,42).
dadosCam_t_e_ta("009","007",95,47,0).
dadosCam_t_e_ta("009","008",69,28,0).
dadosCam_t_e_ta("009","010",109,51,24).
dadosCam_t_e_ta("009","011",61,29,0).
dadosCam_t_e_ta("009","012",132,57,31).
dadosCam_t_e_ta("009","013",67,19,0).
dadosCam_t_e_ta("009","014",143,66,45).
dadosCam_t_e_ta("009","015",71,34,0).
dadosCam_t_e_ta("009","016",15,3,0).
dadosCam_t_e_ta("009","017",67,28,0).

dadosCam_t_e_ta("010","001",97,30,0).
dadosCam_t_e_ta("010","002",34,14,0).
dadosCam_t_e_ta("010","003",59,27,0).
dadosCam_t_e_ta("010","004",78,33,0).
dadosCam_t_e_ta("010","005",71,30,0).
dadosCam_t_e_ta("010","006",40,14,0).
dadosCam_t_e_ta("010","007",82,42,0).
dadosCam_t_e_ta("010","008",65,24,0).
dadosCam_t_e_ta("010","009",109,52,25).
dadosCam_t_e_ta("010","011",92,46,0).
dadosCam_t_e_ta("010","012",32,6,0).
dadosCam_t_e_ta("010","013",99,46,0).
dadosCam_t_e_ta("010","014",63,17,0).
dadosCam_t_e_ta("010","015",74,34,0).
dadosCam_t_e_ta("010","016",105,46,0).
dadosCam_t_e_ta("010","017",53,23,0).

dadosCam_t_e_ta("011","001",164,65,42).
dadosCam_t_e_ta("011","002",88,41,0).
dadosCam_t_e_ta("011","003",65,28,0).
dadosCam_t_e_ta("011","004",42,18,0).
dadosCam_t_e_ta("011","005",55,25,0).
dadosCam_t_e_ta("011","006",118,57,31).
dadosCam_t_e_ta("011","007",74,23,0).
dadosCam_t_e_ta("011","008",59,23,0).
dadosCam_t_e_ta("011","009",63,28,0).
dadosCam_t_e_ta("011","010",97,46,0).
dadosCam_t_e_ta("011","012",111,52,25).
dadosCam_t_e_ta("011","013",25,7,0).
dadosCam_t_e_ta("011","014",126,58,33).
dadosCam_t_e_ta("011","015",53,25,0).
dadosCam_t_e_ta("011","016",59,27,0).
dadosCam_t_e_ta("011","017",67,27,0).

dadosCam_t_e_ta("012","001",76,23,0).
dadosCam_t_e_ta("012","002",61,19,0).
dadosCam_t_e_ta("012","003",67,32,0).
dadosCam_t_e_ta("012","004",97,41,0).
dadosCam_t_e_ta("012","005",92,38,0).
dadosCam_t_e_ta("012","006",19,8,0).
dadosCam_t_e_ta("012","007",82,42,0).
dadosCam_t_e_ta("012","008",86,33,0).
dadosCam_t_e_ta("012","009",128,61,37).
dadosCam_t_e_ta("012","010",32,6,0).
dadosCam_t_e_ta("012","011",109,50,23).
dadosCam_t_e_ta("012","013",120,53,26).
dadosCam_t_e_ta("012","014",40,10,0).
dadosCam_t_e_ta("012","015",78,38,0).
dadosCam_t_e_ta("012","016",126,54,28).
dadosCam_t_e_ta("012","017",74,32,0).

dadosCam_t_e_ta("013","001",174,65,42).
dadosCam_t_e_ta("013","002",107,35,0).
dadosCam_t_e_ta("013","003",74,29,0).
dadosCam_t_e_ta("013","004",46,11,0).
dadosCam_t_e_ta("013","005",67,20,0).
dadosCam_t_e_ta("013","006",128,57,31).
dadosCam_t_e_ta("013","007",80,30,0).
dadosCam_t_e_ta("013","008",76,20,0).
dadosCam_t_e_ta("013","009",67,20,0).
dadosCam_t_e_ta("013","010",105,47,0).
dadosCam_t_e_ta("013","011",27,7,0).
dadosCam_t_e_ta("013","012",122,52,25).
dadosCam_t_e_ta("013","014",137,58,33).
dadosCam_t_e_ta("013","015",67,17,0).
dadosCam_t_e_ta("013","016",59,15,0).
dadosCam_t_e_ta("013","017",78,22,0).

dadosCam_t_e_ta("014","001",59,18,0).
dadosCam_t_e_ta("014","002",80,35,0).
dadosCam_t_e_ta("014","003",80,38,0).
dadosCam_t_e_ta("014","004",109,46,0).
dadosCam_t_e_ta("014","005",105,45,0).
dadosCam_t_e_ta("014","006",27,9,0).
dadosCam_t_e_ta("014","007",97,48,0).
dadosCam_t_e_ta("014","008",99,38,0).
dadosCam_t_e_ta("014","009",143,66,45).
dadosCam_t_e_ta("014","010",61,17,0).
dadosCam_t_e_ta("014","011",122,57,31).
dadosCam_t_e_ta("014","012",42,10,0).
dadosCam_t_e_ta("014","013",132,58,35).
dadosCam_t_e_ta("014","015",90,44,0).
dadosCam_t_e_ta("014","016",139,61,37).
dadosCam_t_e_ta("014","017",86,38,0).

dadosCam_t_e_ta("015","001",132,51,24).
dadosCam_t_e_ta("015","002",74,30,0).
dadosCam_t_e_ta("015","003",34,8,0).
dadosCam_t_e_ta("015","004",36,12,0).
dadosCam_t_e_ta("015","005",36,14,0).
dadosCam_t_e_ta("015","006",86,44,0).
dadosCam_t_e_ta("015","007",34,16,0).
dadosCam_t_e_ta("015","008",42,13,0).
dadosCam_t_e_ta("015","009",71,35,0).
dadosCam_t_e_ta("015","010",82,36,0).
dadosCam_t_e_ta("015","011",53,25,0).
dadosCam_t_e_ta("015","012",80,38,0).
dadosCam_t_e_ta("015","013",69,18,0).
dadosCam_t_e_ta("015","014",95,45,0).
dadosCam_t_e_ta("015","016",69,29,0).
dadosCam_t_e_ta("015","017",53,17,0).

dadosCam_t_e_ta("016","001",179,68,45).
dadosCam_t_e_ta("016","002",92,37,0).
dadosCam_t_e_ta("016","003",84,31,0).
dadosCam_t_e_ta("016","004",57,16,0).
dadosCam_t_e_ta("016","005",46,18,0).
dadosCam_t_e_ta("016","006",132,60,35).
dadosCam_t_e_ta("016","007",92,42,0).
dadosCam_t_e_ta("016","008",67,23,0).
dadosCam_t_e_ta("016","009",15,3,0).
dadosCam_t_e_ta("016","010",105,46,0).
dadosCam_t_e_ta("016","011",57,28,0).
dadosCam_t_e_ta("016","012",130,52,25).
dadosCam_t_e_ta("016","013",61,15,0).
dadosCam_t_e_ta("016","014",141,61,37).
dadosCam_t_e_ta("016","015",69,29,0).
dadosCam_t_e_ta("016","017",65,24,0).

dadosCam_t_e_ta("017","001",128,46,0).
dadosCam_t_e_ta("017","002",42,14,0).
dadosCam_t_e_ta("017","003",40,11,0).
dadosCam_t_e_ta("017","004",42,13,0).
dadosCam_t_e_ta("017","005",34,10,0).
dadosCam_t_e_ta("017","006",82,38,0).
dadosCam_t_e_ta("017","007",74,30,0).
dadosCam_t_e_ta("017","008",29,6,0).
dadosCam_t_e_ta("017","009",69,31,0).
dadosCam_t_e_ta("017","010",55,24,0).
dadosCam_t_e_ta("017","011",69,29,0).
dadosCam_t_e_ta("017","012",80,30,0).
dadosCam_t_e_ta("017","013",82,23,0).
dadosCam_t_e_ta("017","014",90,38,0).
dadosCam_t_e_ta("017","015",53,18,0).
dadosCam_t_e_ta("017","016",67,25,0).


:- dynamic idArmazem/2.
:- dynamic carateristicasCam/6.
:- dynamic entrega/6.


% Criacao de servidor HTTP no porto 'Port'
server(Port) :-
        http_server(http_dispatch, [port(Port)]),
		importarInformacao().

stopServer:-
    retract(port(Port)),
    http_stop_server(Port,_).

:- initialization(server(64172)).

/* base de conhecimento dinâmica: obtem as entregas e os camioes do MDWM e do MDL*/
importarInformacao():-
    addWarehouses(),
    addTrucks(),
    addDeliveries().

addWarehouses():-
	http_open('https://localhost:5001/api/warehouse', ResultJSON, []),
	json_read_dict(ResultJSON, ResultObj),
	warehouseInfo(ResultObj, ResultValue),
	createWarehouse(ResultValue),
	close(ResultJSON).

/* dá os pormenores relativos aos armazens */
warehouseInfo([],[]).
warehouseInfo([H|T],[H.id,H.designacaoArmazem.designation|L]):-
	warehouseInfo(T, L).

createWarehouse([]).
createWarehouse([I,D|L]):-
	assert(idArmazem(I,D)),
	createWarehouse(L).

deleteWarehouse():-
    retract(idArmazem(_,_)),
    fail.

addTrucks():- http_open('http://localhost:3000/api/truck', ResultJSON, []),
	json_read_dict(ResultJSON, ResultObj),
	truckInfo(ResultObj, ResultValue),
	createTruck(ResultValue),
	close(ResultJSON).

truckInfo([],[]).
truckInfo([H|T],[Designacao,H.tare,H.capacity,H.maxBatteryCapacity,H.autonomy,H.chargingTime|L]):-
	atom_string(H.designation, X),
  	atom_string(Designacao, X),
	truckInfo(T, L).

createTruck([]).
createTruck([D,T,MC,MB,A,CT|L]):- write(D),nl,
	assert(carateristicasCam(D,T,MC,MB,A,CT)),
	createTruck(L).

deleteTruck():- retract(carateristicasCam(_,_,_,_,_,_)),
    fail.

/* obtem as entregas do MDWM*/
addDeliveries():- http_open('https://localhost:5001/api/Deliveries', ResultJSON, []),
	json_read_dict(ResultJSON, ResultObj),
	deliveryInfo(ResultObj, ResultValue),
	/*cria a entrega*/
	createDelivery(ResultValue),
	close(ResultJSON).

deliveryInfo([],[]).
deliveryInfo([H|T],[(H.deliveryId, date, H.mass.valor, H.armazemID.value, H.tempoCarga.minutos, H.tempoDescarga.minutos)|L]):-
  atom_number(H.data, X),
  atom_number(date, X),
  deliveryInfo(T, L).

createDelivery([]).
createDelivery([(DeliveryId,Date,Mass, WarehouseId,TimeLoad,TimeUnload)|L]):-
	assert(entrega(DeliveryId,Date,Mass,WarehouseId,TimeLoad,TimeUnload)),
	createDelivery(L).

deleteDelivery():- retract(entrega(_,_,_,_,_,_)), fail.

:-dynamic geracoes/1.
:-dynamic populacao/1.
:-dynamic prob_cruzamento/1.
:-dynamic prob_mutacao/1.


% tarefa(Id,TempoProcessamento,TempConc,PesoPenalizacao).
tarefa(t1,2,5,1).
tarefa(t2,4,7,6).
tarefa(t3,1,11,2).
tarefa(t4,3,9,3).
tarefa(t5,3,8,2).

% tarefas(NTarefas).
tarefas(5).

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
	determinar_quantidade_camioes(NeededTrucks),
	determinar_entregas_por_camiao(DistributionResult,NeededTrucks),
	gera_populacao(Pop),
	write('Pop='),write(Pop),nl,
	valida_populacao(Pop,NeededTrucks,DistributionResult,[],PopAtualizada),
	avalia_populacao(PopAtualizada,PopAv,NeededTrucks,DistributionResult),
	write('PopAv='),write(PopAv),nl,
	ordena_populacao(PopAv,PopOrd),
	geracoes(NG),
	get_time(TempoExecucao),
	TempoMaximo is 3600,
	Estabilizacao is 1, 
	GeracoesIguais is 0,
	gera_geracao(0,NG,PopOrd,TempoExecucao,TempoMaximo,0,GeracoesIguais,Estabilizacao,BestRoute*RouteTime,NeededTrucks,DistributionResult),nl,nl,
	/* com base na melhor viagem e na heuristica de melhor tempo de viagem*/
	write('Melhor Viagem: '),write(BestRoute),nl,
	write('Tempo Viagem: '),write(RouteTime).

/* vai fazer o calculo do peso de todas as entregas para calcular o numero de camioes necessários*/
determinar_quantidade_camioes(NeededTrucks):- findall(Mass,entrega(_,'20230110',Mass,_,_,_),Cargas),
	obter_carga_total(Cargas,0,CargaTotal),
	carateristicasCam(eTruck01,_,CapacidadeCarga,_,_,_),
	NumberOfTrucks is CargaTotal/CapacidadeCarga,
	number_of_trucks(NumberOfTrucks,NeededTrucks).

obter_carga_total([],CargaTotal,CargaTotal):-!.

obter_carga_total([H|T],CargaTotal1,CargaTotal):- CargaTotal2 is CargaTotal1+H,
	obter_carga_total(T,CargaTotal2,CargaTotal).

number_of_trucks(NumberOfTrucks,NeededTrucks):- ParteInteira is float_integer_part(NumberOfTrucks),
	ParteDecimal is float_fractional_part(NumberOfTrucks),
	((ParteDecimal > 0.75,ed is ParteInteira+2);ed is ParteInteira+1).

distribution_of_deliveries(DistributionResult,NeededTrucks):- entregas(NEntregas),
	DistributionResultAux is NEntregas/NeededTrucks,
	DistributionResult is float_integer_part(DistributionResultAux).

gera_populacao(Pop):- populacao(TamPop),
	/*procura todas as entregas/tarefas*/
	findall(WarehouseChegada,entrega(_,'20230109',_,WarehouseChegada,_,_),WarehousesL),
	length(WarehousesL, NumE),
	gera_populacao(TamPop,WarehousesL,NumE,Pop).


gera_populacao(0,_,_,[]):-!.

gera_populacao(TamPop,WarehousesL,NumE,[Ind|Resto]):- TamPop1 is TamPop-1,
	gera_populacao(TamPop1,WarehousesL,NumE,Resto),
	((TamPop1 == 0, bestRouteNearestWarehouse('20230109', eTruck01, Ind, _),!);
	((TamPop1 == 1, bestRouteBestRelation('20230109', eTruck01, Ind, _),!);
	(gera_individuo(WarehousesL,NumE,Ind)))),
	not(member(Ind,Resto)).
	
gera_populacao(TamPop,WarehousesL,NumE,L):- gera_populacao(TamPop,WarehousesL,NumE,L).

gera_individuo([G],1,[G]):-!.

gera_individuo(WarehousesL,NumT,[G|Resto]):- NumTemp is NumT + 1, % To use with random
	random(1,NumTemp,N),
	retira(N,WarehousesL,G,NovaLista),
	NumT1 is NumT-1,
	gera_individuo(NovaLista,NumT1,Resto).


avalia_individuo(_,_,_,_,1,ViagemValida):- ViagemValida is 1,!.

avalia_individuo(_,_,_,_,2,ViagemValida):- ViagemValida is 0,!.


avalia_individuo(Ind,AvaliacoesRealizadas,NeededTrucks,DistributionResult,0,ViagemValida):-
	((AvaliacoesRealizadas < (NeededTrucks), obter_x_elementos(DistributionResult,Ind,EntregasCamiao),
  obterCargaCamiao('20230110',EntregasCamiao,CargaViagem,CargaTotal), Flag is 0);
  (obterCargaCamiao('20230110',Ind,CargaViagem,CargaTotal),Flag is 2)),
	((CargaTotal > 4300,avalia_individuo(_,NeededTrucks,NeededTrucks,_,1,ViagemValida));
	(AvaliacaoAtualizada is AvaliacoesRealizadas+1,remover_x_elementos(DistributionResult,Ind,IndAtualizada),
	avalia_individuo(IndAtualizada,AvaliacaoAtualizada,NeededTrucks,DistributionResult,Flag,ViagemValida))).

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
avalia_populacao([],[]). 
/*vai chamar o avalia do tempo para obter qual é o tempo da viagem para ficar guardado em cada individuo da populacao, 
que tem associado a ele as varias entregas e o tempo */
avalia_populacao([Ind|Resto],[Ind*V|Resto1],NeededTrucks,DistributionResult):-
	Camioes is truncate(NeededTrucks),
	obter_tempo_viagem(Ind,0,0,Camioes,DistributionResult,V),
	avalia_populacao(Resto,Resto1,NeededTrucks,DistributionResult).

obter_tempo_viagem(_,Tempo,Camioes,Camioes,_,TempoMaior):- TempoMaior is Tempo, !.

obter_tempo_viagem(Ind,Tempo,TemposCalculados,NeededTrucks,DistributionResult,TempoMaior):-
	((TemposCalculados < (NeededTrucks - 1), obter_x_elementos(DistributionResult,Ind,EntregasCamiao),
  determinarTempo('20230110',eTruck01, EntregasCamiao, TempoViagem));
  (determinarTempo('20230110',eTruck01, Ind, TempoViagem))),
	((TempoViagem > Tempo, NovoTempo is TempoViagem);(NovoTempo is Tempo)),
	remover_x_elementos(DistributionResult,Ind,IndAtualizada),
	VezesCalculadas is TemposCalculados+1,
	obter_tempo_viagem(IndAtualizada,NovoTempo,VezesCalculadas,NeededTrucks,DistributionResult,TempoMaior).

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
	Pop = [BestRoute|_],
	write('Geracao '), write(G), write(':'), nl, write(Pop), nl,
	write('Tempo Maximo Atingido.'),nl.

gera_geracao(G,_,Pop,_,_,0,Estabilizacao,Estabilizacao,BestRoute,_,_):-!,
	Pop = [BestRoute|_],
	write('Geracao '), write(G), write(':'), nl, write(Pop), nl,
	write('Geracao Estabilizada.'),nl.

gera_geracao(N,G,Pop,TempoInicial,TempoMaximo,0,GeracoesIguaisAnt,Estabilizacao,BestRoute,NeededTrucks,DistributionResult):-
write('Geracao '), write(N), write(':'), nl, write(Pop), nl,
	random_permutation(Pop,PopAleatoria),
	cruzamento(PopAleatoria,NPop1),
	mutacao(NPop1,NPop),
	valida_populacao(NPop,NeededTrucks,DistributionResult,[],PopAtualizada),
	avalia_populacao(PopAtualizada,NPopAv,NeededTrucks,DistributionResult),
	append(Pop, NPopAv, Populacao),
	sort(Populacao, Aux),
	ordena_populacao(Aux,NPopOrd),
	obter_melhores(NPopOrd,2,Melhores,Restantes),
	probabilidade_restantes(Restantes,ProbRestantes),
	ordena_populacao_probabilidade(ProbRestantes,ProbRestantesOrd),
	populacao(TamPop),
	ElementosEmFalta is TamPop-2,
	retirar_elementos_extra(ProbRestantesOrd,ElementosEmFalta,ListaEscolhidos),
	append(Melhores,ListaEscolhidos,ProxGeracao),
	ordena_populacao(ProxGeracao,ProxGeracaoOrd),
	N1 is N+1,
	get_time(Tf),
	TempEx is Tf-TempoInicial,
	verificar_tempo_execucao(TempEx,TempoMaximo,FlagFim),
	verificar_populacao_estabilizada(Pop,ProxGeracaoOrd,GeracoesIguaisAnt,GeracoesIguais),
	gera_geracao(N1,G,ProxGeracaoOrd,TempoInicial,TempoMaximo,FlagFim,GeracoesIguais,Estabilizacao,BestRoute,NeededTrucks,DistributionResult).



verificar_tempo_execucao(TempEx,TempoMaximo,FlagFim):-  ((TempEx < TempoMaximo, FlagFim is 0);(FlagFim is 0)).

verificar_populacao_estabilizada(Pop,ProxGeracaoOrd,GeracoesIguaisAnt,GeracoesIguais):-
	((verificar_semelhanca_populacoes(Pop,ProxGeracaoOrd), !, GeracoesIguais is GeracoesIguaisAnt+1);
	(GeracoesIguais is 0)).

verificar_semelhanca_populacoes([],[]):-!.
verificar_semelhanca_populacoes([P1|Populacao],[P2|ProxGeracao]):- P1=P2, 
	verificar_semelhanca_populacoes(Populacao,ProxGeracao).

obter_melhores([H|NPopOrd], 0, [],[H|NPopOrd]).
obter_melhores([Ind|NPopOrd],P,[Ind|Melhores],Restantes):-
	P1 is P-1,
	obter_melhores(NPopOrd,P1,Melhores,Restantes).

probabilidade_restantes([],[]):-!.
probabilidade_restantes([Ind*Tempo|Restantes],[Ind*Tempo*Prob|ListaProb]):-
	probabilidade_restantes(Restantes,ListaProb), 
	random(0.0,1.0,NumAl), Prob is NumAl * Tempo.


retirar_elementos_extra([H|ListaProdutoRestantesOrd], 0, []).
/*Lista dos escolhidos será a lista dos melhores*/
retirar_elementos_extra([Ind*Tempo*Prob|ListaProdutoRestantesOrd],NP,[Ind*Tempo|ListaEscolhidos]):- NP1 is NP-1,
	retirar_elementos_extra(ListaProdutoRestantesOrd,NP1,ListaEscolhidos).


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











