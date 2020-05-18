% Leitura de arquivos ".mat"
clear all
close all
clc
passo = 10 ;  
file = 'depressao_alastrante_vsig_lim_02_ab';
load(file) ;
tempo = passo* tempo ;
figure(1),plot(rota_y,rota_x,'-r') ;
axis([0 901 0 901]) ;
title('orbita do vortice') ;
%for i=1:10:length(rota_y)
% figure(2),plot(rota_y(1:i),rota_x(1:i));
% hold off;
% title(i);
% axis([0 901 0 901]);
% pause(0.14),
%title('orbita do vortice') ;
%end
%axis tight
%hold on
figure(3),plot(tempo,rota_x,'-r') ;
axis([min(tempo) max(tempo) 0 901]) ;
xlabel('evlocao temporal','Fontsize',14) ;
ylabel('posicao em X no tempo','Fontsize',14) ;
figure(4),plot(tempo,rota_y,'-r') ;
axis([min(tempo) max(tempo) 0 901]) ;
xlabel('evlocao temporal','Fontsize',14) ;
ylabel('posicao em Y no tempo','Fontsize',14) ;
figure(5),comet3(tempo,rota_y,rota_x) ;
title('posicao do vortice no tempo')
figure(6),plot3(tempo,rota_y,rota_x) ;
colormap
grid off
axis vis3d
