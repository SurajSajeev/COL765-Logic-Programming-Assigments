%*******************************************************************************************************************

%                                                         ILFP ASSIGNMENT
%							      COL 765
%							    2018MCS2024

%*******************************************************************************************************************
%                                                        DIRECTIONS FOR USE
%1. Run interpreter command after consulting.
%
:-op(100,fy,-),op(200,yfx,*),op(300,yfx,+),op(400,yfx,<),op(500,yfx,=).

resolution(A,A1):-nnf(A*(-A1),C),cnf1(C,B),!,convertcnftolist(B,Temp),convertcnflisttoll(Temp,List),preprocess(List,List2),print(List2),unionall(List2,List1),nl,print(List1),findnegate(List1,List5),resolveAllClauses(List2,Res),printtheres(Res,List5).
subset([], _).
subset([X|Tail], Y):-
  select(X, Y, Z),
  subset(Tail, Z).
printtheres([],_):-format("~nEncountered the [] list therefore the expression is logical consequence.~nTRUE"),!.
printtheres(List,List1):-subset(List,List1),format("~nEncountered the [] list therefore the expression is logical consequence.~nTRUE"),!.
printtheres(List,_):-format("~nThe list has following elements "),write(List),format(" Therefore it is not a logical conseqence.~nFALSE").
entercons(A):-write(" Enter the goal in the form of Formulae : "), nl, 
				read(A).

nnf(A,C):-nnfr(A,B),nnfpush(B,C).

nnfr(-A,-B):-!,nnfr(A,B).
nnfr(A*B,C*D):-!,nnfr(A,C),nnfr(B,D).
nnfr(A+B,C+D):-!,nnfr(A,C),nnfr(B,D).
nnfr(A<B,-C+D):-!,nnfr(A,C),nnfr(B,D).
nnfr(A=B,(-C+D)*(C+(-D))):-!,nnfr(A,C),nnfr(B,D).
nnfr(A,A).


nnfpush(-(-A),B):-!,nnfpush(A,B).
nnfpush(-(A*B),C+D):-!,nnfpush(-A,C),nnfpush(-B,D).
nnfpush(-(A+B),C*D):-!,nnfpush(-A,C),nnfpush(-B,D).
nnfpush(A+B,C+D):-!,nnfpush(A,C),nnfpush(B,D).
nnfpush(A*B,C*D):-!,nnfpush(A,C),nnfpush(B,D).
nnfpush(A,A).







cnf1(A*B,C*D):-cnf1(A,C),cnf1(B,D),!.
cnf1(A+B,C):-!,cnf1(A,Y),cnf1(B,Z),distribute(Y+Z,F,Flag),(Flag->cnf1(F,C);C=F).
cnf1(X,X).


distribute((X * Y) + Z, 
            (X + Z) * (Y + Z),true) :- !.
distribute(X + (Y * Z),
             (X + Y) * (X + Z),true) :- !.
distribute(X,X,fail).

convertcnftolist(A*B,Res):-convertcnftolist(A,Temp1),convertcnftolist(B,Temp2),append(Temp1,Temp2,Res),!.
convertcnftolist(A,[A]).

convertcnflisttoll([Head|Tail],Res):-convertlist(Head,Listitem),convertcnflisttoll(Tail,Temp),append([Listitem],Temp,Res).
convertcnflisttoll([],[]).

convertlist(A+B,Res):-convertlist(A,Temp1),convertlist(B,Temp2),append(Temp1,Temp2,Res),!.
convertlist(A,[A]).

union(X,Y,Z):-union(X,Y,[],Z).
union([],[],Z,Z).
union([H|T],Y,Z,A):-member(H,Z),!,union(T,Y,Z,A).
union([H|T],Y,Z,A):-union(T,Y,[H|Z],A).
union([],[H|Y],Z,A):-member(H,Z),!,union([],Y,Z,A).
union([],[H|Y],Z,A):-union([],Y,[H|Z],A).
unionall(Listo,Res):-unionall(Listo,[],Res).
unionall([],Res,Res).
unionall([Head|Tail],Acc,Res):-union(Head,Acc,Acc1),unionall(Tail,Acc1,Res).


preprocess(List,Result):-preprocess(List,[],Result).
preprocess([Head|Tail],Tail2,Res):-member(F,Head),member(-F,Head),!,preprocess(Tail,Tail2,Res).
preprocess([Head|Tail],Tail2,Res):-append(Tail2,[Head],Tail3),preprocess(Tail,Tail3,Res).
preprocess([],Y,Y).

% findresolvent(Clauselist,Ulist,Result):-findresolvent(Clauselist,Ulist,[],Result).
findnegate(List,Res):-findnegate(List,[],Res).
findnegate([],Res,Res).
findnegate([Head|Tail],Temp,Res):-findcomp(Head,Comp),member(Comp,Tail),!,append([Comp],Temp,Temp2),append([Head],Temp2,Temp3),delete(Tail,Comp,Tail2),findnegate(Tail2,Temp3,Res).
findnegate([_|Tail],Temp,Res):-findnegate(Tail,Temp,Res).
findcomp(A,H):-atom(A),H=(-A),!.
findcomp(A,H):-A=(-H).
memberList([],_).
memberList([X|Xs],Y) :-  member(X,Y),
                         memberList(Xs,Y).



resolveAllClauses(X,Y) :- X=[],Y=[],!.
resolveAllClauses(List,R) :-List=[X], resolve(X,X,R),!.
resolveAllClauses(List,R) :-List=[X,Y|Tail],format("~n Resolving the clauses : "), print(X) , format(' with ')
			,print(Y),
			 union(X,Y,L),nl,!, resolve(L,L,L1), append([L1],Tail,M), resolveAllClauses(M,R).

resolve([],_,[]).
resolve(Head,M,[X|L]) :-Head=[X|Set],atom(X), not(member(- X, M)),!, resolve(Set,M,L).
resolve(Head,M,[- X|L]) :-Head=[- X|Set], atom(X), not(member(X, M)),!, resolve(Set,M,L).
resolve(List,M,L):-!,List=[_|Set],resolve(Set,M,L).

