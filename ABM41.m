%Algorítmo ABM4 (Adams-Bashforth-Moulton)
%Curso:Engenharia Elétrica
%Aluna: Flávia Caroline Pereira            Matrícula: 110950053
%=========================================================================
%Algoritmo:ABM4
%Objetivo:Resolver um PVI pelo método de Adams-Bashforth-Moulton
A=input('Entre com o limite inferior (a): ');
B=input('Entre com o limite superior (b):' );
M=input('Entre como o número de subintervalos (m): ');
Y0=input('Entre com o valor inicial (Y0): ');
f=input('Entre com a função: ','s');
f=inline(f);
H=(B-A)/M;
[VetX,VetY,EG]=DOPRI(A,A+H*3,3,Y0,f); %Função DOPRI

  %Parâmetros de saída de DOPRI retornam em VetX, VetY, Erro
  %Cálculos Necessários

  for I=1:4
      disp(I-1);disp(VetX(I));disp(VetY(I)),disp(EG(I));   
  end %I
  for I=4:M
      X=VetX(I-3);
      Y=VetY(I-3);
      f0=feval(f,X,Y);  %Avaliar f(X,Y)
      X=VetX(I-2);
      Y=VetY(I-2);
      f1=feval(f,X,Y);  %Avaliar f(X,Y)
      X=VetX(I-1);
      Y=VetY(I-1);
      f2=feval(f,X,Y);  %Avaliar f(X,Y)
      X=VetX(I);
      Y=VetY(I);
      f3=feval(f,X,Y);  %Avaliar f(X,Y)
      Ypre=H*(55*f3-59*f2+37*f1-9*f0)/24+VetY(I);
      VetY(I+1)=Ypre;
      VetX(I+1)=A+I*H;
      X=VetX(I+1);
      for J=1:2
          Y=VetY(I+1);
          f4=feval(f,X,Y); %Avaliar f(X,Y)
          Ycor=H*(9*f4+19*f3-5*f2+f1)/24+VetY(I);
          VetY(I+1)=Ycor;
      end %J
      Erro=abs(Ycor-Ypre)*19/270;
      disp(I);disp(VetX(I+1));disp(VetY(I+1));disp(Erro);
  end %I


