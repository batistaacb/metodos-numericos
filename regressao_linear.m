%Algoritmo de Regressão Linear
%Objetivo: Calcular parâmetros de quadrados mínimos de modelo linear
%múltiplo
N=input('Entre com o valor de N: ');
V=input('Entre com o valor de V: ');
P=input('Entre com o valor de P: ');
X=input('Entre com o valor de X: ');
Y=input('Entre com o valor de Y: ');
%Número de pontos, número de variáveis, número de parâmetros, variáveis
%independentes, variáveis dependentes
%Número de pontos a interpolar, valores a interpolar e tipo de splines
if (V>1)&&((V+1)~=P)
    CondErro=1;
    break
end
%Iniciar Variáveis
CondErro=0;
Vp1=V+1;
Pm1=P-1;
%Cálculos Necessários
%Inclusão de uma coluna de 1's relativa à b0
for I=1:N
    for J=Vp1:(-1):2
        X(I,J)=X(I,J-1);
    end %{J}
    X(I,1)=1;
end %{I}
if V==1&&P>2
    %Se regressão polinomial, então gera potências de x
    for J=2:Pm1
        Jp1=J+1;
        for I=1:N
            X(I,Jp1)=X(I,2)^J;
        end %{I}
    end %{J}
end
%Equações normais
for I=1:P
    for J=1:P
        Soma=0;
        for K=1:N
            Soma=Soma+X(K,I)*X(K,J);
        end %{K}
        Sxx(I,J)=Soma;   %Matriz dos coeficientes
    end %{J}
    Soma=0;
    for K=1:N
        Soma=Soma+X(K,I)*Y(K);
    end %{K}
    Sxy(I)=Soma; %Vetor dos termos independentes
end %{I}
%Algoritmo para a solução do sistema será o de Cholesky
CondErro=0;
L=Sxx;
Det=1;
for J=1:P
    Soma=0;
    for K=1:(J-1)
        Soma=Soma+L(J,K)^2;
    end %{K}
    Tt=L(J,J)-Soma;
    if Tt>0
        L(J,J)=sqrt(Tt);
        R=1/L(J,J);
        Det=Det*Tt;
    else
        CondErro=1;
        disp('A matriz não é definida positiva');
        break
    end
    for I=J+1:P
         Soma=0;
        for K=1:(J-1)
        Soma=Soma+L(I,K)*L(J,K);
        end %{K}
        L(I,J)=(L(I,J)-Soma)*R;
   end %{I}
end %{J}
%Algoritmo de substituições sucessivas
T(1)=Sxy(1)/L(1,1);
for I=2:P
    Soma=0;
    for J=1:(I-1)
        Soma=Soma+L(I,J)*T(J);
    end %{J}
    T(I)=(Sxy(I)-Soma)/L(I,I);
end %{I}
for I=1:P
    for J=1:I
        U(J,I)=L(I,J); %U = Transposta de L
    end %{J}
end %{I}
%Algoritmo substituições retroativas para determinação dos coeficientes
B(P)=T(P)/U(P,P);
for I=(P-1):(-1):1
    Soma=0;
    for J=(I+1):P
        Soma=Soma+U(I,J)*B(J);
    end %{J}
    B(I)=(T(I)-Soma)/U(I,I);
end %{I}
Dm=0;
Sy2=0;
for I=1:N
    U1=0;
    for J=1:P
        U1=U1+B(J)*X(I,J);
    end
    D=Y(I)-U1;
    Dm=Dm+D^2;
    Sy2=Sy2+Y(I)^2;
end %{I}
R2=1-Dm/(Sy2-Sxy(1)^2/N); %Coeficientes de determinação
Sigma2=Dm/(N-P);


    
    
      
        
    