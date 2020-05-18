% Program Muller
% programa para calcular a raiz de uma equacao pelo metodo de Muller
%
% Parametros de entrada : a , c , Toler , IterMax 
%    { limite inferior, limite superior, tolerancia e numero maximo de iteracoes } 
%
% Parametros de saida : Raiz , Iter , CondErro
%  { raiz e numero de iteracoes gastas e condicao de erro, sendo: }
%  { CondErro = 0 se raiz foi encontrada e CondErro = 1 em caso contrario }
%
%       { Declarar variaveis }
% declare Iter , IteMax inteiro
% declare A , B , C , Fa , Fb , Fc , X , Fx , DeltaX , Toler , ...
%         Raiz , T , H1 , H2 , R , Z , AA , BB , CC real
% declare Var , Aux leteral
% declare f funcao numerica
% declare CondErro logico
%
clear all; close all; clc; 
%
%       { Entrada de dados }
disp('Entre com a expressao da funcao usando FUNCOES MATEMATICAS DO MATLAB');
Var = input(' ','s');
% Transformar informacao da expressao em funcao 
Aux = ['@(x) ' Var];
f = str2func(Aux);
%
disp(' ');
A = input('Entre com o limite inferior do intervalo onde se encontra a raiz: ');
C = input('Entre com o limite superior do intervalo onde se encontra a raiz: ');
disp(' ');
Toler = input('Entre com a tolerancia desejada: ');
IterMax = input('Entre com o numero m�ximo de iteracoes desejada: ');
disp(' ');
%
% Saida grafica dos dados informados
H1 = figure(1);
set(H1,'position',[170 100 900 600]);
XX = linspace(A,C,100);
YY = zeros(1,length(XX));
plot(XX,f(XX),'LineWidth',2); hold on;
plot(XX,YY,'LineWidth',2,'Color','g');
grid on; axis tight; 
xlabel(' x '); ylabel(' f(x) '); title ( Var );
%
disp(' ');
Aux = input('Deseja mudar intervalo informado? (S ou N) ','s');
Aux = upper(Aux); disp(' ');
clc;
while Aux == 'S'
    close(1);
    A = input('Entre com novo limite inferior de X ');
    C = input('Entre com novo limite superior de X ');
    disp(' ');
    H1 = figure(1);
    set(H1,'position',[170 100 900 600]);
    XX = linspace(A,C,100);
    plot(XX,f(XX),'LineWidth',2); hold on;
    plot(XX,YY,'LineWidth',2,'Color','g');
    grid on; axis tight; 
    xlabel(' x '); ylabel(' f(x) '); title ( Var );
    %
    disp(' ');
    Aux = input('Deseja mudar intervalo informado? (S ou N) ','s');
    Aux = upper(Aux); disp(' ');
end
%
%  Saida dos dados informados
clc;
disp('Os parametros de entrada');
disp(['a = ' num2str(A)]);
disp(['b = ' num2str(C)]);
disp(['Toler = ' num2str(Toler)]);
disp(['IterMax = ' num2str(IterMax)]);
disp(' ');
%
%       { Iniciar variaveis }
%  Avaliar a funcao informada nos pontos A e B
Fa = f(A);
Fc = f(C);
B = (A + C) / 2;
Fb = f(B);
X = B;
Iter = 0;
H1 = C - B;
H2 = B - A;
R = H1 / H2;
T = X;
AA = (Fc - (R + 1) * Fb + R * Fa) / (H1 * (H1 + H2));
BB = (Fc - Fb) / H1 - AA * H1;
CC = Fb;
Z = (-BB + sign(BB) * sqrt(BB^2 - 4*AA*CC)) / (2*AA);
X = B + Z;
DeltaX = X - T;
Fx = f(X);
%
%  Saida de dados do cabecalho da tabela e linha de titulo
disp('Produzem os resultados'); disp(' ');
fprintf('Calculo de raiz de equacao pelo metodo de Muller \n');
Cabecalho = 'Iter \t a \t\t\t b \t\t\t c \t\t x \t\t\t Fx  \t\t\t DeltaX \n';
fprintf(Cabecalho)
Cabecalho = '%3i ';
Cabec = '%10.5f';
for I=1:5
    if I == 4 || I == 5
        Cabec = [Cabec ' %15.5e'];
    else
        Cabec = [Cabec ' %10.5f'];
    end
end
Cabecalho = [Cabecalho Cabec ' \n'];
fprintf(Cabecalho,Iter,A,B,C,X,Fx,DeltaX);
%
%       { Calculos necessarios }
while (abs(DeltaX) > Toler || abs(Fx) > Toler) && (Iter < IterMax)
    if X > B
        A = B;
        Fa = Fb;
    else
        C = B;
        Fc = Fb;
    end
    B = X;
    Fb = Fx;
    Iter = Iter + 1;
    H1 = C - B;
    H2 = B - A;
    R = H1 / H2;
    T = X;
    AA = (Fc - (R + 1) * Fb + R * Fa) / (H1 * (H1 + H2));
    BB = (Fc - Fb) / H1 - AA * H1;
    CC = Fb;
    Z = (-BB + sign(BB) * sqrt(BB^2 - 4*AA*CC)) / (2*AA);
    X = B + Z;
    DeltaX = X - T;
    Fx = f(X);
    fprintf(Cabecalho,Iter,A,B,C,X,Fx,DeltaX);
end
%
Raiz = X;
%
% teste de convergencia 
if (abs(DeltaX) <= Toler) && (abs(Fx) <= Toler)
    CondErro = 0;
else
    CondErro = 1;
end
%
%       { Saida de dados  }
disp(' ');
disp (['Raiz = ' num2str(Raiz)]);
disp (['Iter = ' num2str(Iter)]);
disp (['CondErro = ' num2str(CondErro)]);
disp(' ');
%
% Fim algoritmo
