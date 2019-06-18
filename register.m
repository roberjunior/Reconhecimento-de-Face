%------------------Trabalho de Conclusão de Curso-----------------------%
%                 Universidade Federal de Pelotas                       %
%                    Engenharia Eletrônica                              %
%    Sistema de trava eletronica controlada por reconhecimento facial   %
%              Rober de Jesus Pinho Sant'Ana Junior                     %
%-----------------------------------------------------------------------%
%%Taking image
clc;
clear all; 
close all;
[fname path] = uigetfile( '.jpg','Open face for training');
fname = strcat(path, fname);
im = imread(fname);
imshow(im);
title('Face entrada');
c = input('Enter the class ');
%% Feature extraction
F= galleryTraining(im);
try 
    load dbnew;
    F = [F c] ;
    dbnew = [dbnew; F];  
    save dbnew.mat dbnew
catch
    dbnew = [F c];
    save dbnew.mat dbnew
end






