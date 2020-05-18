%                       Leitura Matricial
%         Simulação da Dinâmica Espaço Temporal de Espirais de 
%           Ondas de Exitação no Sistema Nervoso Central
% Aluno: Adilson Carlos Batista
% Graduando em Engenharia Elétrica na UFSJ
% Laboratório de Neurociência Experimental e Computacional
% Créditos ao Doutorando Kleison Tadeu
close all                                                                  % fecha janelas de gráfico.
clear all                                                                  % limpa variáveis do workspace.
clc                                                                        % limpa tela do comand window.
passo = 10 ;                                                               % passo discreto na leitura em Matlab.
zoom = 6 ;                                                                 % zoom de zoom no entorno do vórtice.
defasagem = 2 ;                                                            % defasagem nos pacotes paar subtração matricial.
filtro = 0.4 ;                                                             % filtro na obtenção do vórtice.
pacote = 390 ;                                                             % numero de pacotes.
open_1 = 30 ;                                                              % primeiro arquivo a ser aberto para onda de DA.
max = 901 ;                                                                % dimensão da matriz.
iteracao = 2e5 ;                                                           % numero de iterações.
n_amostra = 100 ;                                                          % numero de amostras em cada pacote.
int_amostra = 10 ;                                                         % intervalo em cada amostra ao salvar em ".dat".
inteiro_real = 32000 ;                                                     % conversão de inteiro para real.
ev_tempo = open_1*n_amostra*passo ;                                        % instante temporal em iterações que o pacote esta sendo aberto.                                                           
cont = 1 ;                                                                 % contar no teste lógico na obtenção do vórtice.
dd = 50 ;                                                                  % criar uma matriz maior que a resolução devido ao zoom do vórtice.
dj = 50 ;                                                                  % artíficio utilizado para mudança de pacote.
arq1 = 1 ;                                                                 % arquivo 1, utilizado na operação de imagens.
arq2 = 1 ;                                                                 % arquivo 2, utilizado na operação de imagens.
dim = max*max*n_amostra ;                                                  % dimensão dos dados gravados.
contador = open_1 ;                                                        % contador para o titulo da figura.
path  = '/media/DADOS/Adilson_Fortran/' ;                                  % caminho se o arquivo não estiver onde os dados estão.
pasta = 'teste_5/'  ;                                                      % pasta a ser lida.
nome = 'depressao_exe16_alastrante_5_teste_' ;                             % nome do arquivo.
nome_rota = 'rota16_5_teste.mat'   ;                                       % rota do vórtice a ser gravada.
nome_figura = 'figura16_5_teste'  ;                                        % nome da figura a ser salva.
n_zeros = '000000'     ;                                                   % numero de zeros do primeiro arquivo a ser gravado.
if dj  >  n_amostra                                                        % Distancia temporal entre as ondas.
    d_fase  =  fix(dj/n_amostra) ;                                         % se a fase é maior que o número de amostra.
else                                                                       % senão a defasagem pode ser de "defasagem" pacotes.
    d_fase  =  defasagem ; 
end
u = dj ; 
while (u  >  n_amostra)
    u  =  u - n_amostra ; 
end
%        Tecnica para detectar rotas descontinuas
arquivo = [path pasta nome n_zeros num2str(open_1) '.dat'] ; 
fid = fopen(arquivo,'r','n') ; 
M_0 = fread(fid,[1,dim],'integer*2') ; 
fclose(fid) ; 
M_1 = reshape(M_0,max,max,n_amostra)/inteiro_real ; 
clear M_0
figure(1),imagesc(M_1(:,:,10)) ;  
colormap jet
title(num2str(cont)) ; 
p = fix(ginput(1)) ; 
xc = p(2) ; 
yc = p(1) ; 
% =========================================================================
%        Iniciando processamento de imagens e obtenção do vórtice
% =========================================================================
for i  =  open_1:pacote                                                    % para i variando do primeiro ao ultimo pacote da DA.
    contador = contador + 1 ;                                              % contador para nomear a figura de saída de imagem.
    if i < 10 ; nzeros = '0000000' ; end
    if (i  >=  10 && i < 100) ; nzeros = '000000' ; end
    if (i  >=  100 && i < 1000) ; nzeros = '00000' ; end
    if (i  >=  1000 && i < 10000) ; nzeros = '0000' ; end
    if (i  >=  10000 && i < 100000) ; nzeros = '000' ; end
    if (i  >=  100000 && i < 1000000) ; nzeros = '00' ; end
    arq1 = i ;                                                             % arquivo 1 recebe pacote na iteração "i".
    arq2 = i + d_fase ;                                                    % arquivo 1 recebe pacote na iteração "i + d_fase "
    arquivo1 = [path pasta nome nzeros num2str(arq1) '.dat'] ; 
    fid = fopen(arquivo1,'r') ; 
    M_2 = fread(fid,[1,dim],'integer*2')/inteiro_real ; 
    fclose(fid) ; 
    M_3 = reshape(M_2,max,max,n_amostra) ; 
    
    if arq2 < 10 ; nzeros = '0000000' ; end
    if (arq2  >=  10 && arq2 < 100) ; nzeros = '000000' ; end
    if (arq2  >=  100 && arq2 < 1000) ; nzeros = '00000' ; end
    if (arq2  >=  1000 && arq2 < 10000) ; nzeros = '0000' ; end
    if (arq2  >=  10000 && arq2 < 100000) ; nzeros = '000' ; end

    arquivo2 = [path pasta nome nzeros num2str(arq2) '.dat'] ; 
    fid = fopen(arquivo2,'r') ; 
    M_4 = fread(fid,[1,dim],'integer*2')/inteiro_real ; 
    fclose(fid) ; 
    M_5 = reshape(M_4,max,max,n_amostra) ; 
    novo_arquivo = 'nao' ; 
