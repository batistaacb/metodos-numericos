% Program Euler
% Programa para resolver um PVI pelo metodo de Euler
%
% Parametros de entrada : A , B , M , Y0
%     Limite inferior ,limite superior, numero de subintervalos e valor inicial
%
% Parametros de saida : VetX, VetY
%       Abscissas e solucao do PVI
%
%           { DECLARAR VARIAVEIS }
% declare I , M inteiro
% declare Y0 , A , B , H , X , Y , Fxy , E2 real
% declare VetX[1:M] , VetY[1:M] real
%
clear all; close all; clc;
%
%           { ENTRADA DE DADOS } 
disp('Expressao da derivada da FUNCAO PVI usando FUNCOES MATEMATICAS DO MATLAB');
VarF = input(' ','s');
% Transformar informacao da expressao em funcao do matlab
Aux = ['@(x,y) ' VarF];
f = str2func(Aux);
disp(' ');
%
A = input('Entre com o limite INFERIOR: ');
B = input('Entre com o limite SUPERIOR: ');
disp(' ');
M = input('Entre com o NUMERO DE SUBINTERVALOS: ');
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
VetX = zeros (1,M);
VetY = zeros (1,M);
H = (B - A) / M; 
X = A;
Y = Y0;
Fxy = f(X,Y);   % { avaliar f(x , y) em X = X0 e Y = Y0 }
VetX(1) = X;
VetY(1) = Y;
I = 0;
%
% Saida de dados do cabecalho da tabela e linha de titulo
disp('produzem os resultados'); disp(' ');
fprintf(' \t Metodo de Euler \n');
fprintf(' i \t\t   x \t\t  y \t  f(x , y) \n');
fprintf('%2i \t %10.5f %10.5f %10.5f \n',I,X,Y,Fxy);
%
%           { CALCULOS NECESSARIOS E SAIDA DE DADOS }
%
for I = 1:M
    X = A + I * H;
    Y = Y + H * Fxy;
    Fxy = f(X,Y);  % { avaliar f(x , y) em X = Xi e Y = Yi }
    fprintf('%2i \t %10.5f %10.5f %10.5f \n',I,X,Y,Fxy);
    VetX(I + 1) = X;  % { abscissa }
    VetY(I + 1) = Y;  % { solucao PVI }
end  % { I }
disp(' ');
%
%Fim do programa