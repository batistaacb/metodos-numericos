% =========================================================================
%                 Escalonamento, obtendo como pivo o numero de maior modulo
% =========================================================================
clear all;close all;clc;
A=input('Entre com a matriz dos coeficientes :  ');                        % Matriz dos coeficientes             
b=input('Entre com a matriz dos termos independentes:  ');                 % Matriz dos termos independentes 
max=length(b);                                                             % Numero de linhas igual a dimensão da matriz A.
r(1:max,1)=0;                                                              % Matriz dos residuos recebe ZErO.
% =========================================================================
%                            METODO PIVOTAL DE GAUSS 
% =========================================================================
M=[A b];                                                                   
for j=1:max-1                                                              % não ha necessidade de escalonar a ultima linha.
      for i=(j+1):max                                                      % (n+1) para iniciar com 2 e M(i,n)≃M(n,n)
          L=M(i,j)/M(j,j);                                                 % Armazenando multiplicadores(LOWEr).
          M(i,:)=-L*(M(j,:))+(M(i,:));                                     % pivoteamento para matriz arbitrária.
      end
end  
U=M(1:max,1:max);                                                          % Matriz triangular superior
D=M(1:max,max+1);                                                          % Matriz B alterada pelas operações elementares.
% =========================================================================
%              METODO DAS SUBSTITUIÇÕES rETrOATIVAS                           
% =========================================================================
x(max)=(D(max))/(U(max,max));                                              % ja conseguimos o ultimo elemento do vetor resposta.
for i=max:-1:1                                                             % passo decrescente ate chegar em 1
    soma=0;                                                                % zerando, pois sua funcao cumulativa é no laço interno
    for j=i+1:max                                                          % j varia de um digito acima de i até o maximo 
        soma=soma+(U(i,j))*(x(j));                                         % variavel cumulativa, elementos a direita da igualdade
    end                                                                    % evidente abaixo,pelo sinal negativo e o denominador
    x(i)=(D(i)-soma)/(U(i,i));                                             %  denominador é o numero que multiplica x(i) na equação
end 
r=b-A*x';
disp('Solução do Sistema'),disp(num2str(x')); 




