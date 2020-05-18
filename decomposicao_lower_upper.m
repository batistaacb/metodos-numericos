% =====================================================================================================================
%                 Escalonamento, obtendo como pivo o numero de maior modulo
% Matriz A= [1 -3 2;-2 8 -1;4 -6 5]
% Matriz B= [11;-15;29]
% Solução x=[2;-1;3]
% =====================================================================================================================
clear all % limpa o workspace
close all % fecha todas as abas
clc;      % limpa a tele principal
A=input('Entre com a matriz dos coeficientes: [1 -3 2;-2 8 -1;4 -6 5]   :');            % Matriz dos coeficientes             
B=input('Entre com a matriz dos termos independentes [11;-15;29] :  ');  % Matriz dos termos independentes 
n=length(B);                    % Numero de linhas igual a dimensão da matriz A.
Lower=eye(n);                   % Atribuindo diagonal a Matriz  Lower  
P=eye(n);              % Matriz das permutações
t=1;% Variavel que assegura que na proxima iteração de t, o laço (i e j)vai verificar a coluna e a linha seguinte 
for int=1:(n-1) % Laço interage o pivoteamento com o escalonamento
    j=t;        % Temos que vamos percorrer uma coluna de cada vez no pivoteamento e escalonamento
    Pivo=0;       % Variavel para armazenar dados de "abs(M(i,j)"  tem que ser zerada após uma escalonamento.
    for i=t:n                    % "i" deve percorrer a linha pivotal.
           if abs(A(i,j))> Pivo  % Identificando o maio termo de maior modulo 
           Pivo=abs(A(i,j));     % Armazenando o termo de maior modulo
           l=i;                  % Identificando a linha onde se encontra o termo de maior modulo
           end                   % Abaixo vai ocorrer as permutações de linhas             
    end                         
A_l=A(t,:);                   % Uma variavel A_l guarda a linha na qual vai se encontrar o pivo.
A(t,:)=A(l,:);                % A linha pivotal recebe a linha onde se encontra o termo de maior modulo.    
A(l,:)=A_l;                   % A linha onde se encotrava o termo de maior modulo recebe a variavel.
P_l=P(t,:);                   % Matriz das permutações de linhas  de linas de acordo com as modificações
P(t,:)=P(l,:);                % ocorridas durante escalonamento da Matriz A
P(l,:)=P_l;                   % onde as regras obedecem as mesmas da matriz A       
if t>=2 % se ocorrer uma mudança de linhas em A, a matriz Lower tem que ser informada, pois cada termo da Lower tem um correspondente em U=A escalonada
   L_l=Lower(t,1:(t-1)); % guardando a linha e uma coluna anterior a a "var" atual que pode trocar de posição de acordo com o identificador "a".
   Lower(t,1:(t-1))=Lower(l,1:(t-1));% possivel troca de posição entre entre os multiplicadores de acordo com a pivotação parcial.
   Lower(l,1:(t-1))=L_l; % variavel que armazenou elemento, é colocada na linha "a" até a coluna var-1, de forma que uma linha não sobrescreveu a outra.
end    
% Escalonando e armazenando os multiplicadores na matriz Lower
for i=(j+1):n                          % "i" esta um passo a frente de "pois" não se escalona a linha que contém o pivo.                  
    Lower(i,j)=A(i,j)/A(j,j);              % Armazenando multiplicadores da Matriz LOWER.
    A(i,:)=(-Lower(i,j))*(A(j,:))+(A(i,:));% Escalonando a linha da matriz       
end
Upper=A(1:n,1:n);
t=t+1;
end
B=P*B; % Matriz B é reposicionada de acordo com as permutações de linhas da matriz A.
% METODO DAS SUBSTITUIÇÕES SUCESSIVAS                           
 y(1)=(B(1))/(Lower(1,1));                       % ja temos o valor de x1
for i=2:n                                    % i inicia em 2 pois ja temos x1
    soma=0;                                  % variavel recebe 0 pois é incrementada no laço interno
    for j=1:(i-1)                            % j varia uma casa a menos que i 
        soma=soma+(Lower(i,j))*(y(j));           % variavel soma que consiste nos termos que mudamos de lado na igualdade.
    end                                      % isso fica mais evidente deido ao sinal negativo na linha abaixo.
    y(i)=(B(i)-soma)/(Lower(i,i));               % termos a direita da igualdade em um sistema
end
    Y=y';                                    % Matriz coluna de "y".
%  SUBSTITUIÇÕES REGRESSIVAS                                          
x(n)=(Y(n))/(Upper(n,n));              % ja conseguimos o ultimo elemento do vetor resposta.
for c=n:-1:1                       % passo decrescente ate chegar em 1
    soma=0;                        % variavel soma recebe zero, pois sua funcao cumulativa é no laço interno
    for d=(c+1):n                  % j varia de um digito acima de i até o maximo 
        soma=soma+(Upper(c,d))*(x(d)); % variavel cumulativa que são os elementos deslocados a direita da igualdade
    end                            % isto fica mais evidente na linha abaixo, onde temos o sinal negativo e o denominador
    x(c)=(Y(c)-soma)/(Upper(c,c));     %  denominador é o numero que multiplica x(i) na equação 
end                                % escrevendo o resultado, usando a funcao de matriz transposta, pois a resposta é 
disp('Solução do Sistema'),disp(num2str(x')); 