% Inicando a abertura interna de cada pacote binário que foi nomeado página    
    for open_dat = 1:passo:n_amostra                                       % abrindo os pacotes em ".dat" com amsotragem discreta.
          ev_tempo = ev_tempo + passo ;                                    % instante temporal da posição de acordo com as iterações do modelo matemático.
          open_dat2 = u ;                                                  % a primeira página matricial a ser aberta no arquivo em ".dat" é a de número u.
          open_dat3 = open_dat + dj ;                                      % estipulando condições para "arq2", se "arq1" estiver mudando de pacote.
          
           if ( open_dat2  ==  n_amostra)                                  % se arquivo 2 estivar na ultima página matricial . 
              novo_arquivo = 'nao' ;                                       % novo arquivo receb "não" do tipo string
              u = 0 ;                                                      % "u" retorna para zero.
           end
        
          if(open_dat3 > n_amostra & novo_arquivo  ==  'nao')
             arq2 = i + d_fase ; 
             if (arq2 < 10) ; nzeros = '0000000' ; end
             if (arq2  >=  10 && arq2 < 100) ; nzeros = '000000' ; end
             if (arq2  >=  100 && arq2 < 1000) ; nzeros = '00000' ; end
             if (arq2  >=  1000 && arq2 < 10000) ; nzeros = '0000' ; end
             if (arq2  >=  10000 && arq2 < 100000) ; nzeros = '000' ; end
               arquivo3 = [path pasta nome nzeros num2str(arq2) '.dat'] ; 
               fid = fopen(arquivo3,'r') ; 
               M_4 = fread(fid,[1,dim],'integer*2')/inteiro_real ; 
               fclose(fid) ; 
               M_5 = reshape(M_4,max,max,n_amostra) ; 
               novo_arquivo = 'sim' ; 
          end       
