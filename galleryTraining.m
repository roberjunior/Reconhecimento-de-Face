%Funcao galleryTraining
function [F] = galleryTraining(im)
%Variavel de precis�o dupla
im = double(im); 
%Calcula a media da distribui��o de entrada e compara com a media dos valores de cadastrados
m= mean(mean(im));
%Produz o devio padr�o de cada compara��o de imagens ANALIZE ESTATISTICA
s = std(std(im));
%Cria uma matriz com o valores determinados
F= [m s];
