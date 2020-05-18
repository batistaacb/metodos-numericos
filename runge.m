%-------------------------------
%Método de Runge-Kutta 4ªordem
%-------------------------------
A=0;%input('Entre com o limite inFerior:');
B=1;%input('Entre com o limite superior:');
M=10;%input('Entre com o número de subintervalos:');
Y0=1;%input('Entre com o valor inicial:');
syms x y;
H=(B-A)/M;
Xt=A;
Yt=Y0;
F=input('Entre com a função:','s');  %x-2*y+1;
F=inline(F);
Fxy=feval(F,Xt,Yt);
saida(1,1)=0;
saida(1,2)=Xt;
saida(1,3)=Yt;
Z={'I' 'xt' 'Yt'};

for I=1:M
    X=Xt;
    Y=Yt;
    K1=feval(F,X,Y);%K1
    X=Xt+H/2;
    Y=Yt+H/2*K1;
    K2=feval(F,X,Y); %K2
    Y=Yt+H/2*K2;
    K3=feval(F,X,Y); %K3
    X=Xt+H;
    Y=Yt+H*K3;
    K4=feval(F,X,Y);%K4
    Xt=A+I*H;
    Yt=Yt+H/6*(K1+2*(K2+K3)+K4); %média ponderada
    saida(I+1,1)=I; 
    saida(I+1,2)=Xt;
    saida(I+1,3)=Yt;
end
disp(Z);
disp(saida);

%Fim Algoritimo