%ALGORITMO BISSEÇÃO
%Objetivo: Calular a raiz de uma equação pelo método de bisseção
%Entrada de dados
clc
clear all
syms x; %apresenta  valor simbólico
a=input('Entre com o limite inferior: ');
b=input('Entre com o limite superior: ');
Toler=input('Entre com o valor de Tolerância: ');
IterMax=input('Entre com o N° máximmo de iterações: ');
f=input('Entre com a função desejada: ');
f(x)=inline(f);
Fa=feval(f,a);
Fb=feval(f,b);
if (Fa*Fb>0);
    disp('A função não muda de sinal nos extremos do intervalo informado')
    break
end
   DeltaX=abs(b-a)/2;
   Iter=0;
   % Matriz dos resultados
   saida_dados1(1,1)=a;
   saida_dados1(1,2)=b;
   saida_dados1(1,3)=Toler;
   saida_dados1(1,4)=IterMax;
   disp(saida_dados1);
   X=(a+b)/2;
   Fx=feval(f,X);
   saida_dados2(1,1)=Iter;
   saida_dados2(1,2)=a;
   saida_dados2(1,3)=Fa;
   saida_dados2(1,4)=b;
   saida_dados2(1,5)=Fb;
   saida_dados2(1,6)=X;
   saida_dados2(1,7)=DeltaX;
   disp(saida_dados2);
   while((DeltaX>Toler)||(abs(Fx)>Toler))&&(Iter<IterMax)
       if (Fa*Fx>0)
           a=X;
           Fb=Fx;
       else
           b=X;
           Fb=Fx;
       end
       DeltaX=DeltaX/2;
       Iter=Iter+1; % n° de ietrações 
       X=(a+b)/2;
       Fx=feval(f,X);
   saida_dados2(1,1)=Iter;
   saida_dados2(1,2)=a;
   saida_dados2(1,3)=Fa;
   saida_dados2(1,4)=b;
   saida_dados2(1,5)=Fb;
   saida_dados2(1,6)=X;
   saida_dados2(1,7)=DeltaX;
   disp(saida_dados2);

   end
   %saída de dados
   Z=X;%raiz da função indicada
   disp('Raiz: ');
   disp(Z);
   if ((DeltaX<=Toler) &&(abs(Fx)<=Toler))
       CondErro=0;%raiz encontrada
   else
       CondErro=1;% raiz não encontrada
   end
   disp('Erro: ');
   disp(CondErro);
   disp('Iteração: ')
   disp(Iter)
   % Gráfico
   c=input('Entre com o limite inferior do gráfico: ');%limite inferior
   d=input('Entre com o limite superior do gráfico: ');%limete superior
   figure(1),ezplot(f,[c,d]);
   grid on