


%[a,b,c]=[T|Q].
%[a,b,c]=[T1,T2|Q].
%[a,b,c]=[T1,T2,T3|Q]. 

% Informations sur les listes 

liste([]).
liste([_|Q]):- liste(Q).

premier(X,[X,_]).

dernier(X,[_,X]).
dernier(X,[_|Q]):-liste(Q),dernier(X,Q).


longueur(0,[]).
longueur(N,[_|Q]):- longueur(M,Q),N is M+1.

dans(X,[T|Q]):-premier(X,[T|Q]);dans(X,Q).

% Manipulation de listes 

conc([],X,X).
conc([T|Q1],X,[T|Q2]):-conc(Q1,X,Q2).

ajouter(X,L,R):-conc(L,[X],R).

supprimer(_,[],[]).
supprimer(X,[X|Q],QT):-supprimer(X,Q,QT).
supprimer(X,[T|Q],[T|QT]):-X\==T,supprimer(X,Q,QT).

sub(_,_,[],[]).
sub(X,Y,[X|Q],[Y|QT]):-sub(X,Y,Q,QT).
sub(X,Y,[T|Q],[T|QT]):-X\==T,sub(X,Y,Q,QT).
