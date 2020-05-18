% Algoritmo M�todo de Gauss
clear all;close all;clc;
A=input('Entre com a matriz A: ');
b=input('Entre com o vetor b: ');
n=length(b);
for j=1:n
    for i=(j+1):n
        M(i)=A(i,j)/A(j,j);
       for w=j
            A(i,w)=A(i,w)-A(j,w)*M(i);
            b(i)=b(i)-b(j)*M(i);
       end    
    end
end

x(n)=b(n)/A(n,n);
for i=(n-1):-1:1
    soma=0;
    for j=(i+1):n
        soma=soma+ A(i,j)*x(j);
    end    
    x(i)=(b(i)-soma)/A(i,i);
end    