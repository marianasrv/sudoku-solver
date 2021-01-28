% Projeto LP - Mariana Saraiva 87683 %

:- include('SUDOKU').

%---------------------------------------------------------------------
% tira_num_aux(Puz, Pos, Cont):
% N_Puz e o puzzle resultante de tirar o numero Num da posicao
% Pos do puzzle Puz.
% E utlizado o predicado puzzle_ref(Puz, Pos, Cont) que devolve o
% conteudo Cont da posicao Pos do puzzle Puz.
%---------------------------------------------------------------------

tira_num_aux(Num, Puz, Pos, N_Puz):-
	puzzle_ref(Puz, Pos, Cont),
	(member(Num, Cont) -> tirar_numero(Cont, Num, N_Cont) ; puzzle_ref(Puz, Pos, N_Cont)),
	puzzle_muda_propaga(Puz, Pos, N_Cont, N_Puz).

%---------------------------------------------------------------------
% 	Predicado auxiliar do predicado tira_num_aux
%
% tirar_numero(Cont, Num, N_Cont):
% N_Cont e o resultado de retirar o numero Num de Cont.
%
%---------------------------------------------------------------------

tirar_numero([N|Res], N, Res):- !.

tirar_numero([N|Res], X, [N|N_Res]):-
		tirar_numero(Res, X, N_Res).
%---------------------------------------------------------------------
% tira_num(Num, Puz, Posicoes, N_Puz):
% N_Puz e o puzzle resultante de tirar o numero Num de todas as
% posicoes em Posicoes do puzzle Puz.
% 	Recorre se ao predicado precorre_muda_Puz(Puz, Accao, Lst, N_Puz):
% Puz e um puzzle; Accao e um predicado de argumentos [Puz, <elemento de Lst>,N_Puz]
% N_Puz e o puzzle resultante de aplicar Accao(Puz, <elemento de Lst>,N_Puz)
% a cada elemento de Lst.
%---------------------------------------------------------------------

tira_num(Num, Puz, Posicoes, N_Puz):-
	percorre_muda_Puz(Puz,tira_num_aux(Num),Posicoes, N_Puz).

%---------------------------------------------------------------------
% puzzle_muda_propaga(Puz, Pos, Cont, N_Puz):
% N_Puz e o resultado de substituir o conteudo da posicao Pos
% de Puz por Cont, mas, no caso de Cont ser uma lista unitaria,
% retira o numero em Cont de todas as posicoes na mesma linha, coluna ou bloco.
%---------------------------------------------------------------------

puzzle_muda_propaga(Puz, Pos, Cont, Puz):-
	puzzle_ref(Puz, Pos, Cont), !.

puzzle_muda_propaga(Puz, Pos, [N], N1_Puz):-
	!,
	puzzle_muda(Puz, Pos, [N], N_Puz),
	posicoes_relacionadas(Pos,Posicoes),
	tira_num(N, N_Puz, Posicoes, N1_Puz).

puzzle_muda_propaga(Puz, Pos, Cont, N_Puz):-
	puzzle_muda(Puz, Pos, Cont, N_Puz).


%---------------------------------------------------------------------
% possibilidades(Pos, Puz, Poss):
% Poss e a lista de numeros possiveis para a posicao Pos,
% do puzzle Puz, caso o conteudo da posicao Pos nao seja uma lista unitaria.
% E utilizado um predicado auxiliar de modo a retirar os conteudos unitarios
% das posicoes relacionadas.
%---------------------------------------------------------------------

possibilidades(Pos, Puz, Poss):-
	posicoes_relacionadas(Pos,Posicoes),
	conteudos_posicoes(Puz, Posicoes, Conteudos),
	numeros(L),
	retira_conteudos_unitarios(L, Conteudos , Poss).

%---------------------------------------------------------------------
% 	Predicado auxiliar do predicado possibilidades
%
% retira_conteudos_unitarios(L, Conteudos, Poss):
% Poss e a lista L a qual sao retirados os conteudos das listas unitarias
% das posicoes relacionadas.
%---------------------------------------------------------------------

retira_conteudos_unitarios(L,[],L).

retira_conteudos_unitarios(L, [[]|Res], Poss):-
	retira_conteudos_unitarios(L, Res, Poss), !.

