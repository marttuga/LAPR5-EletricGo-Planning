
:-dynamic geracoes/1.
:-dynamic populacao/1.
:-dynamic prob_cruzamento/1.
:-dynamic prob_mutacao/1.
:-dynamic entregas/1.


% parameteriza��o
inicializa(NG,DP,P1,P2):-(retract(geracoes(_));true), asserta(geracoes(NG)),
	(retract(populacao(_));true), asserta(populacao(DP)),
	PC is P1/100,
	(retract(prob_cruzamento(_));true),	asserta(prob_cruzamento(PC)),
	PM is P2/100,
	(retract(prob_mutacao(_));true), asserta(prob_mutacao(PM)).


gera(Data, Camiao, MelhorPlaneamento,Tempo, TMax, LimEstabilizacao,CamioesNecessarios,EntregasPorCamiao):-
	CamioesNecessarios is 3,
	EntregasPorCamiao is 5,
	inicializa(6,8,50,25),
	gera_populacao(Pop, Data, Camiao),
	avalia_populacao(Pop,PopAv,Data,Camiao),
	ordena_populacao(PopAv,PopOrd),
	geracoes(NG),
	get_time(Ti),
	gera_geracao(0,NG,PopOrd,0,LimEstabilizacao,Ti,TMax,0,Data,Camiao,MelhorPlaneamento*Tempo).


gera_populacao(Pop, Data, Camiao):-
	populacao(TamPop),
	findall(Entrega, entrega(_,Data,_,Entrega,_,_),ListaEntregas),
	length(ListaEntregas, NumE),
	(retract(entregas(_));true),	asserta(entregas(NumE)),
	gera_populacao(TamPop,ListaEntregas,NumE,Pop, Data, Camiao).


gera_populacao(0,_,_,[],Data,Camiao):-!.

gera_populacao(TamPop,ListaEntregas,NumE,[Ind|Resto],Data,Camiao):-
	TamPop1 is TamPop-1,
	gera_populacao(TamPop1,ListaEntregas,NumE,Resto,Data,Camiao),
	((TamPop1 is 0, !,bestRouteNearestWarehouse(Data, Camiao, Ind, _));((TamPop1 is 1, !, obter_segundo_individuo(Resto,Data,Camiao,Ind)));
	(gera_individuo(ListaEntregas,NumE,Ind))),
	not(member(Ind,Resto)).
gera_populacao(TamPop,ListaEntregas,NumE,L,Data,Camiao):-
	gera_populacao(TamPop,ListaEntregas,NumE,L,Data,Camiao).



obter_segundo_individuo([PrimeiroInd|Resto], Data, Camiao, Ind):-
	bestRoutePlusMass(Data, Camiao, AuxInd, _),
	((AuxInd == PrimeiroInd, !, bestRouteBestRelation(Data, Camiao, Ind, _));(Ind = AuxInd)).


gera_individuo([G],1,[G]):-!.

gera_individuo(ListaEntregas,NumE,[G|Resto]):-
	NumTemp is NumE + 1, % To use with random
	random(1,NumTemp,N),
	retira(N,ListaEntregas,G,NovaLista),
	NumT1 is NumE-1,
	gera_individuo(NovaLista,NumT1,Resto).


retira(1,[G|Resto],G,Resto):-!.
retira(N,[G1|Resto],G,[G1|Resto1]):-
	N1 is N-1,
	retira(N1,Resto,G,Resto1).

avalia_populacao([],[],_,_):-!.
avalia_populacao([Ind|Resto],[Ind*V|Resto1],Data,Camiao):-
	determineTime(Data, Camiao, Ind, V),
	avalia_populacao(Resto,Resto1,Data,Camiao).

ordena_populacao(PopAv,PopAvOrd):-
	bsort(PopAv,PopAvOrd).

bsort([X],[X]):-!.
bsort([X|Xs],Ys):-
	bsort(Xs,Zs),
	btroca([X|Zs],Ys).


btroca([X],[X]):-!.

btroca([X*VX,Y*VY|L1],[Y*VY|L2]):-
	VX>VY,!,
	btroca([X*VX|L1],L2).

btroca([X|L1],[X|L2]):-btroca(L1,L2).


