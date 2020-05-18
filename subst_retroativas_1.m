% Algoritmo {Substituicoes Retroativas}
clear all;close all;clc
M=input('Entre com a matriz aumentada do sistema M: ');                    % Matriz aumentada do sistema.
dim=input('Entre com numero de linhas da matriz M: ');                     % Numero de linhas igual a dimensão da matriz A.
A=M(1:dim,1:dim);                  % Matriz A corresponde a parte quadrada a esquerda de M.
B=M(1:dim,1+dim);                  % Matriz B corresponde a coluna a direita de M.
x(dim)=(B(dim))/(A(dim,dim));      % ja conseguimos o ultimo elemento do vetor resposta.
for i=dim:-1:1                     % passo decrescente ate chegar em 1
    soma=0;                        % variavel soma recebe zero, pois sua funcao cumulativa é no laço interno
    for j=i+1:dim                  % j varia de um digito acima de i até o maximo 
        soma=soma+(A(i,j))*(x(j)); % variavel cumulativa que são os elementos deslocados a direita da igualdade
    end                            % isto fica mais evidente na linha abaixo, onde temos o sinal negativo e o denominador
    x(i)=(B(i)-soma)/(A(i,i));     %  denominador é o numero que multiplica x(i) na equação
end                                % escrevendo o resultado, usando a funcao de matriz transposta, pois a resposta é 
disp(num2str(x'));                 % um vetor coluna.