retira_conteudos_unitarios(L, [[C]|Res], Poss):-
	member(C, L), !,
	tirar_numero(L, C, L1),
	retira_conteudos_unitarios(L1, Res, Poss).

retira_conteudos_unitarios(L, [_|Res], Poss):-
	retira_conteudos_unitarios(L, Res, Poss).

%---------------------------------------------------------------------
% inicializa_aux(Puz, Pos, N_Puz):
% N_Puz e o puzzle resultante de colocar na posicao Pos do puzzle Puz
% a lista com os numeros possiveis para essa posicao.
%---------------------------------------------------------------------

inicializa_aux(Puz, Pos, Puz):-
 	puzzle_ref(Puz, Pos, C),
 	length(C, X),
 	X >= 1,!.

inicializa_aux(Puz, Pos, N_Puz):-
	puzzle_ref(Puz, Pos, []),
	possibilidades(Pos, Puz, Poss),
	puzzle_muda_propaga(Puz, Pos, Poss, N_Puz), !.


 %---------------------------------------------------------------------
% inicializa(Puz, N_Puz):
% N_Puz e o puzzle resultante de inicializar o puzzle Puz.
%---------------------------------------------------------------------

inicializa(Puz, N_Puz):-
	todas_posicoes(Todas_Posicoes),
	percorre_muda_Puz(Puz, inicializa_aux, Todas_Posicoes, N_Puz).

%---------------------------------------------------------------------
% so_aparece_uma_vez(Puz, Num, Posicoes, Pos_Num):
% Num so aparece na posicao Pos_Num da lista Posicoes do puzzle Puz.
%---------------------------------------------------------------------

so_aparece_uma_vez(_, _, [], _):- !.

so_aparece_uma_vez(Puz, Num, [P|R], Pos_Num):-
	puzzle_ref(Puz, P, C),
	\+member(Num, C), !,
	so_aparece_uma_vez(Puz, Num, R, Pos_Num).

so_aparece_uma_vez(Puz, Num, [P|R], P):-
	puzzle_ref(Puz,P, C),
	member(Num, C), !,
	so_aparece_uma_vez(Puz, Num, R, P).


%---------------------------------------------------------------------
% inspecciona_num(Posicoes, Puz, Num, N_Puz):
% N_Puz e o resultado de inspeccionar o grupo cujas posicoes sao Posicoes,
% para o numero Num:
% 	se Num so ocorrer numa das posicoes de Posicoes e se o conteudo dessa posicao
% nao for uma lista unitaria, esse conteudo e mudado para [Num] e esta mudanca e
% propagada; caso contrario Puz = N_Puz.
%---------------------------------------------------------------------

inspecciona_num(Posicoes, Puz, Num, N_Puz):-
	so_aparece_uma_vez(Puz, Num, Posicoes, Pos_Num), !,
	puzzle_ref(Puz, Pos_Num, Cont),
	(\+length(Cont,1) -> puzzle_muda_propaga(Puz, Pos_Num, [Num], N_Puz); N_Puz = Puz).

inspecciona_num(_, Puz,_, Puz).

%---------------------------------------------------------------------
% inspecciona_grupo(Puz, Gr, N_Puz):
% N_Puz e o resultado de inspeccionar o grupo cujas posicoes sao as da
% lista Gr, do puzzle Puz para cada um dos numeros possiveis.
%---------------------------------------------------------------------

inspecciona_grupo(Puz, Gr, N_Puz):-
	numeros(L),
	percorre_muda_Puz(Puz,inspecciona_num(Gr),L, N_Puz).

%---------------------------------------------------------------------
% inspecciona(Puz, N_Puz):
% N_Puz resulta de inspeccionar cada um dos grupos do puzzle Puz, para
% cada um dos numeros possiveis.
%---------------------------------------------------------------------

inspecciona(Puz,N_Puz):-
	grupos(Gr),
	percorre_muda_Puz(Puz, inspecciona_grupo, Gr, N_Puz).

%---------------------------------------------------------------------
% grupo_correcto(Puz, Nums, Gr):
% Puz e um puzzle;
% O grupo de Puz cujas posicoes sao as da lista Gr esta correcto, ou seja,
% tem todos os numeros da lista Nums, sem os repetir.
%---------------------------------------------------------------------

