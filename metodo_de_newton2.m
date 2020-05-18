% Método de Newton
close all
clear all
clc
%               {Parâ¢metros de entrada}
eu = 2.718312812 ;                                                         % numero de Euller
iter=0;                                                                    % variavel que vai contar as iterações recebe zero.
toler=1e-10;                                                                % tolerÃ¢ncia para proximidade da raiz exata.
iter_max=500;                                                              % numero mÃ¡ximo de iterações.
x_o= .5 ;                                                                  % um dado inicial que se aproxima da solução.
dom =[-1 2] ;                                                               % intervalo onde obter a raiz.
syms x;                                                                    % definroto "x" como variavel simbolica.
f= eu^(-x.^2) -cos(x) ;                                                          % inserindo função em linguagem Matlab.
df=diff(f);                                                                % derivada de primeira ordem da função "f(x)".
var=('eu^(-x.^2) -cos(x)');                                                       % função "f" se torna caracter para rotular grafico.
f=inline(f);                                                               % contrÃ³i um objeto de função interna para "f(x)".
df=inline(df);                                                             % contrÃ³i um objeto de função interna para "df(x)".
Fx = feval(f,x);                                                           % utilizando feval para funÃ§Ãµes que possuuem 
DFx = feval(df,x);                                                         % variaveis simbolicas.
Fx = f(x_o);                                                               % variavel "Fx" recebe valor da função em "x".
DFx = df(x_o);                                                             % variavel "DFx" recebe valor da função em "x".
x=x_o;                                                                     %variavel simbolica "x" recebe valor numÃ©rico.
delta_x=-Fx/DFx;
disp('Produz os resultados'); disp(' ');                                   % Saida de dados do cabecalho da tabela e linha de titulo
fprintf('saida de dados \n');                                              % Obtendo cabeçalho para saida de dados.
rotulo = ' iter      x        DFx         Fx        delta_x \n';           % indices da saida dos dados numericos.
fprintf(rotulo)                                                            % escreva os indices fixos para saida dos dados 
rotulo = '%3i ';                                                           % formato especial para função "fprintf".
rot = '%10.3f';                                                            % formato fixo, com com numero de digitos a direita do ponto.
for I=1:3
    rot = [rot ' %10.3f'];                                                 % campo com 10 digitos sendo 3 a direita do ponto.
end
rotulo = [rotulo rot ' \n'];                                               % imprime valores da matriz com avanço de linhas. 
fprintf(rotulo,iter,x,DFx,Fx,delta_x);                                     % os indices da saida dos parÃ¢metros.
rotulo2 = ['%3i ' rot ' \n'];                                              % "\n Ã© new line", ou seja, os proximos valores serÃ£o na linha abaixo.
for t=1:iter_max                                                           % utilizando laço "para faÃ§a" como "repita", pois vai ser abortado pelo comando break.
    iter=iter+1;                                                           % quantas iterações formam necessarias ou se foi insuficiente.
    delta_x=-Fx/DFx;                                                       % o incremento Ã© o negativo da função no ponto dividido pela derivada no ponto.
    x=x+delta_x;                                                           % valor de x Ã© atulizado somando o incremento no ponto de x anterior.
    Fx=f(x);                                                               % função F recebe o valor da função no novo ponto de x atualizado.
    DFx=df(x);                                                             % derivada DFx recebe o valor da função no novo ponto de x atualizado. 
    if ((abs(delta_x)<=toler)&&(abs(Fx)<=toler)||(DFx==0)||(iter==iter_max)) % teste logico que determina se o laço repita vai prosseguir ou nÃ£o
        break                 
    end   
    fprintf(rotulo2,iter,x,DFx,Fx,delta_x);                                % saida dos dados numericos.
end    
if((abs(delta_x)<=toler)&&(abs(Fx))<=toler)                                % TESTE DE CONVERGENCIA.
    cond_erro=0;
    disp('condição de erro'), disp(cond_erro);                             % houve CONVERGENCIA na soluÃ§Ã£o do sistema nessas condiÃ§Ãµes.    
else
    cond_erro=1;
    disp('condiçãoo de erro'), disp(cond_erro);                             % houve DIVERGENCIA na soluÃ§Ã£o do sistema nessas condiÃ§Ãµes.
end    
raiz = x;                                                                  % raiz da equação no intervalo desejado.
disp('raiz'),disp(raiz);
int=linspace(min(dom),max(dom),1e3);                                       % obtendo vetor de "xmin" atÃ© "xmax" com 100 componentes.
y=f(int);                                                                  % "y" recebe a função aplicada nos pontos do vetor "int".
figure(1),plot(int,y,'LineWidth',2);                                       % plotanto figura.
axis([min(dom) max(dom) -1 2]);                                            % delimitando a caixa dos eixos.
grid on;                                                                   % visualizar grades.
xlabel(' eixo das abicissas ');                                            % rotulo no eixo "x".
ylabel(' eixo das ordenadas ');                                            % rotulo no eixo "y".
title ( var );                                                            % titulo Ã© a função convertida em caracter.












