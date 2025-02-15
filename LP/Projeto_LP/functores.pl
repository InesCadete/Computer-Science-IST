% functores

%como a stora tinha feito

% pos_para_um_lado_neg_para_outro(L, Pos, Neg) :-
%     T =.. [separa, L, Pos, Neg], call(T).

%7.17.1
substitui_f(T_c, Novo_F, Novo_T_c) :-
    T_c =.. [_|T], 
    Novo_T_c =.. [Novo_F|T].

%7.17.2

substitui_arg(T_c, Arg, Novo_Arg, Novo_T_c) :-
    T_c =.. [H|T],
    maplist(subst(Arg,Novo_Arg), T_c,Nova_lista),
    Novo_T_c =.. [H|Nova_lista].


subst(Arg,_,El,El) :-
    El \== Arg.

subst(Arg,NovoArg,El,NovoArg) :-
    El == Arg.

%7.17.3.

% todos(Pred, Lst)

todos(Pred,Lst) :-
    maplist(Pred, Lst).

% algum(Pred, Lst) :-
%     not(maplist(not(Pred),Lst))).

par(X) :- X mod 2 == 0.

algum(Pred, [H|T]) :-
    L =.. [Pred,H], call(L).

algum(Pred, [H|T]) :-
    L =.. [Pred,H], not(call(L)),
    algum(Pred, T).

%7.17.5
%recursiva
quantos(_, [], 0):- !.
quantos(Pred,[H|T], N):-
    quantos(Pred, T,Ntem),
    L =.. [Pred, H],
    (call(L), N is Ntem + 1, !; N is Ntem).
    

%iterativa

quantos_it(Pred, L, N):-
    quantos_it(Pred, L, N, 0).

%base de recursao

quantos_it(_,[], Aux, Aux) :- !.

%Head unifica Pred

quantos_it(Pred, [Head|Tail], Rei, Aux) :-
    L =.. [Pred|Head],
    call(L), !,
    NewAux is Aux + 1,
    quantos_it(Pred, Tail, Rei, NewAux).

quantos_it(Pred, [_|Tail], Rei, Aux) :- 
    quantos(Pred, Tail, Rei, Aux).

%my_quantos(Pred,List, N) :-

my_quantos(Pred,List, N) :-
    findall(E, (member(E,List),
    L =.. [Pred|E],
    call(L)), Aux),
    length((Aux), N).
    

%outra forma

quantos1(Pred, Lst, N) :- 
    include(Lst2, N).


