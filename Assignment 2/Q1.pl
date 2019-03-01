%*******************************************************************************************************************

%                                                         ILFP ASSIGNMENT
%							      COL 765
%							    2018MCS2024

%*******************************************************************************************************************
%                                                DIRECTIONS FOR USE 

% 1.     Add the clause to function semantics as a parameter 
% 2.     Watch and see how it gets converted


:-op(100,fy,-),op(200,yfx,*),op(300,yfx,+),op(400,xfy,<),op(500,xfy,=).

% tree node is in the form of node(Left,List,Op,Cl,Right)
% Op and cl are the flags for indicating the existence of open and closed path.
 

tableau(A):-T=node(_,[A],_,_,_,_),createtree(T),T2=node(_,[-A],_,_,_,_),createtree(T2),printret(T),printsatcont(T,T2),!.

% create the tree procedure in the tree traverse it back.
createtree(node(Left,Data,Op,Cl,null,Num)):-andsprule(Data,Temp,Num),Left=node(_,Temp,Op1,Cl1,_,_),createtree(Left),Op=Op1,Cl=Cl1. 
createtree(node(closed,Data,0,1,null,0)):-datacontainsneg(Data),format("~nclose encountered"),nl,!.
createtree(node(open,Data,1,0,null,0)):-onlycontainsconst(Data),format("~nopen encountered"),nl,!.
createtree(node(Left,Data,Op,Cl,null,Num)):-andrule(Data,Temp,Num),Left=node(_,Temp,Op1,Cl1,_,_),createtree(Left),Op=Op1,Cl=Cl1.
createtree(node(Left,Data,Op,Cl,Right,Num)):-orrule(Data,Temp,Temp1,Num),Left=node(_,Temp,Op1,Cl1,_,_),Right=node(_,Temp1,Op2,Cl2,_,_),createtree(Left),createtree(Right),max(Op1,Op2,Op),max(Cl1,Cl2,Cl).

max(A,B,C):-A>B,C=A.
max(A,B,C):-B>A,C=B.
max(A,B,C):-B=A,C=B.

% and rules used in evaluating the and expressions

andrule(L,Res,D):-andform(C,A,B,D),member(C,L),delete(L,C,Temp),append([B],Temp,Temp1),append([A],Temp1,Res),!.
andsprule(Data,Res,5):-C=(-Head),Head=(-Head2),member(C,Data),delete(Data,C,Res1),append([Head2],Res1,Res).


% or rules used in evaluating the or expressions


orrule(Data,LeftRes,RightRes,D):-orform(C,Left,Right,D),member(C,Data),delete(Data,C,Res),append([Left],Res,LeftRes),append([Right],Res,RightRes),!.


% various and rules


andform(A,B,C,D):-rule1(A,B,C,D).
andform(A,B,C,D):-rule2(A,B,C,D).
andform(A,B,C,D):-rule3(A,B,C,D).
orform(A,B,C,D):-rule4(A,B,C,D).

% various or rules

orform(A,B,C,D):-rule5(A,B,C,D).
orform(A,B,C,D):-rule6(A,B,C,D).
orform(A,B,C,D):-rule7(A,B,C,D).
orform(A,B,C,D):-rule8(A,B,C,D).

% defining various rules 


rule1(B*C,B,C,1).
rule2(-(B<C),B,-C,7).
rule3(-(B+C),-B,-C,4).
rule4(-(B=C),B*(-C),(-B)*C,9).
rule5(B+C,B,C,3).
rule6(B<C,-B,C,6).
rule7(-(B*C),-B,-C,2).
rule8(B=C,B*C,(-B)*(-C),8).


datacontainsneg(Data):-member(L,Data),member(-L,Data).
onlycontainsconst([]).
onlycontainsconst([Head|Tail]):-isliteral(Head),onlycontainsconst(Tail).
isliteral(Head):-atom(Head);Head=(-Head1),atom(Head1).

% print the whole tree at once and traverse it back

printret(T):-write('--------------------------------CREATING THE TREE-------------------------------'),nl,printret(T,0),!.
printret(null,_).
printret(open,_):-write("----------open"),nl,!.
printret(closed,_):-write("-----------closed"),nl,!.
printret(node(Left,Data,_,_,Right,0),N):-print(Data),printret(Left,N1),nl,printret(Right,N1),nl,!.
printret(node(Left,Data,_,_,Right,M),N):-write("Applying Rule "),write(M),write(" :"),tab(N),N1 is N+3,print(Data),nl,printret(Left,N1),nl,printret(Right,N1),nl,!.

printsatcont(node(_,_,Op,Cl,_,_),_):-Op=0,Cl=1,format('~nTHE PROPOSITION IS INCONSISTENT......').
printsatcont(node(_,_,Op,_,_,_),node(_,_,Op1,Cl1,_,_)):-Op=1,Op1=0,Cl1=1,format('~nTHE PROPOSITION IS VALID..............'),!.
printsatcont(node(_,_,Op,_,_,_),_):-Op=1,format('~nTHE PROPOSITION IS CONSISTENT........').