grupo_correcto(Puz, Nums, Gr):-
	conteudos_posicoes(Puz, Gr, Conteudos),
	flatten(Conteudos, Conteudo_grupo),
	msort(Conteudo_grupo, Nums).

%---------------------------------------------------------------------
% solucao(Puz):
% Puz e uma solucao, isto e, todos os seus grupos sao correctos (contem
% todos os numeros possiveis sem repeticoes).
% 	Recorre se a um predicado auxiliar (solucao_aux) de modo a verificar
% todos os grupos.
%---------------------------------------------------------------------

solucao(Puz):-
	numeros(Nums),
	grupos(Gr),
	solucao_aux(Puz, Gr, Nums).

%---------------------------------------------------------------------
% 		Predicado auxiliar do predicado solucao
%
% solucao_aux(Puz, Gr, Nums):
% solucao_aux e verdade se todos os grupos de Gr forem correctos.
%---------------------------------------------------------------------

solucao_aux(_, [], _):- !.

solucao_aux(Puz, [P|Res], Nums):-
	grupo_correcto(Puz, Nums, P),
	solucao_aux(Puz, Res, Nums).

%---------------------------------------------------------------------
% resolve(Puz, Sol):
% Sol e o puzzle que e solucao do puzzle Puz.
% E utilizado um predicado auxiliar que encontra a solucao que por sua
% vez recorre a outros dois predicados auxiliares.
%---------------------------------------------------------------------

resolve(Puz, Sol):-
	inicializa(Puz, N_Puz),
	inspecciona(N_Puz, N1_Puz),
    resolve_aux(N1_Puz, Sol).


%---------------------------------------------------------------------
%		Predicado auxiliar do predicado resolve
%
% resolve_aux(Puz, N_Puz):
% N_Puz e o puzzle encontrado candidato a solucao do puzzle Puz.
% Testa se cada elemento do conteudo das posicoes cujo conteudo nao e unitario
% de modo a criar um processo de teste/erro.
% Apos a propagacao, verifica se se e solucao.
%---------------------------------------------------------------------

resolve_aux(Puz, Puz):-
	solucao(Puz), !.

resolve_aux(Puz, N1_Puz):-
	encontrar_posicoes(Puz,Posicoes),
	member(P,Posicoes), !,					% testa cada posicao das posicoes de conteudo nao unitario
	puzzle_ref(Puz, P, Conteudo),
	member(X, Conteudo),					% testa cada elemento do conteudo
	puzzle_muda_propaga(Puz, P, [X], N_Puz),
	resolve_aux(N_Puz, N1_Puz).

%---------------------------------------------------------------------
%		Predicado auxiliar do predicado resolve_aux
%
% encontrar_posicoes(Puz, Posicoes):
% Posicoes e a lista de posicoes cujo conteudo nao e unitario, ou seja,
% sao as posicoes a analisar.
% E utilizado o predicado auxiliar posicoes_a_testar.
%---------------------------------------------------------------------

encontrar_posicoes(Puz, Posicoes):-
	todas_posicoes(T),
	conteudos_posicoes(Puz, T, Conteudos),
    posicoes_a_testar(Puz, Conteudos,T, Posicoes).

%---------------------------------------------------------------------
%		Predicado auxiliar do predicado encontrar_posicoes
%
% posicoes_a_testar(Puz,Conteudos, Posicoes, Posicoes_a_testar):
% Posicoes_a_testar e a lista de posicoes a analisar.
% Atraves da lista de todas as posicoes e da lista de conteudos,
% retiram se todas as posicoes cujo conteudo e uma lista unitaria.
%---------------------------------------------------------------------

posicoes_a_testar(_, [],_,_):-!.

posicoes_a_testar(Puz, [[_|[]]|Res],[_|R], L):-
	posicoes_a_testar(Puz, Res, R, L), !.

posicoes_a_testar(Puz, [Cont|Res],[Pos|R], [Pos|L]):-
	puzzle_ref(Puz, Pos, Cont),
	posicoes_a_testar(Puz, Res, R, L).


write_puzzle([]):-nl.
write_puzzle([Linha|Resto]):-writeln(Linha),write_puzzle(Resto).
