%:- [codigo_comum, puzzles_publicos].


%projeto lp
%LEIC- Ines Cadete (ist1102935)
%-------------------------------------------------------------------------------------------------------
%2.1 Predicado extrai_ilhas_linha/3
%novos argumentos acumuladores de numero de colunas e das ilhas
extrai_ilhas_linha(N_L, Linha, Ilhas) :- extrai_ilhas_linha(N_L, Linha, 1, [], Ilhas).

extrai_ilhas_linha(_, [], _, Ilhas, Ilhas).

extrai_ilhas_linha(N_L, [P|R], Coluna, Acc, Ilhas) :-
    %todos os elementos da lista diferentes de 0 sao ilhas
    P > 0,
    append(Acc, [ilha(P, (N_L, Coluna))], NovoAcc),
    %aumentar sempre o index da coluna
    NovoCol is Coluna + 1,
    extrai_ilhas_linha(N_L, R, NovoCol, NovoAcc, Ilhas).

extrai_ilhas_linha(N_L, [_|R], Coluna, Acc, Ilhas) :-
    NovoCol is Coluna + 1,
    extrai_ilhas_linha(N_L, R, NovoCol, Acc, Ilhas).
%-------------------------------------------------------------------------------------------------------
% 2.2 Predicado ilhas/2

%novo argumento acumulador das ilhas
ilhas(Puz, Ilhas) :- ilhas(Puz, 1, [],Ilhas).

ilhas([], _, Acc, Acc).

ilhas([P|R], Lin, Acc, Ilhas) :- 
    extrai_ilhas_linha(Lin, P, Ilha),
    append(Acc, Ilha, NovoAcc),
    NovoLin is Lin + 1,
    ilhas(R, NovoLin, NovoAcc, Ilhas).
%-------------------------------------------------------------------------------------------------------
% 2.3 Predicado vizinhas/3

x_maior(ilha(_,(X,Y)), ilha(_, (X1,Y1))) :-
    Y1 == Y, X1 > X.

x_menor(ilha(_,(X,Y)), ilha(_, (X1,Y1))) :-
    Y1 == Y, X1 < X.

y_maior(ilha(_,(X,Y)), ilha(_, (X1,Y1))) :-
    X1 == X, Y1 > Y.

y_menor(ilha(_,(X,Y)), ilha(_, (X1,Y1))) :-
    X1 == X, Y1 < Y.

%prim sera a primeira ilha da lista
primeira([Cab|_], Prim) :-
    Prim = Cab.

%Ult sera a ultima ilha da lista
ultima(L1,Ult) :-
    reverse(L1,[Cab|_]),
    Ult = Cab.
    
%filtrar por vizinhas que estao na mesma linha e depois coluna
% e pelas que tem y maior, as de y menor, as de x maior e as de x menor
vizinhas(Ilhas, ilha(Ponte,(X,Y)) , Vizinhas) :- 
    Vizinhas1 = [],
    include(x_maior(ilha(Ponte,(X,Y))), Ilhas, Vizs_x_maior),
    include(x_menor(ilha(Ponte,(X,Y))), Ilhas, Vizs_x_menor),
    include(y_maior(ilha(Ponte,(X,Y))), Ilhas, Vizs_y_maior),
    include(y_menor(ilha(Ponte,(X,Y))), Ilhas, Vizs_y_menor),
    %adicionar so a ilha mais proxima com os predicados primeira e ultima
    %dentro de cada lista de vizinhas acima, a esquerda, abaixo e a direita
    (Vizs_x_menor \== [] ->
    ultima(Vizs_x_menor,Viz1),
    append(Vizinhas1,[Viz1],Vizinhas2);
    append(Vizinhas1,[], Vizinhas2)),


    (Vizs_y_menor \== [] -> 
    ultima(Vizs_y_menor,Viz2),
    append(Vizinhas2,[Viz2], Vizinhas3);
    append(Vizinhas2,[], Vizinhas3)),


    (Vizs_y_maior \== [] ->
    primeira(Vizs_y_maior,Viz3),
    append(Vizinhas3,[Viz3],Vizinhas4);
    append(Vizinhas3,[], Vizinhas4)),

    (Vizs_x_maior \== [] ->
    primeira(Vizs_x_maior,Viz4),
    append(Vizinhas4,[Viz4],Vizinhas);
    append(Vizinhas4,[], Vizinhas)). 