gera_geracao(G,G,Pop,_,_,_,_,_,_,_,MelhorPlaneamento):-!,
	obterMelhorPlaneamento(Pop,MelhorPlaneamento).

gera_geracao(G,_,Pop,LimEstabilizacao,LimEstabilizacao,_,_,_,_,_,MelhorPlaneamento):-!,
	obterMelhorPlaneamento(Pop,MelhorPlaneamento).

gera_geracao(G,_,Pop,_,_,_,_,1,_,_,MelhorPlaneamento):-!,
	obterMelhorPlaneamento(Pop,MelhorPlaneamento).

gera_geracao(N,G,Pop,Cont,LimEstabilizacao,Ti,TMax,_,Data,Camiao,MelhorPlaneamento):-
	random_permutation(Pop,RandomPop),
	cruzamento(RandomPop,NPop1),
	mutacao(NPop1,NPop),
	avalia_populacao(NPop,NPopAv,Data,Camiao),
	append(Pop, NPopAv, JuncaoPop),
	sort(JuncaoPop, NoDuplicates),
	ordena_populacao(NoDuplicates, NoDuplicatesOrd),
	Perc is 30/100,
	populacao(TamPop),
	P is round(Perc*TamPop),
	retirarPMelhores(NoDuplicatesOrd,P,ListaPMelhores,ListaRestantes),
	produtoListaRestantes(ListaRestantes,ListaProdutoRestantes),
	sort(0,@=<,ListaProdutoRestantes,ListaProdutoRestantesOrd),
	organizarListaProduto(ListaProdutoRestantesOrd,ListaProdutoRestantesOrg),
	PrimeirosElementos is TamPop-P,
	retirarNPElementos(ListaProdutoRestantesOrg,PrimeirosElementos,ListaNPMelhores),
	append(ListaPMelhores,ListaNPMelhores,ProxGeracao),
	verificarEstabilizacao(Pop,ProxGeracao,Cont,ContAtualizado),
	N1 is N+1,
	get_time(Tf),
	TSol is Tf-Ti,
	verificarTempoLimite(TSol,TMax,FlagMax),
	gera_geracao(N1,G,ProxGeracao,ContAtualizado,LimEstabilizacao,Ti,TMax,FlagMax,Data,Camiao,MelhorPlaneamento).


% Retira os P Melhores e retorna uma nova lista ListaRestantes com os T-P elementos

retirarPMelhores([H|NoDuplicatesOrd], 0, [],[H|NoDuplicatesOrd]):-!.
retirarPMelhores([Ind|NoDuplicatesOrd],P,[Ind|ListaMelhores],ListaRestantes):-
	P1 is P-1,
	retirarPMelhores(NoDuplicatesOrd,P1,ListaMelhores,ListaRestantes).


produtoListaRestantes([],[]):-!.
produtoListaRestantes([Ind*Tempo|ListaRestantes],[(Produto,Ind*Tempo)|ListaProduto]):-produtoListaRestantes(ListaRestantes,ListaProduto), random(0.0,1.0,NumAleatorio), Produto is NumAleatorio * Tempo.

organizarListaProduto([],[]):-!.
organizarListaProduto([(_,Ind*Tempo)|ListaProduto],[Ind*Tempo|ListaFinalProduto]):-organizarListaProduto(ListaProduto,ListaFinalProduto).


retirarNPElementos([_|_], 0, []):-!.
retirarNPElementos([Ind|ListaProdutoRestantesOrd],NP,[Ind|ListaNPMelhores]):-
	NP1 is NP-1,
	retirarNPElementos(ListaProdutoRestantesOrd,NP1,ListaNPMelhores).

verificarEstabilizacao(Pop,ProxGeracao,Cont,ContAtualizado):-((verificarListasIguais(Pop,ProxGeracao), !, ContAtualizado is Cont+1);(ContAtualizado is 0)).

verificarListasIguais([],[]):-!.
verificarListasIguais([Ind1|Pop],[Ind2|ProxGeracao]):-Ind1=Ind2, verificarListasIguais(Pop,ProxGeracao).

verificarTempoLimite(TSol,TMax,FlagMax):-((TSol > TMax,!,FlagMax is 1);(FlagMax is 0)).

