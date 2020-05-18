% Algoritmo {Substituicoes Progressivas}
clear all;close all;clc
M=input('Entre com a matriz aumentada do sistema M: ');                    % Matriz aumentada do sistema.
dim=input('Entre com numero de linhas da matriz M: ');                     % Numero de linhas igual a dimensão da matriz A.
A=M(1:dim,1:dim);                  % Matriz A corresponde a parte quadrada a esquerda de M.
B=M(1:dim,1+dim);                  % Matriz B corresponde a coluna a direita de M.
 x(1)=(B(1))/(A(1,1));             % ja temos o valor de x1
for i=2:dim                        % i inicia em 2 pois ja temos x1
    soma=0;                        % variavel recebe 0 pois é incrementada no laço interno
    for j=1:i-1                    % j varia uma casa a menos que i 
        soma=soma+(A(i,j))*(x(j)); % variavel soma que consiste nos termos que mudamos de lado na igualdade.
    end                            % isso fica mais evidente deido ao sinal negativo na linha abaixo.
    x(i)=(B(i)-soma)/(A(i,i));     % termos a direita da igualdade, cujo denominador era o numero multiplicado por x(i)
end
disp(num2str(x'));                 % um vetor coluna.