function [avet,tvet,cond_erro]=PesAbsGL1(n)
% ========================================================================
% Algoritmo pesAbsGL 
% -------------------------------------------------------------------------
% Objetivo : Calcular pesos e abscissas para a equaaao de Gauss-Legendre
% -------------------------------------------------------------------------
% parametros de entrada n, namero de pontos
% parametros de saada A , T , CondErro, pesos , abscissas e condiaao de 
% erro, sendo CondErro = 0 , se nao houve erro (n >= 1)
% CondErro = 1 , se (n < 1}, 
% -------------------------------------------------------------------------
% Entrada de dados
% -------------------------------------------------------------------------
% Consistancia dos parametros

if n < 1
    cond_erro=1;   
end

cond_erro=0;
%pi=3.14159265358979323846;
m=fix(0.5*(n+1));                                                          % m é o numero inteiro a esquerda de meio de (n+1)                                                        
enquanto=1;                                                                % variavel uxiliar par o lço nuanto faça.                                                   
% Calculos necessarios 
for i=1:m 
    z=cos(pi*(i-0.25)/(n + 0.5));
    while enquanto == 1       
        p1=1;
        p2=0;
        for J=1:n 
            p3=p2;
            p2=p1;
            % polinamio de Legendre no ponto z 
            p1=((2*J-1)*z*p2-(J-1)*p3)/J;
        end % J
        % Derivada do polinamio de Legendre no ponto z
        pp=n*(z*p1-p2)/((z^2)-1);
        z1=z;
        % matodo de newton para calcular zeros do polinamio
        z=z1-p1/pp;
        if abs(z-z1)<1e-15
            break
        end
    end
    tvet(m+1-i)=z; % Abscissa
    avet(m+1-i)=2/((1-(z^2))*(pp^2)); % peso
    % Somente as raazes nao negativas sao calculadas devido a simetria
end % i

% =========================================================================
% Fim Algoritmo
% =========================================================================

        