obterMelhorPlaneamento(Pop,MelhorPlaneamento):-ordena_populacao(Pop,PopOrd),PopOrd = [MelhorPlaneamento|_].

gerar_pontos_cruzamento(P1,P2):-
	gerar_pontos_cruzamento1(P1,P2).

gerar_pontos_cruzamento1(P1,P2):-
	entregas(N),
	NTemp is N+1,
	random(1,NTemp,P11),
	random(1,NTemp,P21),
	P11\==P21,!,
	((P11<P21,!,P1=P11,P2=P21);(P1=P21,P2=P11)).
gerar_pontos_cruzamento1(P1,P2):-
	gerar_pontos_cruzamento1(P1,P2).


cruzamento([],[]).
cruzamento([Ind*_],[Ind]).
cruzamento([Ind1*_,Ind2*_|Resto],[NInd1,NInd2|Resto1]):-
	gerar_pontos_cruzamento(P1,P2),
	prob_cruzamento(Pcruz),random(0.0,1.0,Pc),
	((Pc =< Pcruz,!,
        cruzar(Ind1,Ind2,P1,P2,NInd1),
	  cruzar(Ind2,Ind1,P1,P2,NInd2))
	;
	(NInd1=Ind1,NInd2=Ind2)),
	cruzamento(Resto,Resto1).

preencheh([],[]).

preencheh([_|R1],[h|R2]):-
	preencheh(R1,R2).


sublista(L1,I1,I2,L):-
	I1 < I2,!,
	sublista1(L1,I1,I2,L).

sublista(L1,I1,I2,L):-
	sublista1(L1,I2,I1,L).

sublista1([X|R1],1,1,[X|H]):-!,
	preencheh(R1,H).

sublista1([X|R1],1,N2,[X|R2]):-!,
	N3 is N2 - 1,
	sublista1(R1,1,N3,R2).

sublista1([_|R1],N1,N2,[h|R2]):-
	N3 is N1 - 1,
	N4 is N2 - 1,
	sublista1(R1,N3,N4,R2).

rotate_right(L,K,L1):-
	entregas(N),
	T is N - K,
	rr(T,L,L1).

rr(0,L,L):-!.

rr(N,[X|R],R2):-
	N1 is N - 1,
	append(R,[X],R1),
	rr(N1,R1,R2).


elimina([],_,[]):-!.

elimina([X|R1],L,[X|R2]):-
	not(member(X,L)),!,
	elimina(R1,L,R2).

elimina([_|R1],L,R2):-
	elimina(R1,L,R2).

insere([],L,_,L):-!.
insere([X|R],L,N,L2):-
	entregas(T),
	((N>T,!,N1 is N mod T);N1 = N),
	insere1(X,N1,L,L1),
	N2 is N + 1,
	insere(R,L1,N2,L2).


insere1(X,1,L,[X|L]):-!.
insere1(X,N,[Y|L],[Y|L1]):-
	N1 is N-1,
	insere1(X,N1,L,L1).

cruzar(Ind1,Ind2,P1,P2,NInd11):-
	sublista(Ind1,P1,P2,Sub1),
	entregas(NumE),
	R is NumE-P2,
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
mutacao([Ind|Rest],[NInd|Rest1]):-
	prob_mutacao(Pmut),
	random(0.0,1.0,Pm),
	((Pm < Pmut,!,mutacao1(Ind,NInd));NInd = Ind),
	mutacao(Rest,Rest1).

mutacao1(Ind,NInd):-
	gerar_pontos_cruzamento(P1,P2),
	mutacao22(Ind,P1,P2,NInd).

mutacao22([G1|Ind],1,P2,[G2|NInd]):-
	!, P21 is P2-1,
	mutacao23(G1,P21,Ind,G2,NInd).
mutacao22([G|Ind],P1,P2,[G|NInd]):-
	P11 is P1-1, P21 is P2-1,
	mutacao22(Ind,P11,P21,NInd).

mutacao23(G1,1,[G2|Ind],G2,[G1|Ind]):-!.
mutacao23(G1,P,[G|Ind],G2,[G|NInd]):-
	P1 is P-1,
	mutacao23(G1,P1,Ind,G2,NInd).