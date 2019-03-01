fun delete (item:int, lst:(int * int) list) =
    case  lst of
    []=>[]
      |(a,xs)::ys => if item = xs then delete(item,ys)
          else(a,xs)::delete(item,ys);

fun sumall1 (item:int, lst:(int * int) list,currsum:int) =
    case  lst of
    []=>currsum
      |(a,xs)::ys => if item = xs then sumall1(item,ys,a+currsum)
          else sumall1(item,ys,currsum);

fun sumall(item:int,lst:(int*int) list)=sumall1(item,lst,0);
fun find([]:(int*int)list,r:int)= ~8|find((a:int,b:int)::tail:(int*int)list,s:int)=if b=s then a else find(tail,s);
fun polyadd1([]:(int*int)list,y:(int*int)list,z:(int*int)list)=y@z|
polyadd1(x:(int*int)list,[]:(int*int)list,z1:(int*int)list)=x@z1|
polyadd1((c:int,e:int)::tail:(int*int)list,y:(int*int)list,z2:(int*int)list)=
let
val coef=find(y,e);
val newlist=delete(e,y);
in
if(coef = ~8) then polyadd1(tail,newlist,(c,e)::z2) 
else polyadd1(tail,newlist,(c+coef,e)::z2)
end
;
fun polyadd (x,y)=polyadd1(x,y,[]) ;


fun process1((a,b),[],y)=y|
process1((c,d),(e,f)::tail,tail2)=process1((c,d),tail,(c*e,d+f)::tail2);
fun process((a:int,b:int),lst:(int*int)list)=process1((a,b),lst,[]);

fun rectify1([]:(int*int)list,z:(int*int)list)=z|
rectify1((a:int,b:int)::tail:(int*int)list,lst2:(int*int)list)=
let
val dataitem=sumall(b,tail);
val newlist=delete(b,tail);
in
rectify1(newlist,(dataitem+a,b)::lst2)
end;
fun rectify(z:(int*int)list)=rectify1(z,[]);

fun polymult1([]:(int*int)list,y:(int*int)list,z:(int*int)list)=rectify(z)|
polymult1((a:int,b:int)::tail:(int*int)list,list2:(int*int)list,list3:(int*int)list)=
let
val datalist=process((a,b),list2);
in
polymult1(tail,list2,datalist@list3)
end;
fun polymult(x:(int*int)list,y:(int*int)list)=polymult1(x,y,[]);

