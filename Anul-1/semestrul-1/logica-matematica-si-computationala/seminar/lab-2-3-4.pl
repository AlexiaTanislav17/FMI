distance((X1, Y1), (X2, Y2), D) :- D is sqrt((X1-X2)**2+(Y1-Y2)**2).
distance2((X1, Y1), (X2, Y2), D) :- D = sqrt((X1-X2)**2+(Y1-Y2)**2).
distance3((X1, Y1), (X2, Y2), D) :- D =:= sqrt((X1-X2)**2+(Y1-Y2)**2).

fib(0, 0, 1).
fib(1, 1, 1).
fib(N, Z, X) :- 2 =< N, M is N - 1, fib(M, Y, Z), P is N-2, fib(P, Y, Z), X is Y + Z.

fibg(N, X) :- fib(N, _, X). 

linie(0, _).
linie(N, C) :- N>0, write(C), X is N - 1, linie(X, C).
rectangle(0, _, _) :- n1.
rectangle(X, Z, C) :- X>0, Y is X - 1, linie(Z, C), n1, rectangle(Y, Z, C).
square(X, C) :- rectangle(X, X, C).


element_of(X,[X|_]).
element_of(X,[_|Tail]) :- element_of(X,Tail).


concat_lists([],List,List).
concat_lists([Elem|List1], List2, [Elem | List3]):- concat_lists(List1, List2, List3). 

all_a([a]).
all_a([a|X]):-all_a(X).

all_a2([a]).
all_a2([E|List]):-all_a(List), E==a.

trans_a_b([],[]).
trans_a_b([E1|List1],[E2|List2]):- trans_a_b(List1,List2),E1==a,E2==b.
egale(X,Y):- length(X,L1), length(Y,L2), L1==L2

scalarMult(_,[],[]).
scalarMult(Sc,[E1|L1],[Ce1|Lrez]):- Ce1 is Sc*E1, scalarMult(Sc,L1,Lrez).


dot([],[],0).
dot([E1|List1],[E2|List2],R):-dot(List1,List2,RezPart), R is RezPart+E1*E2.

liste_puncte([],_,[]).
liste_puncte([H|T],V,Lrez):- liste_puncte(T,V,Rtemp), H = punct(_,B), B > V , Lrez = [H|Rtemp].
liste_puncte([H|T],V,Lrez):- liste_puncte(T,V,Rtemp), H = punct(_,B), B =< V , Lrez = Rtemp.

reverse([],X).
reverse([H|T],X):- reverse(T,[H|X]).
palindrom(L):- reverse(L,L).