%    Matriz A_2 possui defasagem temporal em relação a A_1.            
           A_1(1:max,1:max) = M_3(1:max,1:max,open_dat) ;                  % A_1 recebendo o pacote no instante da iteração do laço for 
           posicoes_zeros = find(A_1(:,:) <  filtro) ;                     % Pontos cuja concentração é MENOR que a constante de filtragem.
           posicoes_ones = find(A_1(:,:) >= filtro) ;                      % Pontos cuja concentração é MAIOR OU IGUAL que a constante de filtragem.
           A_1(posicoes_zeros) = 0 ;                                       % Pontos cuja concentração é MENOR que o filtro recebem zero. 
           A_1(posicoes_ones) = 1 ;                                        % Pontos cuja concentração é MAIOR OU IGUAL que o filtro recebem um.
           A_2(1:max,1:max) = M_5(1:max,1:max, open_dat2) ;                % A_2 recebendo o pacote com defasagem temporal.
           posicoes_zeros = find(A_2(:,:) <  filtro) ;                     % Pontos cuja concentração é MENOR que a constante de filtragem.
           posicoes_ones = find(A_2(:,:) >= filtro) ;                      % Pontos cuja concentração é MAIOR OU IGUAL que a constante de filtragem.
           A_2(posicoes_zeros) = 0 ;                                       % Pontos cuja concentração é MENOR que o filtro recebem zero.
           A_2(posicoes_ones) = 1 ;                                        % Pontos cuja concentração é MAIOR OU IGUAL que o filtro recebem um.
           P_1 = zeros(max + dd*2,max + 2*dd) ;                            % Matriz maior que a resolução para comportar o zoom do vórtice.
           P_1(dd+1:max+dd,dd+1:max+dd) = A_1(1:max,1:max)-A_2(1:max,1:max) ;  % subtração matricial para obter o vórtice.
           px1 = 0 ; 
           MOD = zeros(dd,dd) ; 
           P_2 = P_1 ; 
          for z1 = 1:(dd*2 + 1) ; 
              for q1 = 1:(dd*2 + 1) ; 
                  z = (z1 + (xc-dd)) ; 
                  q = (q1 + (yc-dd)) ; 
                  ppp_1 = find(P_1(z-zoom:z + zoom,q-zoom:q + zoom) == -1); 
                  n_1 = length(ppp_1) ; 
                  if n_1   ==   0
                      n_1 = NaN ; 
                  end
                  ppp1 = find(P_1(z-zoom:z + zoom,q-zoom:q + zoom) == 1) ; 
                  n1 = length(ppp1) ; 
                  if n1   ==   0
                      n1 = NaN ; 
                  end
                  MOD(z1,q1) = abs(n1-n_1) ; 
                  P_2(z,q) = P_1(z,q) + 5 ; 
                    
              end
          end
          if min(min(MOD)) ~=   NaN
              [px1,py1] = find(MOD == min(min(MOD))) ; 
              tx1 = ev_tempo ; 
          else
              px1 = xc ; 
              py1 = yc ; 
              tx1 = ev_tempo ; 
          end
          px = (px1 + (xc-dd)) ; 
          py = (py1 + (yc-dd)) ; 
          pxaux = mean(px) ; 
          clear px
          px = pxaux ; 
          pyaux = mean(py) ; 
          clear py
          py = pyaux ; 
          tx = tx1 ; 
          P_2 = zeros(max + dd*2,max + 2*dd) ; 
        
          P_2(dd + 1:max + dd,dd + 1:max + dd) = M_5(1:max,1:max, open_dat2) ; 
          figure(1),imagesc(P_1*(1)) ; 
          title(num2str(contador)) ;                                         % titulo dado pelo pacote que esta sendo aberto naquele instante.
          colormap jet
          axis image
          axis off
          hold on
          h1 = plot(yc,xc,'*r') ;                                              % plotando a rota do vórtice do tipo ( * )
          set(h1,'markersize',12) ; 
          hold off
          caxis([-1 0]) ; 
          colorbar ; 
          if (length(px)) > 0 && (length(px1 > 0))
              if(MOD(px1(1),py1(1))  >=  0) ; 
                  pxaux = round(mean(px)) ; 
                  clear px
                  px = pxaux ; 
                  pyaux = round(mean(py)) ; 
                  clear py
                  py = pyaux ; 
                  if cont  ==  1
                      p_y = py(length(py)) ; 
                      p_x = px(length(px)) ; 
                      t_x = tx(length(tx))  ;            
                  elseif cont  >  1
                      p_y = [p_y py(length(py))] ; 
                      p_x = [p_x px(length(px))] ; 
                      t_x = [t_x tx(length(tx))] ; 
                  end
                  cont = cont + 1 ; 
                  hold on
                  h1 = plot(py,px,'*w') ; 
                  set(h1,'markersize',12) ; 
                  hold off
                  xc = px(length(px)) ; 
                  yc = py(length(py)) ; 
                  txc = tx(length(tx)) ; 
              end
              if(cont > 1)
                  if cont > 11
                      rota_x = [rota_x mean(p_x(cont-10:cont-1))] ; 
                      rota_y = [rota_y mean(p_y(cont-10:cont-1))]  ;                    
                  else
                     clear rota_x rota_y
                      rota_x = p_x(1:cont-1) ; 
                      rota_y = p_y(1:cont-1)  ;                                             
                  end
                  tempo = t_x ; 
                  hold on
                  figure(3),plot(rota_y,rota_x,'w','linewidth',2) ; 
                  save(nome_rota,'rota_y','rota_x','tempo') ; 
                  hold off
              end
          end
          u = u + 1 ; 
    end                                                                    % fim do laço que abre pacotes em ".dat".
end
subplot(2,1,1),plot(rota_y,tempo) ; 
subplot(2,1,2),plot(rota_x,tempo) ; 


