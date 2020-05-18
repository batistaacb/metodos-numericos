%Algorítmo ABM4 (Adams-Bashforth-Moulton)
%Curso:Engenharia Elétrica
%Aluna: Adilson Carlos Batista            Matrícula: 110950055
%=========================================================================
% Programa para resolver um PVI pelo metodo de Adams-Basforth-Moulton
% Usando como preditor o metodo de Dormand-Prince
% Parametros de entrada : A , B , M , Y0
% Limite inferior ,limite superior, numero de subintervalos e valor inicial
% Parametros de saida : VetX, VetY , EG
% Abscissas , solucao do PVI e erro global
%           { DECLARAR VARIAVEIS } 
% declare I , M inteiro
% declare Y0 , A , B , H , X , Xt , Y , Yt , Fxy , 
%         E2 , K1 , K2 , K3 , K4 , K5 , K6 , K7 , ErroGlobal , 
%         A21 , A31 , A32 , A41 , A42 , A43 , A51 , A52 , A53 , A54 ,
%         A61 , A62 , A63 , A64 , A65 , A71 , A73 , A74 , A75 , A76 , 
%         C2 , C3 , C4 , C5 , C6 , C7 , E1 , E3 , E4 , E5 , E6 , E7   real
% declare VetX[1:M+1] , VetY[1:M+1] , EG[1:M+1]  real
clear all; close all; clc;

%Objetivo:Resolver um PVI pelo método de Adams-Bashforth-Moulton
f=input('Entre com a função: x-2*y+1  ','s');
A= input('Entre com o limite inferior=  0   : ');
B= input('Entre com o limite superior =  1 : ');
M= input('Entre com o numero de subintervalos  10 : ');
Y0= input('Entre com o valor inicial = 1 : ');
f=inline(f);
H=(B-A)/M;
[VetX,VetY,EG]=DOPRI(A,A+H*3,3,Y0,f); %Função DOPRI
%Parâmetros de saída de DOPRI retornam em VetX, VetY, Erro
%Cálculos Necessários
% Saida dos dados informados
clc
disp('Os parametros de entrada');
disp(['A = ' num2str(A)]);
disp(['B = ' num2str(B)]);
disp(['M = ' num2str(M)]);
disp(['Y0 = ' num2str(Y0)]);
disp('');
fprintf('Metodo de Adams_Bashforth_Moulton \n');
z={ 'i'   'VetX'   'VetY'  'Erro' };
saida(1,1)=0;
saida(1,2)=0;
saida(1,3)=0;
saida(1,4)=0;
for i=1:4
      saida(i,1)=i;
      saida(i,2)=VetX(i);
      saida(i,3)=VetY(i);
      saida(i,4)=EG(i);
end         % {Fim i}
for i=4:M
      X=VetX(i-3);
      Y=VetY(i-3);
      f0=feval(f,X,Y);  %Avaliar f(X,Y)
      X=VetX(i-2);
      Y=VetY(i-2);
      f1=feval(f,X,Y);  %Avaliar f(X,Y)
      X=VetX(i-1);
      Y=VetY(i-1);
      f2=feval(f,X,Y);  %Avaliar f(X,Y)
      X=VetX(i);
      Y=VetY(i);
      f3=feval(f,X,Y);  %Avaliar f(X,Y)
      Ypre=H*(55*f3-59*f2+37*f1-9*f0)/24+VetY(i);
      VetY(i+1)=Ypre;
      VetX(i+1)=A+i*H;
      X=VetX(i+1);
      for J=1:2
          Y=VetY(i+1);
          f4=feval(f,X,Y); %Avaliar f(X,Y)
          Ycor=H*(9*f4+19*f3-5*f2+f1)/24+VetY(i);
          VetY(i+1)=Ycor;
      end %J
      Erro=abs(Ycor-Ypre)*19/270;

      saida(1+i,1)=i;
      saida(1+i,2)=VetX(i+1);
      saida(1+i,3)=VetY(i+1);
      saida(1+i,4)=Erro;
      
end              % {Fim i}
disp(z);
format long
disp(saida);
% Fim Algoritmo