%-------------------------------------------------------------------------------------------------------
% 2.4 Predicado estado/2

%guardar a lista de Ilhas para que nao diminua com a iteracao seguinte
%acrescentar um argumento que guarda o estado
estado(Ilhas, Estado):- estado(Ilhas,Ilhas, [], Estado).

estado([],_,Estado1, Estado1).

estado([Cab|Resto], Ilhas,Estado1, Estado):-
    vizinhas(Ilhas,Cab, Vizinhas),
    append(Estado1,[[Cab, Vizinhas, []]], Estado2),
    estado(Resto,Ilhas, Estado2, Estado).
%-------------------------------------------------------------------------------------------------------
% 2.5 Predicado posicoes_entre/3

%se linha e igual
posicoes_entre((X1,Y1), (X2,Y2), Posicoes) :-
    X1 = X2,
    Y2 > Y1,
    NovoY1 is Y1 + 1, %excluir extremos
    NovoY2 is Y2 - 1,
    setof((X1,YP),between(NovoY1, NovoY2 , YP), Posicoes).

posicoes_entre((X1,Y1), (X2,Y2), Posicoes) :-
    X1 = X2,
    Y1 > Y2,
    NovoY1 is Y1 - 1, 
    NovoY2 is Y2 + 1,
    setof((X1,YP),between(NovoY2, NovoY1 , YP), Posicoes).

%se coluna e igual
posicoes_entre((X1,Y1), (X2,Y2), Posicoes) :-
    Y1 = Y2,
    X2 > X1,
    NovoX1 is X1 + 1,
    NovoX2 is X2 - 1,
    setof((XP,Y1),between(NovoX1, NovoX2 , XP), Posicoes).

posicoes_entre((X1,Y1), (X2,Y2), Posicoes) :-
    Y1 = Y2,
    X1 > X2,
    NovoX1 is X1 - 1,
    NovoX2 is X2 + 1,
    setof((XP,Y1),between(NovoX2, NovoX1 , XP), Posicoes).
%-------------------------------------------------------------------------------------------------------
% 2.6 Predicado cria_ponte/
 
%se x for igual
cria_ponte((X1,Y1), (X2,Y2), Ponte) :-
    X1 == X2,
    Y2 > Y1, 
    Ponte = ponte((X1,Y1), (X2,Y2)).
     
cria_ponte((X1,Y1), (X2,Y2), Ponte) :-  
    X1 == X2, 
    Y1 > Y2,
    Ponte = ponte((X2,Y2), (X1,Y1)).

%se y for igual
cria_ponte((X1,Y1), (X2,Y2), Ponte) :-
    Y1 == Y2,
    X2 > X1,
    Ponte = ponte((X1,Y1), (X2,Y2)).
      
cria_ponte((X1,Y1), (X2,Y2), Ponte) :-   
    Y1 == Y2,
    X1 > X2,
    Ponte = ponte((X2,Y2), (X1,Y1)).
%-------------------------------------------------------------------------------------------------------
%2.7- caminho_livre/5

disjuntas(L1,L2) :-
    findall(El, (member(El, L1), member(El, L2)), Saco),
    Saco ==  [].

caminho_livre(Pos1, Pos2, Posicoes, ilha(_,(X1,Y1)), ilha(_,(X2,Y2))) :-
    posicoes_entre((X1,Y1),(X2,Y2), Posicoes1),
    %caso a ponte seja entre as duas ilhas
    ([Pos1, Pos2] == [(X1,Y1), (X2,Y2)];
    [Pos1, Pos2] == [(X2,Y2), (X1,Y1)];
    %caso para nao ser uma ponte perpendicular a linha entre as duas ilhas
    disjuntas(Posicoes, Posicoes1)).
%-------------------------------------------------------------------------------------------------------
%2.8 Predicado actualiza_vizinhas_entrada/5

actualiza_vizinhas_entrada(Pos1, Pos2, Posicoes, Entrada, Nova_Entrada) :- 
    actualiza_vizinhas_entrada(Pos1, Pos2, Posicoes, Entrada, [], Nova_Entrada).

actualiza_vizinhas_entrada(_, _, _, [Ilha, [], Pontes],Acc, [Ilha, Acc, Pontes]).

