% 2)

route(s,a).
route(s,d).
route(a,b).
route(a,d).
route(b,c).
route(b,e).
route(d,e).

% 3)

voisine(X,Y) :- route(X,Y) ; route(Y,X).

vol(1,bordeaux,paris,1400,1600,200).
vol(2,bordeaux,marseille,1500,1700,150).
vol(3,paris,besancon,1100,1700,50).
vol(4,bordeaux, londres, 1100,1500,400).

% a)
depart(X,N) :- vol(N,X,_,_,_,_).

% b) 
arrive(X,N) :- vol(N,_,X,_,_,_).

% c) 
depart_avant_12h(X,T,N) :- vol(N,X, _,T,_,_),T<1200.

% d)
arriveX_apres_14h(X,T,N) :- vol(N,_,X,_,T,_),T>1400.

% e) 
centP_arrive_17h(X,T,Nu,NP) :- vol(Nu,_,X,_,T,NP),T<1700,NP>100.

% f) 

depart_meme_heure(T,X,Y,N,M) :- vol(N,X,_,T,_,_),vol(M,Y,_,T,_,_), X \== Y, N>M.

% g) 

plus2H(A,D,N) :- vol(N,_,_,D,A,_),(A-D)>200. 

% 4) ARBRE GÉNÉALOGIQUE

% jean est un homme
homme(jean). 
homme(fabien).
homme(jerome).
homme(emile).
homme(franck).
homme(bruno).
homme(marc).

femme(evelyne). % évelyne est une femme
femme(louise).
femme(julie).
femme(anne).
femme(aurelie).
femme(sophie).
femme(marie).
femme(eve).

pere(emile,jean). % émile est le père de jean
pere(jean,fabien).
pere(fabien,eve).
pere(jean,jerome).
pere(bruno,evelyne).
pere(bruno,franck).
pere(franck,sophie).
pere(franck,aurelie).

mere(louise,jean). % louise est la mère de jean
mere(julie,evelyne).
mere(julie,franck).
mere(evelyne,fabien).
mere(evelyne,jerome).
mere(anne,sophie).
mere(anne,aurelie).
mere(marie,eve).
mere(sophie,marc).

parent(X,Y) :- pere(X,Y);mere(X,Y).
fils(X,Y) :- pere(Y,X);mere(Y,X).
grandpere(X,Y) :- pere(X,Z),pere(Z,Y),homme(X).
grandmere(X,Y) :- mere(X,Z),mere(Z,Y),femme(X).
arrieregrandpere(X,Y):-pere(X,E),pere(E,Z),pere(Z,Y),homme(X).
arrieregrandmere(X,Y):- mere(X,E),mere(E,Z),mere(Z,Y),femme(X).
frere(X,Y) :- parent(Z,X),parent(Z,Y),homme(X),homme(Y),X\==Y.
soeur(X,Y):- parent(Z,X),parent(Z,Y),femme(X),femme(Y), X\==Y.
ancetre(X,Y) :- arrieregrandpere(X,Y); arrieregrandmere(X,Y);grandpere(X,Y);grandmere(X,Y);pere(X,Y);mere(X,Y).

%COLORIAGE D'UNE CARTE 

couleur(rouge).
couleur(bleu).
couleur(jaune).
couleur(vert). 

coloriage(C1,C2,C3,C4,C5,C6):- couleur(C1) , couleur(C2) , couleur(C3), couleur(C4) , couleur(C5) , couleur(C6) ,C1 \== C2, C1 \== C3 , C1 \== C5 , C1 \== C6 , C2 \== C3 , C2 \== C4 ,C2 \== C5 , C2 \== C6 , C3 \== C4 , C3 \== C6 , C5 \== C6 .

%PETIT INTERPRÉTEUR PROLOG

regle(patate,vrai).

prolog(vrai).
prolog(But):- regle(But,Cond),prolog(Cond). 
prolog((A,B)):-prolog(A),prolog(B).
prolog((A;_)):-prolog(A).
prolog((_;B)):-prolog(B).


%ENTIERS NATURELS 



%Génération 
entier(z).
entier(s(X)):-entier(X).

%Addition 

plus(z,z,z).
plus(X,z,X):-entier(X).
plus(X,s(Y),s(R)):- entier(X),entier(Y), plus(X,Y,R).

%Multiplication

%% multi(z,z,z).
%% multi(X,s(z),X):-entier(X).
%% multi(z,X,X):-entier(X).
%% multi(X,s(Y),s(R)):- entier(X), entier(Y).

%Inférieur ou égal 

infeg(z,X):-entier(X). 
infeg(X,X):- entier(X),!. % coupe choix, une fois qu'il vérifie un truc grace à cette règle, il coupe toutes les solutions restantes et s'arrête.
infeg(X,s(Y)):-entier(X),entier(s(Y)),infeg(X,Y).

%Strictement inférieur 

inf(z,X):- entier(X).
inf(X,s(X)).
inf(X,s(Y)):-entier(X), 
			 entier(s(Y)),
			 inf(X,Y).

%Arithmétique 

%Suite factorielle 

facto(0,1).
facto(Rang,Res):- Rang2 is (Rang-1),
				  facto(Rang2,Res2),
				  Res is Res2*Rang,
				  !.

%Fibonacci 

fibo(0,1).
fibo(1,1).
fibo(Rang, Res):- Rang2 is (Rang-1),
				  Rang3 is (Rang-2),
				  fibo(Rang2, Res2), 
				  fibo(Rang3, Res3), 
				  Res is Res3 + Res2,
				  !.

% Arbres binaires 

%bt([],5,bt([],4;[])).

arbreBinaire([]).
arbreBinaire(bt(G,_,D)):-arbreBinaire(G),
						 arbreBinaire(D).

dansArbre(X,bt(_,X,_)).
dansArbre(X,bt(G,_,D)):- dansArbre(X,G);
						 dansArbre(X,D).


maximum(X, Y, X):- X>Y,!.
maximum(_,Y,Y).

profondeur([],0).
profondeur(bt(G,_,D),N):-
						 profondeur(G,N1),
						 profondeur(D,N2),
						 arbreBinaire(G),
						 arbreBinaire(D),
						 N is max(N1,N2)+1. 

% Termes de base 

sub(A,_,T,T):- T \== A, atomic(T). 
sub(A,B,A,B):- atomic(A). 

sub(A,B,T,NT):- functor(T,F,AR),
				functor(NT,F,AR),
				aubArg(A,B,T,NT,AR).


subArg(_,_,_,_,0).

subArg(A,B,T,NT,AR):-AR>0,
					 arg(AR,T,ARG),
					 sub(A,R,ARG,NARG), %NARG : Nouvel argument
					 arg(AR,NT,NARG),
					 PR is AR-1, %PR : Prochain rang
					 subst(A,B,T,NT,PR). 







