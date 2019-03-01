structure complexop=struct

type complex=real*real;
infix ++;
fun op ++(a:complex , b:complex)=(#1 a + #1 b,#2 a + #2 b):complex;

infix **;
fun op **(x:complex,y:complex) = (#1 x * #1 y - #2 x * #2 y, #2 x * #1 y + #1 x * #2 y):complex;

infix //;
fun op // (s : real, b:complex) = (#1 b / (#1 b * #1 b + #2 b * #2 b), ~(#2 b) /(#1 b * #1 b + #2 b * #2 b)):complex;

infix %%;
fun (a:complex) %% (b:complex) = 
let
val c=1.0//b;
in 
a**c
end;

end;

