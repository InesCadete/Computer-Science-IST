


% try(L1,L2) :- try(L1,[],L2).

% try([], Acc,Acc).

% %se o caminho esta livre a lista de vizinhas nao muda
% try([Cab|Resto], Acc, L2) :-
%     Cab == 1,
%     try(Resto,Acc,L2).

% %se nao estiver, eliminar vizinha da lista de vizinhas
% try([Cab|Resto], Acc, L2) :-
%     not(Cab == 1),
%     NovoAcc is Resto,
%     try(Resto,NovoAcc, L2).



% %_--------------------------------------------------------------------

% % testes([somaMaria(1, 1, 2), somaFrancisco(2, 1, 3), somaManuel(2,4, 6)], mysoma1).
% % true % ou seja, quero ver se se verifica mysoma(1, 1, 2), mysoma(2, 1, 3), etc.

% testes([H|T], Pred):-
%     H =.. [_|Args],
%     L =.. [Pred|Args],
%     call(L),
%     testes(T, Pred).

% %----------------------------------------------------------------------------------------------
% %aplicar dois maplists sucessivamente




%2.16 Predicado junta_pontes/5

%2.16 Predicado junta_pontes/5

%funcao auxiliar que procura dentro do estado e se a ilha de cada entrada for ilha1 ou ilha2 adiciona pontes
adiciona_pontes_estado(Estado, Num_pontes, ilha(N_pontes1,(X1,Y1)), ilha(N_pontes2, (X2,Y2)), Novo_estado) :-
    adiciona_pontes_estado(Estado, Num_pontes, ilha(N_pontes1,(X1,Y1)), ilha(N_pontes2, (X2,Y2)), [], Novo_estado).

adiciona_pontes_estado([], 0, _,_, Estado_Acc, Estado_Acc).

%caso seja a ilha1
adiciona_pontes_estado([[ilha(N_pontes,(X,Y)),Vizinhas, Pontes]|Resto], Num_pontes, ilha(N_pontes1,(X1,Y1)), ilha(N_pontes2, (X2,Y2)),  Estado_Acc, Novo_estado) :-
    Num_pontes > 0,
    [ilha(N_pontes,(X,Y)),Vizinhas, Pontes] == [ilha(N_pontes1,(X1,Y1)),Vizinhas, Pontes],
    cria_ponte((X1,Y1), (X2,Y2), Ponte),
    append(Pontes, [Ponte], Pontes_final),
    %ate Num_pontes_acc == Num_pontes, Num_pontes_acc aumenta
    Novo_Num_pontes is Num_pontes - 1,
    append(Estado_Acc, [ilha(N_pontes1,(X1,Y1)),Vizinhas, Pontes_final], Novo_Estado_Acc),
    adiciona_pontes_estado(Resto, Novo_Num_pontes,ilha(N_pontes1,(X1,Y1)), ilha(N_pontes2, (X2,Y2)),  Novo_Estado_Acc, Novo_estado).

%caso seja a ilha2
adiciona_pontes_estado([[ilha(N_pontes,(X,Y)),Vizinhas, Pontes]|Resto], Num_pontes, ilha(N_pontes1,(X1,Y1)), ilha(N_pontes2, (X2,Y2)),  Estado_Acc, Novo_estado) :-
    Num_pontes > 0,
    [ilha(N_pontes,(X,Y)),Vizinhas, Pontes] == [ilha(N_pontes2,(X2,Y2)),Vizinhas, Pontes],
    cria_ponte((X1,Y1), (X2,Y2), Ponte),
    append(Pontes, [Ponte], Pontes_final),
    Novo_Num_pontes is Num_pontes - 1,
    append(Estado_Acc, [ilha(N_pontes2,(X2,Y2)),Vizinhas, Pontes_final], Novo_Estado_Acc),
    adiciona_pontes_estado(Resto, Novo_Num_pontes, ilha(N_pontes1,(X1,Y1)), ilha(N_pontes2, (X2,Y2)),  Novo_Estado_Acc, Novo_estado).

%caso ja tenha adicionado as pontes, apenas adicionar a entrada sem mudar pontes
adiciona_pontes_estado([Cab|Resto], Num_pontes, ilha(N_pontes1,(X1,Y1)), ilha(N_pontes2, (X2,Y2)),  Estado_Acc, Novo_estado) :-
    append(Estado_Acc, [Cab], Novo_Estado_Acc),
    adiciona_pontes_estado(Resto, Num_pontes, ilha(N_pontes1,(X1,Y1)), ilha(N_pontes2, (X2,Y2)),  Estado_Acc, Novo_estado).

