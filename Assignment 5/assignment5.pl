:-op(300,fy,/\).
:-op(400,fy,->).

sentence(Logicalform1,sentence(SN,VP))-->singlenoun(A,SN),vp1(B,VP),{Logicalform1=..[B,A]},!.
sentence(Logicalform,sentence(SN,V,SC))-->singlenoun(A,SN),verbn(B,V),secnoun(C,SC),{Logicalform=..[B,A,C]},!.
sentence(Logicalform,sentence(SN,VN,D,SC))-->singlenoun(A,SN),verbn(B,VN),deter(D),secnoun(C,SC),{Logicalform=..[B,A,C]},!.
sentence(LogicalForm,sentence(NP,VP))-->np(Restrictor,Scope,LogicalForm,NP),vp(Restrictor,Scope,VP).
np(A,B,C,noun_phrase(Det,Noun))-->det(A,D,B,C,Det),noun(A,D,Noun).
np(A,B,C,noun_phrase(Det,Adj,Noun))-->det(A,D,B,E,C,Det),adj(A,E,Adj),noun(A,D,Noun).
np(A,B,C,noun_phrase(N))-->noun2(A,B,C,N).
vp(A,B,verb_phrase(V,Np))-->verb(A,C,D,V),np(C,D,B,Np).
det(A,Res,Scope,all(A,Res->Scope),determinant(every))-->[every].
det(A,Res,Scope,all(A,Res->Scope),determinant(all))-->[all].
det(A,Res,Scope,all(A,Res->Scope),determinant(each))-->[each].
det(A,Res,Scope,exist(A,Res/\Scope),determinant(a))-->[a].
det(A,Res,Scope,exist(A,Res/\Scope),determinant(an))-->[an].
det(A,Res,Scope,exist(A,Res/\Scope),determinant(any))-->[any].
det(A,Res,Scope,exist(A,Res/\Scope),determinant(the))-->[the].
det(A,Res,Scope,Adj,exist(A,Res/\Adj/\Scope),determinant(a))-->[a].
noun(X,Y,noun(N))-->[N],{Y=..[N,X]},{itisnoun(N)}.
noun2(A,B,C,noun(N))-->[N],{itisnoun(N)},{B=..[V,D,_]},{C=..[V,D,N]},{A=V}.
verb(X,Y,Z,verb(V))-->[V],{Z=..[V,X,Y]},{itisverb(V)}.
adj(A,E,adjective(Adj))-->[Adj],{E=..[Adj,A]},{isadj(Adj)}.
verbn(B,verb(B))-->[B],{itisverb(B)}.
singlenoun(A,noun(S))-->[S],{A=S},{itisnoun(S)}.
vp1(A,verb_phrase(verb(is),D,SC))-->dcareverb,deter(D),secnoun(A,SC).
deter(determinant(A))-->[A],{dcaredet(A)}.

secnoun(B,noun(N))-->[N],{B=N},{itisnoun(N)}.
isadj(fat).
dcaredet(a).
dcaredet(an).
dcaredet(the).
dcareverb-->[is].
itisnoun(teacher).
itisnoun(course).
itisnoun(ram).
itisnoun(god).
itisnoun(man).
itisnoun(cat).
itisnoun(rat).
itisnoun(sita).
itisnoun(water).
itisnoun(apple).
itisverb(teaches).
itisverb(drinks).
itisverb(eats).
itisverb(loves).
itisverb(hates).