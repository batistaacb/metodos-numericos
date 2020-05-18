% Program Regula Falsi
% programa para calcular a raiz de uma equacao pelo metodo da regula falsi
% Parametros de entrada : a , b , toler , iter_max 
%    { limite inferior, limite superior, tolerancia e numero maximo de iteracoes } 
% Parametros de saída : Raiz , iter , CondErro
%  { raiz e numero de iteracoes gastas e condicao de erro, sendo: }
%  { CondErro = 0 se raiz foi encontrada e CondErro = 1 em caso contrario }
%       { Declarar variaveis }
% declare iter , IteMax inteiro
% declare a , b , Fa , Fb , X , Fx , DeltaX , toler , Raiz , T  real
% declare f , Aux leteral
% declare f funcao numerica
% declare CondErro logico
clear all
close all
clc
%       { Entrada de dados }
eu = 2.718312812 ;                                                         % numero de Euller
iter =0;                                                                    % variavel que vai contar as iterações recebe zero.
toler=1e-4;                                                                % tolerÃ¢ncia para proximidade da raiz exata.
iter_max=1e3;                                                              % numero mÃ¡ximo de iterações.
a = 0 ;
b = 1 ;
syms x                                                                    % definroto "x" como variavel simbolica.
f= eu^x -4*x^2 ;                                                          % inserindo função em linguagem Matlab.
f=inline(f);                                                               % contrÃ³i um objeto de função interna para "f(x)".
Fa = feval(f,a);
Fb = feval(f,b);
disp(' ');
%  Saida dos dados informados
clc;
disp('Os parametros de entrada');
disp(['a = ' num2str(a)]);
disp(['b = ' num2str(b)]);
disp(['toler = ' num2str(toler)]);
disp(['iterMax = ' num2str(iter_max)]);
if Fa * Fb > 0
    disp(' ');
    disp('Funcao nao muda de sinal nos extremos do intervalo dado');
    disp('Programa encerrado');
    break
end
%
if Fa > 0
    T = a;
    a = b;
    b = T;
    T = Fa;
    Fa = Fb;
    Fb = T;
end
%
X = b;
Fx = Fb;
DeltaX = -Fx * (b - a) / (Fb - Fa);
X = X + DeltaX;
Fx = f(X);
%     Saida de dados do cabeçalho da tabela e linha de título
disp('Produzem os resultados'); disp(' ');
fprintf('Calculo de raiz de equacao pelo metodo Regula Falsi \n');
Cabecalho = 'iter  a  Fa  b  Fb  x  Fx  DeltaX \n';
fprintf(Cabecalho)
Cabecalho = '%3i ';
Cabec = '%10.5f';
for I=1:6
    if I == 5 || I == 6
        Cabec = [Cabec ' %15.3e'];
    else
        Cabec = [Cabec ' %10.5f'];
    end
end
Cabecalho = [Cabecalho Cabec ' \n'];
fprintf(Cabecalho,iter,a,Fa,b,Fb,X,Fx,DeltaX);
%
%       { Calculos necessarios }
while (abs(DeltaX) > toler || abs(Fx) > toler) && (iter < iter_max)
    if Fx < 0
        a = X;
        Fa = Fx;
    else
        b = X;
        Fb = Fx;
    end
    DeltaX = -Fx * (b - a) / (Fb - Fa);
    X = X + DeltaX;
    Fx = f(X);
    iter = iter + 1;
    fprintf(Cabecalho,iter,a,Fa,b,Fb,X,Fx,DeltaX);
end
%
%   teste de convergência 
if (abs(DeltaX) <= toler) || (abs(Fx) <= toler)
    CondErro = 0;
else
    CondErro = 1;
end
Raiz = X;
%
%   { Saida de dados }
disp(' ');
disp (['Raiz = ' num2str(Raiz)]);
disp (['iter = ' num2str(iter)]);
disp (['CondErro = ' num2str(CondErro)]);
disp(' ');
%
% Fim algoritmo
int=linspace(0,1,1e3);                                                     % obtendo vetor de "xmin" até "xmax" com 1000 componentes.
y=f(int);                                                                  % "y" recebe a função aplicada nos pontos do vetor "int".
figure(1),plot(int,y,'LineWidth',2);                                       % plotanto figura.
axis([0 1 -2 2]);                                                          % delimitando a caixa dos eixos.
grid on;                                                                   % visualizar grades.
xlabel(' eixo das abicissas ');                                            % rotulo no eixo "x".
ylabel(' eixo das ordenadas ');                                            % rotulo no eixo "y".
title ('e^x -4*x^2');                                                      % titulo Ã© a função convertida em caracter.

