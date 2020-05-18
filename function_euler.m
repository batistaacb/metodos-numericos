function ]saida_dados]
f=inline(f);
h=(b-a)/m;
x=a;
y=y_0;
Fxy=feval(f,x,y);%{avaliar f(x,y) em x=x_0 e y=y_0}
% {Cálculo necessários }
for i=1:m % {Para i}
    x=a+i*h;
    y=y+h*Fxy;
    Fxy=feval(f,x,y);
end       % { Fim i}