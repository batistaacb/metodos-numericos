%Algorítmo DOPRI (Dommand-Prince)
%Curso:Engenharia Elétrica
%Aluna: Adilson Carlos Batista            Matrícula: 110950055
%=========================================================================
function [VetX,VetY,EG]=DOPRI(A,B,M,Y0,f) %Função DOPRI
%Algoritmo: DOPRI
%Objetivo: Resolver um PVI pelo método de Dommand-Prince

A21=1/5;
A31=3/40;      A32=9/40;
A41=44/45;     A42=-56/15;     A43=32/9;
A51=19372/6561;A52=-25360/2187;A53=64448/6561;A54=-212/729;
A61=9017/3168; A62=-355/33;    A63=46732/5247;A64=49/176;  A65=-5103/18656;
A71=35/384;    A73=500/1113;   A74=125/192;   A75=-2187/6784;A76=11/84;
C2=1/5;     C3=3/10;     C4=4/5;      C5=8/9;     C6=1;      C7=1;
E1=71/57600;    E3=-71/16695;    E4=71/1920;      E5=-17253/339200;
E6=22/525;      E7=-1/40;
H=(B-A)/M;
Xt=A;
Yt=Y0;
VetX(1)=Xt;
VetY(1)=Yt;
EG(1)=0;

%Cálculos Necessários
for I=1:M
    X=Xt;
    Y=Yt;
    K1=H*(feval(f,X,Y));   %Avaliar f(X,Y)
    
    X=Xt+C2*H;
    Y=Yt+A21*K1;
    K2=H*feval(f,X,Y);   %Avaliar f(X,Y)
    
    X=Xt+C3*H;
    Y=Yt+A31*K1+A32*K2;
    K3=H*feval(f,X,Y);   %Avaliar f(X,Y)
    
    X=Xt+C4*H;
    Y=Yt+A41*K1+A42*K2+A43*K3;
    K4=H*feval(f,X,Y);   %Avaliar f(X,Y)
    
    X=Xt+C5*H;
    Y=Yt+A51*K1+A52*K2+A53*K3+A54*K4;
    K5=H*feval(f,X,Y);   %Avaliar f(X,Y)
    
    X=Xt+C6*H;
    Y=Yt+A61*K1+A62*K2+A63*K3+A64*K4+A65*K5;
    K6=H*feval(f,X,Y);   %Avaliar f(X,Y)
    
    X=Xt+C7*H;
    Y=Yt+A71*K1+A73*K3+A74*K4+A75*K5+A76*K6;
    K7=H*feval(f,X,Y);   %Avaliar f(X,Y)
    
    Xt=A+I*H;
    Yt=Yt+A71*K1+A73*K3+A74*K4+A75*K5+A76*K6;
    erro_global=E1*K1+E3*K3+E4*K4+E5*K5+E6*K6+E7*K7;
    VetX(I+1)=Xt;
    VetY(I+1)=Yt;
    EG(I+1)=erro_global;
    
end  %I
