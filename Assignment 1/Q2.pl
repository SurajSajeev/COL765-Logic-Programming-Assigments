%                                 ********************************
%                                 |     Prolog-Assignment 1      |
%                                 |           Question2          |
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
%                                 |         Question 2.1         |
%                                 ********************************

% additional reverse program for reversing the list.
reverse(List,Result):-reverse(List,[],Result).
reverse([],Result,Result).
reverse([Head|Tail],Acc,Result):-reverse(Tail,[Head|Acc],Result).

% create_BST program        
create_BST(Result, List):-reverse(List,Temp),create_bst(Temp,Result).
create_bst([],void).
create_bst([Head|Tail],Result):-create_bst(Tail,Temp),addtopelement(Head,Temp,Result).
addtopelement(X,void,node(void,X,void)).
addtopelement(X,node(Left,Y,Right),node(Left1,Y,Right)):-X<Y,!,addtopelement(X,Left,Left1).
addtopelement(X,node(Left,Y,Right),node(Left,Y,Right1)):-X>Y,!,addtopelement(X,Right,Right1).
addtopelement(X,node(Left,Y,Right),node(Left,Y,Right)):-X=Y.

%                                 ********************************
%                                 |         Question 2.2         |
%                                 ********************************
% program for pre-order traversal
preorder(void,[]).
preorder(node(Left,X,Right),Acc):-preorder(Left,Y1),preorder(Right,Z1),append([X|Y1],Z1,Acc).

% program for inorder traversal
inorder(void,[]).
inorder(node(Left,X,Right),Acc):-inorder(Left,Y1),inorder(Right,Z1),append(Y1,[X|Z1],Acc).

% program for post-order traversal
postorder(void,[]).
postorder(node(Left,Y,Right),Acc):-postorder(Left,Y1),postorder(Right,Z1),append(Y1,Z1,Acc1),append(Acc1,[Y],Acc).


%                                 ********************************
%                                 |         Question 2.3         |
%                                 ********************************

% count the number of nodes in a given BST
% If the tree is empty is empty
count(void,0).

% If the tree is not empty then total number of node is no. of nodes in left subtree + no. of nodes in right subtree + 1
count(node(X,Y,Z),A):-count(X,A1),count(Z,A2),A is A1+A2+1.


%                                 ********************************
%                                 |         Question 2.4         |
%                                 ********************************
%function for calculating the maximum of two numbers
max(A,B,C):-A>B,!,C is A.
max(A,B,C):-C is B.

% if the tree is empty the height is -1
height(void,-1).

% else check for the highest left or right subtree
height(node(X,Y,Z),A):-height(X,A1),height(Z,A2),max(A1,A2,A3),A is A3+1.


%                                 ********************************
%                                 |         Question 2.5         |
%                                 ********************************

find(void,A):-false.
find(node(X,Y,Z),A):-Y=A;find(X,A);find(Z,A).
