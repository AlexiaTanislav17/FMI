
liste_puncte([],_,[]).
liste_puncte([H|T],V,Lrez):- liste_puncte(T,V,Rtemp), H = punct(_,B), B > V , Lrez = [H|Rtemp].
liste_puncte([H|T],V,Lrez):- liste_puncte(T,V,Rtemp), H = punct(_,B), B =< V , Lrez = Rtemp.

reverse([],X).
reverse([H|T],X):- reverse(T,[H|X]).
palindrom(L):- reverse(L,L).