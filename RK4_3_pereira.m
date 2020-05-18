% Program RK4_3 
% Programa para resolver sistema de EDO pelo metodo de Runge-Kutta de ordem
% 4 para EDO de ordem 3
%
% Parametros de entrada : A , B , M , Y10 , Y20 , Y30
%     Limite inferior ,limite superior, numero de subintervalos e valores iniciais
%
% Parametros de saida : VetX , VetY1 , VetY2 , VetY3
%       Abscissas e solucoes do PVI
%
%           { DECLARAR VARIAVEIS } 
% declare I , M inteiro
% declare Y10 , Y20 , Y30 , A , B , H , X , Xt , Y1 , Y2 , Y3 , Y1t , Y2t ,
% Y3t
%         K11 , K12 , K13 , K21 , K22 , K23 , K31 , K32 , K33 , K41 , K42 , K43 real
% declare VetX[1:M+1] , VetY1[1:M+1] , VetY2[1:M+1], VetY3[1:M+1] real
%
clear all; close all; clc;
%
%           { ENTRADA DE DADOS }
disp('Expressao da 1ª EQUACAO do sistema EDO usando FUNCOES MATEMATICAS DO MATLAB:');
VarF = input(' ','s');
%  Transformar informacao da expressao em funcao 
Aux = ['@(x,y1,y2,y3) ' VarF];
f1 = str2func(Aux);
Y10 = input('Entre com o VALOR INICIAL: ');
disp(' ');
%
disp('Expressao da 2ª EQUACAO do sistema EDO usando FUNCOES MATEMATICAS DO MATLAB:');
VarF = input(' ','s');
%  Transformar informacao da expressao em funcao 
Aux = ['@(x,y1,y2,y3) ' VarF];
f2 = str2func(Aux);
Y20 = input('Entre com o VALOR INICIAL: ');
disp(' ');
%
disp('Expressao da 3ª EQUACAO do sistema EDO usando FUNCOES MATEMATICAS DO MATLAB:');
VarF = input(' ','s');
%  Transformar informacao da expressao em funcao 
Aux = ['@(x,y1,y2,y3) ' VarF];
f3 = str2func(Aux);
Y30 = input('Entre com o VALOR INICIAL: ');
disp(' ');
%
A = input('Entre com o limite INFERIOR: ');
B = input('Entre com o limite SUPERIOR: ');
disp(' ');
M = input('Entre com o NUMERO DE SUBINTERVALOS: ');
disp(' ');
%
%  Saida dos dados informados
clc;
disp('Os parametros de entrada');
disp(['a = ' num2str(A)]);
disp(['b = ' num2str(B)]);
disp(' ');
disp(['m = ' num2str(M)]);
disp(' ');
disp(['y10 = ' num2str(Y10)]);
disp(['y20 = ' num2str(Y20)]);
disp(['y30 = ' num2str(Y30)]);
disp(' ');
%
%           { INICIAR VARIAVEIS }
VetX = zeros (1,M+1);
VetY1 = zeros (1,M+1);
VetY2 = VetY1;
VetY3 = VetY2;
H = (B - A) / M; 
Xt = A;
Y1t = Y10;
Y2t = Y20;
Y3t = Y30;
VetX(1) = Xt;
VetY1(1) = Y1t;
VetY2(1) = Y2t;
VetY3(1) = Y3t;
I = 0;
%
% Saida de dados do cabecalho da tabela e linha de titulo
disp('produzem os resultados'); disp(' ');
fprintf('Metodo de RK4 para sistema de ordem 3 \n');
fprintf(' i \t\t   x \t\t  y1 \t\t y2\t\t y3 \n');
fprintf('%2i \t %10.5f %10.5f %10.5f %10.5f \n',I,Xt,Y1t,Y2t,Y3t);
%
%           { CALCULOS NECESSARIOS E SAIDA DE DADOS }
%
for I = 1:M
    X = Xt;
    Y1 = Y1t;
    Y2 = Y2t;
    Y3 = Y3t;
    K11 = f1(X,Y1,Y2,Y3);  % { avaliar f1(x , y) }
    K12 = f2(X,Y1,Y2,Y3);  % { avaliar f2(x , y) }
    K13 = f3(X,Y1,Y2,Y3);  % { avaliar f3(x , y) }
    %
    X = Xt + H / 2;
    Y1 = Y1t + H * K11 / 2;
    Y2 = Y2t + H * K12 / 2;
    Y3 = Y3t + H * K13 / 2;
    K21 = f1(X,Y1,Y2,Y3);  % { avaliar f1(x , y) }
    K22 = f2(X,Y1,Y2,Y3);  % { avaliar f2(x , y) }
    K23 = f2(X,Y1,Y2,Y3);  % { avaliar f3(x , y) }
    %
    Y1 = Y1t + H * K21 / 2;
    Y2 = Y2t + H * K22 / 2;
    Y3 = Y3t + H * K23 / 2;
    K31 = f1(X,Y1,Y2,Y3);  % { avaliar f1(x , y) }
    K32 = f2(X,Y1,Y2,Y3);  % { avaliar f2(x , y) }
    K33 = f3(X,Y1,Y2,Y3);  % { avaliar f3(x , y) }
    %
    X = Xt + H;
    Y1 = Y1t + H * K31;
    Y2 = Y2t + H * K32;
    Y3 = Y3t + H * K33;
    K41 = f1(X,Y1,Y2,Y3);  % { avaliar f1(x , y) }
    K42 = f2(X,Y1,Y2,Y3);  % { avaliar f2(x , y) }
    K43 = f3(X,Y1,Y2,Y3);  % { avaliar f3(x , y) }
    %
    Xt = A + I * H;
    Y1t = Y1t + H * (K11 + 2 * (K21 + K31) + K41) / 6;
    Y2t = Y2t + H * (K12 + 2 * (K22 + K32) + K42) / 6;
    Y3t = Y3t + H * (K13 + 2 * (K23 + K33) + K43) / 6;
    %
    fprintf('%2i \t %10.5f %10.5f %10.5f %10.5f \n',I,Xt,Y1t,Y2t,Y3t);
    VetX(I + 1) = Xt;  % { abscissa }
    VetY1(I + 1) = Y1t;  % { solução 1 do sistema PVI }
    VetY2(I + 1) = Y2t;  % { solução 2 do sistema PVI }
    VetY3(I + 1) = Y3t;  % { solução 3 do sistema PVI }
end  % { I }
disp(' ');
%
%Fim do programa