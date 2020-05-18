%                  Método iterativo de Gauss-Jacobi
% Aluno: Adilson Carlos Batista  
% Graduando em Engenharia Elétrica pela UFSJ
clear all;close all;clc
A=input('Entre com a matriz dos coeficientes  :  ');
b=input('Entre com a matriz dos termos independentes  :');
max=length(b);                                                             % numero de linhas da matriz A, obtida atravéz do comprimento do vetor B.
M=[A b];                                                                   % Obtendo matriz aumentada do sistema através de concatenação.
id=0;                                                                      % Idenficador de elementos nulos na diagonal principal.
I=eye(max);                                                                % Obtendo uma matriz identidade para possiveis permutações de colunas.
cont=1;                                                                    % Contador que possibilita o pivoteamento parcial.
for int=1:(max-1)                                                          % Laço possibilita posicionarmos os termos de maior grau, na diagonal principal.
    j=cont;                                                                % Temos que vamos percorrer uma coluna de cada vez no pivoteamento e escalonamento
    pivo=0;                                                                % Variavel para armazenar dados de "abs(M(i,j)"  tem que ser zerada após uma escalonamento.
    for i=cont:max                                                         % "i" deve percorrer a linha pivotal.
           if abs(M(i,j))> pivo                                            % Identificando o maio termo de maior modulo 
               pivo=abs(M(i,j));                                           % Armazenando o termo de maior modulo
               linha=i;                                                    % Identificando a linha onde se encontra o termo de maior modulo
           end                                                             % Abaixo vai ocorrer as permutações de linhas             
    end                                                                    % Foi obtida a posição do termo de maior grau.
M_l=M(cont,:);                                                             % Uma variavel A_l guarda a linha na qual vai se encontrar o pivo.
M(cont,:)=M(linha,:);                                                      % A linha pivotal recebe a linha onde se encontra o termo de maior modulo.    
M(linha,:)=M_l;                                                            % A linha onde se encotrava o termo de maior modulo recebe a variavel.
cont=cont+1;                                                               % contador avança para obter o pivoteamento da próxima linha.
end
A=M(1:max,1:max);
b=M(1:max,1+max);
for a=1:max                                                                % Percorrendo todos elementos da diagonal principal.
    if A(a,a)==0                                                           % Para verificar se são diferente de zero.
       id=1;                                                               % Foi encontrado um elemento nulo na diagonal principal.
    end
end    
if id==1
    cont=1;
    M=[A b];
   for int=1:(max-1)                                                       % Laço possibilita posicionarmos os termos de maior grau, na diagonal principal.
       i=cont;                                                             % Temos que vamos percorrer uma coluna de cada vez no pivoteamento e escalonamento
       pivo=0;                                                             % Variavel para armazenar dados de "abs(M(i,j)"  tem que ser zerada após uma escalonamento.
        for j=cont:max                                                     % "i" deve percorrer a linha pivotal.
             if abs(M(i,j))> pivo                                          % Identificando o maio termo de maior modulo 
                pivo=abs(M(i,j));                                          % Armazenando o termo de maior modulo
                coluna=j;                                                  % Identificando a linha onde se encontra o termo de maior modulo
             end                                                           % Abaixo vai ocorrer as permutações de linhas             
       end                                                                 % Foi obtida a posição do termo de maior grau.
          M_c=M(:,cont);                                                   % Uma variavel A_l guarda a linha na qual vai se encontrar o pivo.
          M(:,cont)=M(:,coluna);                                           % A linha pivotal recebe a linha onde se encontra o termo de maior modulo.    
          M(:,coluna)=M_c;                                                 % A linha onde se encotrava o termo de maior modulo recebe a variavel.
          I_c=I(:,cont);                                                   % Os procedimentos realizados 
          I(:,cont)=I(:,coluna);                                           % nas colunas da matriz M
          I(:,coluna)=I_c;                                                 % são repetidos para uma matriz identidade
          cont=cont+1;                                                     % contador avança para obter o pivoteamento da próxima linha.  
   end
A=M(1:max,1:max);
b=M(1:max,1+max);
b=I*b;   
end
for a=1:max                                                                % Percorrendo todos elementos da diagonal principal.
    if A(a,a)==0                                                           % Para verificar se são diferente de zero.
    disp('A reorganização por linhas e colunas foi ineficaz, abortar simulação');
    return
    end
end
for i=1:max
    c=0;
    for j=1:max
        if i~=j
           c=c+A(i,j);
        end    
    end 
    alfa(i)=c/(A(i,i));
end
% =========================================================================
% Construção da Matriz para as Iterações do Método de Gauss-Jacobi
% =========================================================================
for i=1:max
    r=1/A(i,i);                                                            % Multiplicar por "r" é o mesmo que dividir por "A(i,i)".
    for j=1:max
        if i~=j                                                            % O produto dos "x(i)" por "A(i,j)" ocorre se "i" é diferente de "j".
            A(i,j)=A(i,j)*r;
        end
    end
    b(i)=b(i)*r;                                                           % A matriz "b" também é dividida por "A(i,i)".
    x(i)=b(i);                                                             % Com essa atribuição de valor, estamos considerando que "x" inicial é nulo.
end
norma_rel=1e11;                                                            % Atribuindo um valor grande a norma relativa para rodar a primeira iteração
iter=0;                                                                    % Contador para o numero de iterações.
toler=1e-10;                                                               % Erro tolerado.
iter_max=100;                                                              % Numero máximo de iterações para obter a solução do sistema.
while((norma_rel>toler)&&(iter<iter_max))                                  % Erro e o numero de iterações são as condições para interromper a simulação
    iter=iter+1;                                                           % Contando o numero de iterações, um dos critérios de parada.
    for i=1:max                                                            % Percorrendo todas as linhas.
        soma=0;                                                            % Acumular os produtos "A por x", zerar toda vez que percorrer todas as colunas.
        for j=1:max                                                        % Percorrendo todas as linhas.
            if i~=j                                                        % S "i" é diferente de "j".
               soma=soma+(A(i,j))*x(j);                                    % Os indices de "i" são correspondentes as colunas de A(i,j).
            end    
        end
    v(i)=b(i)-soma;                                                        % Valor de "x(i)" atual. 
    end
       norma_num=0;                                                        % Módulo do maior valor de x atual menos o x anterior
       norma_dem=0;                                                        % Módulo do maior valor de x atual.
    for i=1:max
        var=abs(v(i)-x(i));                                                % Uma variavél armazena o valor do maior modulo no numerador.
          if var > norma_num                                               % Se a variavél contém um valor maior que o numerador atual.
             norma_num=var;                                                % O numerador é atualizado com o valor da variavél.
          end 
          if abs(v(i))> norma_dem                                          % Se o valor do modulo de x atual é maior que que norma_dem
             norma_dem=abs(v(i));                                          % O denominador é atualizado. 
          end 
        x(i)=v(i);                                                         % A variavél x é atualizada para próxima iteração.
    end 
    norma_rel=norma_num/norma_dem;                                         % Atualizando o valor da norma relativa.
end 
disp(num2str(x'));
if  norma_rel <= toler
    disp('Convergente');
else    
    disp('Divergente');
end    
disp('Se alfa >=1,O critério das linhas não foi satisfeito, Escreva alfa');
disp(alfa);
    





















