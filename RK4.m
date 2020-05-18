% Program RK4
% Programa para resolver um PVI pelo metodo de Runge-Kutta de ordem 4
%
% Parametros de entrada : A , B , M , Y0
%     Limite inferior ,limite superior, numero de subintervalos e valor inicial
%
% Parametros de saida : VetX, VetY
%       Abscissas e solucao do PVI
%
%           { DECLARAR VARIAVEIS }
% declare I , M inteiro
% declare Y0 , A , B , H , X , Xt , Y , Yt , Fxy , 
%         E2 , K1 , K2 , K3 , K4 real
% declare VetX[1:M] , VetY[1:M] real
%
clear all; close all; clc;
%
%           { ENTRADA DE DADOS } 
disp('Expressao da derivada da FUNCAO PVI usando FUNCOES MATEMATICAS DO MATLAB');
VarF = input(' ','s');
% Transformar informacao da expressao em funcao 
Aux = ['@(x,y) ' VarF];
f = str2func(Aux);
disp(' ');
%
A = input('Entre com o limite INFERIOR: ');
B = input('Entre com o limite SUPERIOR: ');
disp(' ');
M = input('Entre com o NÚMERO DE SUBINTERVALOS: ');
Y0 = input('Entre com o VALOR INICIAL: ');
disp(' ');
%
% Saida dos dados informados
clc;
disp('Os parametros de entrada');
disp(['a = ' num2str(A)]);
disp(['b = ' num2str(B)]);
disp(' ');
disp(['m = ' num2str(M)]);
disp(['y0 = ' num2str(Y0)]);
disp(' ');
%
%           { INICIAR VARIAVEIS }
VetX = zeros (1,M+1);
VetY = zeros (1,M+1);
H = (B - A) / M; 
Xt = A;
Yt = Y0;
VetX(1) = Xt;
VetY(1) = Yt;
I = 0;
%
%     Saida de dados do cabeçalho da tabela e linha de titulo
disp('produzem os resultados'); disp(' ');
fprintf('Metodo de Runge-Kutta - ordem 4 \n');
fprintf(' i \t\t   x \t\t  y \n');
fprintf('%2i \t %10.5f %10.5f \n',I,Xt,Yt);
%
%           { CALCULOS NECESSARIOS E SAIDA DE DADOS }
%
for I = 1:M
    X = Xt;
    Y = Yt;
    K1 = f(X,Y);  % { avaliar f(x , y) }
    X = Xt + H / 2;
    Y = Yt + H * K1 / 2;
    K2 = f(X,Y);  % { avaliar f(x , y) }
    Y = Yt + H * K2 / 2;
    K3 = f(X,Y);  % { avaliar f(x , y) }
    X = Xt + H;
    Y = Yt + H * K3;
    K4 = f(X,Y);  % { avaliar f(x , y) }
    Xt = A + I * H;
    Yt = Yt + H * (K1 + 2 * (K2 + K3) + K4) / 6;
    fprintf('%2i \t %10.5f %10.5f \n',I,Xt,Yt);
    VetX(I + 1) = Xt;  % { abscissa }
    VetY(I + 1) = Yt;  % { solucao PVI }
end  % { I }
disp(' ');
%
%Fim do programa