%se o caminho esta livre a lista de vizinhas nao muda
%adiciona ao acumulador a vizinha, pois permanece vizinha
actualiza_vizinhas_entrada(Pos1, Pos2, Posicoes, [Ilha, [Cab|Resto],Pontes],Acc, Nova_Entrada) :-
    caminho_livre(Pos1, Pos2, Posicoes, Ilha, Cab),
    append(Acc,[Cab],NovoAcc),
    actualiza_vizinhas_entrada(Pos1, Pos2, Posicoes, [Ilha, Resto,Pontes],
    NovoAcc, Nova_Entrada).

%se nao estiver caminho livre, nao adiciona
actualiza_vizinhas_entrada(Pos1, Pos2, Posicoes, [Ilha, [Cab|Resto],Pontes], Acc, Nova_Entrada) :-
    not(caminho_livre(Pos1, Pos2, Posicoes, Ilha, Cab)),
    actualiza_vizinhas_entrada(Pos1, Pos2, Posicoes, [Ilha, Resto,Pontes],
    Acc, Nova_Entrada).
%-------------------------------------------------------------------------------------------------------
%2.9 Predicado actualiza_vizinhas_apos_pontes/4

actualiza_vizinhas_apos_pontes(Estado, Pos1, Pos2, Novo_estado) :-
    posicoes_entre(Pos1, Pos2, Posicoes),
    maplist(actualiza_vizinhas_entrada(Pos1, Pos2, Posicoes),Estado, Novo_estado).

%-------------------------------------------------------------------------------------------------------
%2.10 Predicado ilhas_terminadas/2

ilhas_terminadas([[ilha(N_pontes,Pos), _, Pontes]|Resto], Ilhas_term) :-
    ilhas_terminadas([[ilha(N_pontes,Pos), _, Pontes]|Resto], [], Ilhas_term).

ilhas_terminadas([], Acc, Acc).

ilhas_terminadas([[ilha(N_pontes,Pos), _, Pontes]|Resto], Acc, Ilhas_term) :-
    N_pontes \== 'X',
    length(Pontes,N_pontes),
    append(Acc,[ilha(N_pontes,Pos)], NovoAcc),
    ilhas_terminadas(Resto,NovoAcc, Ilhas_term).

ilhas_terminadas([[ilha(_,_), _, _]|Resto], Acc, Ilhas_term) :-
    ilhas_terminadas(Resto,Acc, Ilhas_term).
%-------------------------------------------------------------------------------------------------------
%2.11 Predicado tira_ilhas_terminadas_entrada/3

tira_ilhas_terminadas_entrada(Ilhas_term, [ilha(N_pontes,Pos),
    [Cab|Resto], Pontes], Nova_entrada) :-
    tira_ilhas_terminadas_entrada(Ilhas_term, [ilha(N_pontes,Pos),
    [Cab|Resto], Pontes], [], Nova_entrada).

tira_ilhas_terminadas_entrada(_, [ilha(N_pontes,Pos), [], Pontes], Acc, [ilha(N_pontes,Pos), Acc, Pontes]).

%manipula a lista de vizinhas, verificando se cada elemento e ilha terminada
tira_ilhas_terminadas_entrada(Ilhas_term, [ilha(N_pontes,Pos),
 [Cab|Resto], Pontes], Acc, Nova_entrada) :-
    not(member(Cab, Ilhas_term)),
    append(Acc,[Cab], NovoAcc),
    tira_ilhas_terminadas_entrada(Ilhas_term, [ilha(N_pontes,Pos),
    Resto, Pontes], NovoAcc, Nova_entrada).

tira_ilhas_terminadas_entrada(Ilhas_term, [ilha(N_pontes,Pos),[Cab|Resto], Pontes], Acc, Nova_entrada) :-
    member(Cab, Ilhas_term),
    tira_ilhas_terminadas_entrada(Ilhas_term, [ilha(N_pontes,Pos),
    Resto, Pontes], Acc, Nova_entrada).
%-------------------------------------------------------------------------------------------------------
%2.12 Predicado tira_ilhas_terminadas/3

tira_ilhas_terminadas(Estado, Ilhas_term, Novo_estado) :-
    maplist(tira_ilhas_terminadas_entrada(Ilhas_term), Estado, Novo_estado).
