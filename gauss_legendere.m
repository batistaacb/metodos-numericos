%                   algorítmo de Gauss-legendere
% {Objetivo: integrar uma função pelo método de Gauss-legendere}
% {Declarar variáveis}
% {Parametros de entrada a,b,n}
% {limite inferior, limite superior, numero de pontos}
% {Parametros de saída integral, cond_erro}
% {valor da integral e condição de erro, sendo}
% {cond_erro=0, n�o houve erro (n>=1)}
% {cond_erro=1, se (n<1)}
% {entrada de Dados}
clear all;close all;clc
stitle={'i'  't(i)' 'x(i)' 'f(x(i))' 'a(i)'};
syms x
f=input('Entre com uma função f(x)=sin(x)');
a=input('Entre com o limite inferior de integração:  0   ');               % limite inferior
b=input('Entre com o limite inferior de integração:  pi  ');               % limite superior
n=input('Entre com o numero de pontos:  6    ');                           % numero de pontos 
saida=zeros(n,5);                                                          % saida com 5 termos.
stitle={'i'  't(i)' 'x(i)' 'f(x(i))' 'a(i)'};                              % cabeçario para saída de dados.
fx1=inline(f);                                                             % comando para efetuar calculos numericos.
% -------------------------------------------------------------------------
%             calculo dos pesos e abscisas
% -------------------------------------------------------------------------
[avet,tvet,cond_erro]=PesAbsGL1(n);                                        % utilizando function do matlab
if cond_erro ~= 0                                                          % se numero dep ontos 
    break;
end
integral=0;
e1=(b-a)/2;
e2=(a+b)/2;
if rem(n,2)==0
    c1=1;
    c2=0.5;
else
    c1=0;
    c2=1;
end

for i=1:n                         % {Para i} 
    if (i-0.5*(n+c1))<0;
        sinal=-1;
    else
        sinal=1;
    end
    k=fix(i-0.5*(n+1)+sinal*c2);
    if k < 0
        sinal=-1;
    else
        sinal=1;
    end
    t=sinal*tvet(abs(k));                                                  % t recebe sinal de k*tvet(abs(k))
    x=e1*t+e2;
    y=feval(fx1,x);
    c=avet(abs(k));
    integral=integral+y*c;
    saida(i,1)=i;
    saida(i,2)=t;
    saida(i,3)=x;
    saida(i,4)=y;
    saida(i,5)=c; 
end                                % {Fim i}
integral=e1*integral;
% -------------------------------------------------------------------------
%                 saida de dados
% -------------------------------------------------------------------------
disp(stitle);
disp(num2str(saida));
disp(' ');
disp(['integral = ',num2str(integral)]);
disp(' ');
disp(['cond_erro = ',num2str(cond_erro)]);
% =========================================================================
%                  fim algoritmo
% =========================================================================

    
    