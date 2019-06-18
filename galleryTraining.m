%Funcao galleryTraining
function [F] = galleryTraining(im)
%Variavel de precisão dupla
im = double(im); 
%Calcula a media da distribuição de entrada e compara com a media dos valores de cadastrados
m= mean(mean(im));
%Produz o devio padrão de cada comparação de imagens ANALIZE ESTATISTICA
s = std(std(im));
%Cria uma matriz com o valores determinados
F= [m s];
