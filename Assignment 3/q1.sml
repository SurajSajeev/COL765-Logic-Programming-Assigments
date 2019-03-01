
exception greater;
exception invalid;

fun finsum(m,n)=
let
fun sum1(m,acc,n,k)=if m>n then raise greater
else if acc=n then k+m+n 
else sum1(m,acc+1,n,k+m+acc);
in
sum1(m,0,n,0)
end;

fun sum(m,n)=finsum(m,n) handle greater => 0;

fun bin_coeff(n,r)=if n<r orelse n<0 orelse r<0 then  raise invalid else 
if n=r then 1 else if r=1 then n else bin_coeff(n-1,r-1)+bin_coeff(n-1,r);


