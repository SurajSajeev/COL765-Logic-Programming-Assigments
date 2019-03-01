%dcg_handler module accepts two parameters the 1st parameter reads DCG grammar from the file and second file writes to the file
%input file 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dcg_handler(X,Z):-mainread(X,List),dcglisttoprologlist(List,Y),mainwrite(Z,Y).
dcglisttoprologlist([end_of_file],[]):-!.
dcglisttoprologlist([Head|Tail],[Head1|Tail1]):-dcg_to_prolog_converter(Head,Head1),dcglisttoprologlist(Tail,Tail1).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%                                                          READ MODULE
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
mainread(Y,Res):-
         open(Y,read,Str),
         readmodule(Str,Res),
         close(Str).
   
   readmodule(Stream,[]):-
         at_end_of_stream(Stream).
   
   readmodule(Stream,[X|L]):-
         \+  at_end_of_stream(Stream),
         read(Stream,X),
         readmodule(Stream,L). 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%                                                        WRITE MODULE
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
mainwrite(Out,List):-open(Out,write,Str),writeintostream(Str,List),close(Str).
writeintostream(_,[]):-!.
writeintostream(Str,[Head|Tail]):-write(Str,Head),write(Str,'.\n'),writeintostream(Str,Tail).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%                                                 DCG TO PROLOG CLAUSE CONVERTER
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% if variable is passed the the following rule is 
dcg_to_prolog_converter(Dcggrammar,PrologClause):-var(Dcggrammar),PrologClause=Dcggrammar,!.

% it is for conversion in the form of the a-->b,c to a(X,Y)=b(X,Z),c(Z,Y). 

dcg_to_prolog_converter(Dcggrammar,PrologClause):-dcg_expand(Dcggrammar,PrologClause),!.

%non-grammar is returned as the clause itself

dcg_to_prologconverter(Nondcg,Nondcg).
dcg_expand(Dcg,Dcg):-var(Dcg),!.
dcg_expand(Arg1,Arg2):-Arg1=(Head-->Body),Arg2=(Head1:-Body1),translatefirst(Head,Head1,Temp1,Temp2),translateremaining(Body,Body1,Temp1,Temp2).
translatefirst(A,B,C,D):-A=..[Func|Arg],append(Arg,[C,D],NewArg),B=..[Func|NewArg].
translateremaining(A,B,C,D):-translatestep1(A,B1,C1,C,D),translatestep2(B1,B,C1,C,D).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%                                            TRANSLATE THE HEAD AND SINGLE ELEMENT
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


translatestep1(A,B,C,D,C):-var(A),translatefirst(A,B,D,C),!.
translatestep1(A,B,C,D,_):-A=[],B=1,C=D,!.
translatestep1(A,B,C,D,E):-A=[Head|Tail],translatestep1(Tail,Newvar,C,D1,E),unificate(D=[Head,D1],Newvar,B).
translatestep1((X,Y), Z, T, S0, S) :- !,translatestep1(X, X1, S1, S0, S1),translatestep1(Y, Y1, T, S1, S),unificate(X1, Y1, Z).
translatestep1(X, X1, S, S0, S) :-translatefirst(X, X1, S0, S).
translatestep2(Y, Y, T, S0, T) :- not(T == S0), !.
translatestep2(Y0, Y, T, _, S) :- unificate(Y0, S=T, Y).
unificate(X, Y, Z) :- Y == 1, !, Z = X.
unificate(X, Y, (X,Y)).