junta_pontes(Estado, Num_pontes, ilha(N_pontes1,(X1,Y1)), ilha(N_pontes2, (X2,Y2)), Novo_estado) :-
    adiciona_pontes_estado(Estado, Num_pontes, ilha(N_pontes1,(X1,Y1)), ilha(N_pontes2, (X2,Y2)), Novo_estado1),
    %actualiza o estado por alicacao dos predicados actualiza_vizinhas_apos_pontes
    actualiza_vizinhas_apos_pontes(Novo_estado1, (X1,Y1), (X2,Y2), Novo_estado2),
    %trata_ilhas_terminadas
    trata_ilhas_terminadas(Novo_estado2, Novo_estado).


%----------------------------------------------------------------------------------------------------------------------------

%2.16 Predicado junta_pontes/5

%funcao auxiliar que procura dentro do estado e se a ilha de cada entrada for ilha1 ou ilha2 adiciona pontes
adiciona_pontes_estado(Estado, Num_pontes, ilha(N_pontes1,(X1,Y1)), ilha(N_pontes2, (X2,Y2)), Novo_estado) :-
    adiciona_pontes_estado(Estado, Num_pontes, ilha(N_pontes1,(X1,Y1)), ilha(N_pontes2, (X2,Y2)), [], Novo_estado).
%diminuir o Num_pontes quando se cria uma ponte- chega ate 0
adiciona_pontes_estado([], _, _,_, Estado_Acc, Estado_Acc).

%caso seja a ilha1 ou ilha2 
adiciona_pontes_estado([[ilha(N_pontes,(X,Y)),Vizinhas, Pontes]|Resto], Num_pontes, ilha(N_pontes1,(X1,Y1)), ilha(N_pontes2, (X2,Y2)),  Estado_Acc, Novo_estado) :-
    Num_pontes == 1,
    ([ilha(N_pontes,(X,Y)),Vizinhas, Pontes] == [ilha(N_pontes1,(X1,Y1)),Vizinhas, Pontes];
    [ilha(N_pontes,(X,Y)),Vizinhas, Pontes] == [ilha(N_pontes2,(X2,Y2)),Vizinhas, Pontes]),
    cria_ponte((X1,Y1), (X2,Y2), Ponte),
    append(Pontes, [Ponte], Pontes_final),
    append(Estado_Acc, [ilha(N_pontes,(X,Y)),Vizinhas, Pontes_final], Novo_Estado_Acc),
    adiciona_pontes_estado(Resto, Num_pontes,ilha(N_pontes1,(X1,Y1)), ilha(N_pontes2, (X2,Y2)),  Novo_Estado_Acc, Novo_estado).

%caso Num_pontes seja 2
adiciona_pontes_estado([[ilha(N_pontes,(X,Y)),Vizinhas, Pontes]|Resto], Num_pontes, ilha(N_pontes1,(X1,Y1)), ilha(N_pontes2, (X2,Y2)),  Estado_Acc, Novo_estado) :-
    Num_pontes == 2,
    ([ilha(N_pontes,(X,Y)),Vizinhas, Pontes] == [ilha(N_pontes1,(X1,Y1)),Vizinhas, Pontes];
    [ilha(N_pontes,(X,Y)),Vizinhas, Pontes] == [ilha(N_pontes2,(X2,Y2)),Vizinhas, Pontes]),
    cria_ponte((X1,Y1), (X2,Y2), Ponte),
    append(Pontes, [Ponte, Ponte], Pontes_final),
    append(Estado_Acc, [ilha(N_pontes,(X,Y)),Vizinhas, Pontes_final], Novo_Estado_Acc),
    adiciona_pontes_estado(Resto, Num_pontes,ilha(N_pontes1,(X1,Y1)), ilha(N_pontes2, (X2,Y2)),  Novo_Estado_Acc, Novo_estado).

%caso ja tenha adicionado as pontes, apenas adicionar a entrada sem mudar pontes
adiciona_pontes_estado([Cab|Resto], Num_pontes, ilha(N_pontes1,(X1,Y1)), ilha(N_pontes2, (X2,Y2)),  Estado_Acc, Novo_estado) :-
    append(Estado_Acc, [Cab], Novo_Estado_Acc),
    adiciona_pontes_estado(Resto, Num_pontes, ilha(N_pontes1,(X1,Y1)), ilha(N_pontes2, (X2,Y2)),  Novo_Estado_Acc, Novo_estado).

junta_pontes(Estado, Num_pontes, ilha(N_pontes1,(X1,Y1)), ilha(N_pontes2, (X2,Y2)), Novo_estado) :-
    adiciona_pontes_estado(Estado, Num_pontes, ilha(N_pontes1,(X1,Y1)), ilha(N_pontes2, (X2,Y2)), Novo_estado1),
    %actualiza o estado por alicacao dos predicados actualiza_vizinhas_apos_pontes
    actualiza_vizinhas_apos_pontes(Novo_estado1, (X1,Y1), (X2,Y2), Novo_estado2),
    %trata_ilhas_terminadas
    trata_ilhas_terminadas(Novo_estado2, Novo_estado).