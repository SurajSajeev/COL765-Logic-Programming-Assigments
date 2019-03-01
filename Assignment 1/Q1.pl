%                                 ********************************
%                                 |     Prolog-Assignment 1      |
%                                 |           Question1          |
%                                 |        Author:-Suraj S       |
%                                 |          2018MCS2024         |
%                                 ********************************

% UTILITY FUNCTIONS

append([Head|Tail],List2,[Head|Tail1]):-append(Tail,List2,Tail1).
append([],Tail,Tail).

member(X,[]):-false.
member(X,[Head|Tail]):-X=Head,!.
member(X,[Head|Tail]):-member(X,Tail).

%                                 ********************************
%                                 |         Question 1.1         |
%                                 ********************************

% create_set with two parameter will call the overloaded create_set with  accumulator list initialized to empty list.

create_set(Head,Z):-createset(Head,[],Z).


% if the list is empty unify it.

create_set([],Y,Y).


% check weather the new head element took is in the empty list or not,if it is there ignore the list and proceed. 

create_set([Head|Tail],Acc,Z):-member(Head,Acc),!,createset(Tail,Acc,Z).


% if it it is not in the accumulator list add it to the accumulator list.

create_set([Head|Tail],Y,Z1):-append(Y,[Head],Z),createset(Tail,Z,Z1).



%                                 ********************************
%                                 |         Question 1.2         |
%                                 ********************************

% union with three parameter will call the overloaded union with  accumulator list initialized to empty list.

union(Set1,Set2,Unionset):-union(Set1,Set2,[],Unionset).


% when both of the list is empty unify the accumulator with unionset

union([],[],Unionset,Unionset).


% check weather the given element from the first set exist in the accumulator list,if not add it into the list.

union([Head|Tail],Set2,Acc,Unionset):-member(Head,Acc),!,union(Tail,Set2,Acc,Unionset).

union([Head|Tail],Set2,Acc,Unionset):-append(Acc,[Head],Temp),union(Tail,Set2,Temp,Unionset).


% if set1 is empty proceed from set2 

union([],[Head|Tail],Acc,Unionset):-member(Head,Acc),!,union([],Tail,Acc,Unionset).

union([],[Head|Tail],Acc,Unionset):-append(Acc,[Head],Temp),union([],Tail,Temp,Unionset).







%                                 ********************************
%                                 |         Question 1.3         |
%                                 ********************************

% intersection with three parameter will call the overloaded intersection with  accumulator list initialized to empty list.

intersection(Set1,Set2,Interset):-intersection(Set1,Set2,[],Interset).


% if the set1 is empty unify it.

intersection([],Set2,Interset,Interset).


% if the set is not empty and checking weather the head element of 1st set is an element of 2nd set or not if yes add it to the list.


intersection([Head|Tail],Set2,Acc,Interset):-member(Head,Set2),!,append(Acc,[Head],Tempacc),intersection(Tail,Set2,Tempacc,Interset).

intersection([Head|Tail],Set2,Acc,Interset):-intersection(Tail,Set2,Acc,Interset).




%                                 ********************************
%                                 |         Question 1.4         |
%                                 ********************************


% difference with three parameter will call the overloaded difference with accumulator list initialized to empty list.

difference(Set1,Set2,Diffset):-difference(Set1,Set2,[],Diffset).


% if the first set is empty Unify the accumulator.

difference([],Set2,Diffset,Diffset).


% if the 1st element of the set is available in 2nd set too remove the element.

difference([Head|Tail],Set2,Acc,Diffset):-member(Head,Set2),!,difference(Tail,Set2,Acc,Diffset).

difference([Head|Tail],Set2,Acc,Diffset):-append(Acc,[Head],Temp),difference(Tail,Set2,Temp,Diffset).


%                                 ********************************
%                                 |         Question 1.5         |
%                                 ********************************


% product with three parameter will call the overloaded difference with accumulator list initialized to empty list.

product(Set1,Set2,Productset):-product(Set1,Set2,[],Productset).


% if the first set is empty Unify the accumulator with result.

product([],Set2,Productset,Productset).


% taking 1st element and making the product with all the element in set 2.

product([Head|Tail],Set2,Acc,Productset):-inproduct(Head,Set2,[],Temp),append(Acc,Temp,Acc2),product(Tail,Set2,Acc2,Productset).

inproduct(Head,[Head2|Tail2],Acc,Returnset):-append(Acc,[[Head,Head2]],Acc1),inproduct(Head,Tail2,Acc1,Returnset).

inproduct(Head,[],Acc,Acc).
