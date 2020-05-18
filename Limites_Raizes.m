% Program Limites Raizes
% programa para achar os limites das raizes reais de uma equacao polinomial
% Parametros de entrada : n , c 
%    grau e coeficientes , onde c eh tal que 
%    P(x)= c(1) x^n + c(2) x^(n-1) + ? + c(n) x + c(n+1)
%
% Parametros de saida : L
%  { limites inferior e superior das raizes positivas e negativas, respectivamente }
%
% { Declarar variaveis }
% declare I, J, K, N, T inteiro
% declare Aux , T  real
% declare L[1:N+1] , X[1:100] , Y[1:100] real
%
clear all; close all; clc;
%
% { Entrada de dados }
C(1) = 0;
while (C(1) == 0)
    N = input('Entre com o grau do polinomio P(x) '); disp(' ');
    disp('Entre com os coeficientes na forma [c(n) c(n-1) ... c(1) c(0)]');
    C = input(' ');
    if (C(1) == 0)
        disp(' '); disp(' ');
        disp('Coeficiente c(1) = 0'); disp (' ');
        disp ('Entre com as informacoes novamente');
        pause(3);
        clc;
    end
end
%
%Saida dos dados informados
clc;
disp('Os valores de entrada');
disp(['n = ' num2str(N)]);
disp(['c = ' num2str(C)]);
disp (' ');
%
% { Iniciar variaveis }
T = N + 1;
C(T + 1) = 0;
X = zeros(1,100);
Y = X;
while C(T) == 0
    T = T - 1;
end
%
% { Calculos necessarios }
%           { calculo dos quatro limites das raizes }
for I = 1:4
    if (I == 2) || (I == 4)  % { inversao da ordem dos coeficientes }
        for J = 1:(T/2)
            Aux = C(J);
            C(J) = C(T-J+1);
            C(T-J+1) = Aux;
        end
    else
        if I == 3
            %    { reinversao da ordem e troca de sinais dos coeficientes }
            for J = 1:(T/2)
                Aux = C(J);
                C(J) = C(T-J+1);
                C(T-J+1) = Aux;
            end
            for J = (T - 1):-2:1
                C(J) = - C(J);
            end
        end
    end
    %      { Se C(1) for negativo, entao eh trocado o sinal de todos os coeficientes }
    if C(1) < 0
        for J = 1:T
            C(J) = -C(J);
        end
    end
    %   { calculo de k, o maior indice dos coeficientes negativos }
    K = 2;
    while (C(K) > 0) && (K < T)
        K = K + 1;
    end
    %   { calculo de B, o maior coeficiente negativo em modulo }
    if (K <= T)
        B = 0;
        for J = 2:T
            if (C(J) < 0) && (abs(C(J)) > B)
                B = abs(C(J));
            end
        end
        %   { limite das raizes positivas de P(x)=0 e das equacoes auxiliares }
        L(I) = 1 + nthroot(B/C(1), (K-1));
    else
        L(I) = 1e100;
    end
end
%
% { Saida de dados }
%           { limites das raizes positivas e negativas de P(x) = 0 }
Aux = L(1);
L(1) = 1/L(2);
L(2) = Aux;
L(3) = -L(3);
L(4) = -1/L(4);
disp('produzem o resultado ');
fprintf(['L = %10.4f %10.4f %10.4f %10.4f \n'],L);
disp(' ');
disp('Ou ,');
fprintf(['%10.4f =< Raizes Pos <= %10.4f \n'], L(1),L(2));
fprintf(['%10.4f =< Raizes Neg <= %10.4f \n'], L(3),L(4));
%
%  { Saida grafica do intervalo das possiveis raizes } 
disp(' '); disp(' ');
Aux = input('Deseja ver grafico do polinomio no intervalo? (S ou N) ','s');
Aux = upper(Aux);
if Aux == 'S'
    for I = 1:100
        X = linspace(L(3),L(2),100);
        YY = C(1);
        % Utilizando o procedimento de Horner para avaliar o polin�mio nos pontos
        for II = 2:(N+1)
            YY = YY * X(I) + C(II);
        end
        Y(I) = YY;
    end
    %
    figure(1);
    plot(X,Y);
    grid on; axis tight;
    axis([L(3) L(2) -1 1]);
    xlabel(' X '); ylabel(' P(X) ');
end
%
% Fim algoritmo