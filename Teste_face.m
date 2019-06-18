%------------------Trabalho de Conclus�o de Curso-----------------------%
%                 Universidade Federal de Pelotas                       %
%                    Engenharia Eletr�nica                              %
%    Sistema de trava eletronica controlada por reconhecimento facial   %
%              Rober de Jesus Pinho Sant'Ana Junior                     %
%-----------------------------------------------------------------------%
%%Test face
clc;
clear all; 

[fname path] = uigetfile('.jpg','Open face for training');

fname = strcat(path, fname);
im = imread(fname);
%im = rgb2gray(im);
imshow(im);
title('Face entrada');
c = input('click para testar!');
%%
Ftest= galleryTraining(im);
%%
load dbnew.mat
Ftrain = dbnew(:,1:2);
Ctrain = dbnew(:,3);
for(i=1: size(Ftrain, 1))
    dist(i, :)= sum(abs(Ftrain(i,:)-Ftest));
    
end
Min = min(dist);
if(Min<3)
    m = find(dist==Min,1);
    det_class=Ctrain(m);
    msgbox(strcat('Classe detectada',num2str(det_class)));%Indica se a pessoa � registrada
else 
    msgbox('Essa pessoa n�o esta habilitado para entrar!');% indica se a pessoas n�o � registrada
    
end