% Program Regula Falsi
% programa para calcular a raiz de uma equacao pelo metodo da regula falsi
% Parametros de entrada : a , b , Toler , IterMax 
%    { limite inferior, limite superior, tolerancia e numero maximo de iteracoes } 
%
% Parametros de saída : Raiz , Iter , CondErro
%  { raiz e numero de iteracoes gastas e condicao de erro, sendo: }
%  { CondErro = 0 se raiz foi encontrada e CondErro = 1 em caso contrario }
%
%       { Declarar variaveis }
% declare Iter , IteMax inteiro
% declare A , B , Fa , Fb , X , Fx , DeltaX , Toler , Raiz , T  real
% declare Var , Aux leteral
% declare f funcao numerica
% declare CondErro logico
%
clear all; close all; clc; 
%
%       { Entrada de dados }
disp('Entre com a expressao da funcao usando FUNCOES MATEMATICAS DO MATLAB');
Var = input(' ','s');
%  Transformar informacao literal da expressao em funcao matematica
Aux = ['@(x) ' Var];
f = str2func(Aux);
%
disp(' ');
A = input('Entre com o limite inferior do intervalo onde se encontra a raiz: ');
B = input('Entre com o limite superior do intervalo onde se encontra a raiz: ');
disp(' ');
Toler = input('Entre com a tolerancia desejada: ');
IterMax = input('Entre com o numero máximo de iteracoes desejada: ');
disp(' ');
%  Saida dos dados informados
clc;
disp('Os parametros de entrada');
disp(['A = ' num2str(A)]);
disp(['B = ' num2str(B)]);
disp(['Toler = ' num2str(Toler)]);
disp(['IterMax = ' num2str(IterMax)]);
disp(' ');
%
% Saida grafica dos dados informados
H1 = figure(1);
set(H1,'position',[170 100 900 600]);
XX = linspace(A,B,100);
plot(XX,f(XX),'LineWidth',2);
grid on; axis tight; axis square;
xlabel(' x '); ylabel(' f(x) '); title ( Var );
grid on; axis square; axis tight; disp(' ');
%
disp(' ');
Aux = input('Deseja mudar intervalo informado? (S ou N) ','s');
Aux = upper(Aux); disp(' ');
clc;
while Aux == 'S'
    A = input('Entre com novo limite inferior de X ');
    B = input('Entre com novo limite superior de X ');
    disp(' ');
    H1 = figure(1);
    set(H1,'position',[170 100 900 600]);
    XX = linspace(A,B,100);
    plot(XX,f(XX),'LineWidth',2);
    grid on; axis tight; axis square;
    xlabel(' x '); ylabel(' f(x) '); title ( Var );
    grid on; axis square; axis tight; disp(' ');
    %
    disp(' ');
    Aux = input('Deseja mudar intervalo informado? (S ou N) ','s');
    Aux = upper(Aux); disp(' ');
end
%
%       { Iniciar variaveis }
clc;
disp('Os parametros de entrada');
disp(['A = ' num2str(A)]);
disp(['B = ' num2str(B)]);
disp(['Toler = ' num2str(Toler)]);
disp(['IterMax = ' num2str(IterMax)]);
disp(' ');
%
% Avaliar a funcao informada nos pontos A e B
Fa = f(A);
Fb = f(B);
if Fa * Fb > 0
    disp(' ');
    disp('Funcao nao muda de sinal nos extremos do intervalo dado');
    disp('Programa encerrado');
    break
end
%
if Fa > 0
    T = A;
    A = B;
    B = T;
    T = Fa;
    Fa = Fb;
    Fb = T;
end
%
Iter = 0;
X = B;
Fx = Fb;
DeltaX = -Fx * (B - A) / (Fb - Fa);
X = X + DeltaX;
Fx = f(X);
%     Saida de dados do cabeçalho da tabela e linha de título
disp('Produzem os resultados'); disp(' ');
fprintf('Calculo de raiz de equacao pelo metodo Regula Falsi \n');
Cabecalho = 'Iter \t a \t\t\t Fa \t\t b \t\t Fb \t\t x \t\t\t Fx  \t\t\t DeltaX \n';
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
fprintf(Cabecalho,Iter,A,Fa,B,Fb,X,Fx,DeltaX);
%
%       { Calculos necessarios }
while (abs(DeltaX) > Toler || abs(Fx) > Toler) && (Iter < IterMax)
    if Fx < 0
        A = X;
        Fa = Fx;
    else
        B = X;
        Fb = Fx;
    end
    DeltaX = -Fx * (B - A) / (Fb - Fa);
    X = X + DeltaX;
    Fx = f(X);
    Iter = Iter + 1;
    fprintf(Cabecalho,Iter,A,Fa,B,Fb,X,Fx,DeltaX);
end
%
%   teste de convergência 
if (abs(DeltaX) <= Toler) || (abs(Fx) <= Toler)
    CondErro = 0;
else
    CondErro = 1;
end
Raiz = X;
%
%   { Saida de dados }
disp(' ');
disp (['Raiz = ' num2str(Raiz)]);
disp (['Iter = ' num2str(Iter)]);
disp (['CondErro = ' num2str(CondErro)]);
disp(' ');
%
% Fim algoritmo
