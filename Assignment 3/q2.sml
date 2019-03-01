fun time1((h1,m1,dn1),(h2,m2,dn2))=let 
fun greater(a1,b1)=if a1="PM" andalso b1="AM" then true else false;
fun lesser(a1,b1)=if a1="AM" andalso b1="PM" then true else false;
in 
if greater (dn1,dn2) then true else if lesser(dn1,dn2) then false else if h1>h2 andalso h1<>12 then true else if h1<h2 then if h2=12 then true else false else if m1>m2 then true else  false
end;

type time={f:string,hour:int,min:int};

fun time2(r1:time,r2:time)=let 
fun greater(a1,b1)=if a1="PM" andalso b1="AM" then true else false;
fun lesser(a1,b1)=if a1="AM" andalso b1="PM" then true else false;
val dn1= #f r1;
val h1= #hour r1;
val m1= #min r1;
val dn2= #f r2;
val h2= #hour r2;
val m2= #min r2;
in 
if greater (dn1,dn2) then true else if lesser(dn1,dn2) then false else if h1>h2 andalso h1<>12 then true else if h1<h2 then if h2=12 then true else false else if m1>m2 then true else  false
end;