%-------------------------------------------------------------------------------------------------------
%2.13 Predicado marca_ilhas_terminadas_entrada/3

%se a ilha de Entrada pertencer a Ilhas_term, substitui N_pontes por "X"
marca_ilhas_terminadas_entrada(Ilhas_term,[ilha(N_pontes,Pos),Vizinhas, Pontes], Nova_entrada) :-
    member(ilha(N_pontes, Pos), Ilhas_term),
    Nova_entrada = [ilha('X',Pos),Vizinhas, Pontes].
%caso contrario, fica igual a entrada
marca_ilhas_terminadas_entrada(Ilhas_term,[ilha(N_pontes,Pos),Vizinhas, Pontes], Nova_entrada) :-
    not(member(ilha(N_pontes, Pos), Ilhas_term)),
    Nova_entrada = [ilha(N_pontes,Pos),Vizinhas, Pontes].
%-------------------------------------------------------------------------------------------------------
%2.14 Predicado marca_ilhas_terminadas/3

marca_ilhas_terminadas(Estado, Ilhas_term, Novo_estado) :- 
    maplist(marca_ilhas_terminadas_entrada(Ilhas_term), Estado, Novo_estado).
%-------------------------------------------------------------------------------------------------------
%2.15 Predicado trata_ilhas_terminadas/2

trata_ilhas_terminadas(Estado, Novo_estado) :-
    ilhas_terminadas(Estado, Ilhas_term),
    tira_ilhas_terminadas(Estado,Ilhas_term, Novo_estado1),
    marca_ilhas_terminadas(Novo_estado1, Ilhas_term, Novo_estado).
%-------------------------------------------------------------------------------------------------------
%2.16 Predicado junta_pontes/5

%funcao auxiliar que adiciona pontes a lista Pontes
%Num_pontes == 1
adiciona_pontes_entrada(Num_pontes, ilha(N_pontes1,(X1,Y1)), ilha(N_pontes2,(X2,Y2)),[ilha(N_pontes,(X,Y)), Vizinhas, Pontes], Nova_Entrada) :- 
    Num_pontes == 1,
    (ilha(N_pontes,(X,Y)) == ilha(N_pontes1,(X1,Y1));
    ilha(N_pontes,(X,Y)) == ilha(N_pontes2,(X2,Y2))),
    cria_ponte((X1,Y1),(X2,Y2), Ponte),
    append(Pontes, [Ponte], Pontes_final),
    Nova_Entrada = [ilha(N_pontes,(X,Y)),Vizinhas, Pontes_final].

%Num_pontes == 2
adiciona_pontes_entrada(Num_pontes, ilha(N_pontes1,(X1,Y1)), ilha(N_pontes2,(X2,Y2)),[ilha(N_pontes,(X,Y)), Vizinhas, Pontes], Nova_Entrada) :- 
    Num_pontes == 2,
    (ilha(N_pontes,(X,Y)) == ilha(N_pontes1,(X1,Y1));
    ilha(N_pontes,(X,Y)) == ilha(N_pontes2,(X2,Y2))),
    cria_ponte((X1,Y1),(X2,Y2), Ponte),
    append(Pontes, [Ponte, Ponte], Pontes_final),
    Nova_Entrada = [ilha(N_pontes,(X,Y)),Vizinhas, Pontes_final].

adiciona_pontes_entrada(_, _, _,[ilha(N_pontes,(X,Y)), Vizinhas, Pontes], Nova_Entrada) :- 
    Nova_Entrada = [ilha(N_pontes,(X,Y)), Vizinhas, Pontes].


junta_pontes(Estado, Num_pontes, ilha(N_pontes1,(X1,Y1)), ilha(N_pontes2, (X2,Y2)), Novo_estado) :-
    maplist(adiciona_pontes_entrada(Num_pontes, ilha(N_pontes1,(X1,Y1)), ilha(N_pontes2,(X2,Y2))), Estado, Estado1),
    %actualiza o estado por alicacao dos predicados actualiza_vizinhas_apos_pontes
    actualiza_vizinhas_apos_pontes(Estado1, (X1,Y1), (X2,Y2), Estado2),
    %trata_ilhas_terminadas
    trata_ilhas_terminadas(Estado2, Novo_estado).