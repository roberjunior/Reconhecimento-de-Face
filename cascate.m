
%------------------Trabalho de Conclusão de Curso-----------------------%
%                 Universidade Federal de Pelotas                       %
%                    Engenharia Eletrônica                              %
%    Sistema de trava eletronica controlada por reconhecimento facial   %
%              Rober de Jesus Pinho Sant'Ana Junior                     %
%-----------------------------------------------------------------------%


close all;
clear all;
%core();
%FaceDetector aplica o objeto CascadeObjectDetector e suas 
%delimitacoes de tamanho
faceDetector = vision.CascadeObjectDetector('UpperBody');    
faceDetector.MinSize = [50 50];
faceDetector.MergeThreshold = 7;
%Pasta onde se encontram as imagens de treinamento

%Lê a imagem a qual sera aplicada a detecção de face
I = cell(1,10);
path = 'C:\Users\rober-jr\Documents\MATLAB\tccOK\FaceDatabase\c2';
faceDados = dir(fullfile(path, '*.jpg'));
for i = 1:10
    
    L=dir(strcat('C:\Users\rober-jr\Documents\MATLAB\tccOK\FaceDatabase\c2')); % the path tht u hv imges
    I{i} = imread(sprintf('L%d.jpg',i));
    imtool(m);
    Im= imresize(I{i}, 0.7);
    %Objeto de detecção da face na determinada imagem 
    faceDetector = vision.CascadeObjectDetector('FrontalFaceLBP','MergeThreshold',12);    
    bbox1 = step(faceDetector, Im);
    Iface = insertObjectAnnotation( Im, 'rectangle',bbox1,'FACE');
    %Corta somentte a face e salva com tons de cinza
    Icrop = imcrop(Iface, bbox1);
    Im2= imresize(Icrop,0.7);
    Igray = rgb2gray(Icrop);
    I2 = im2bw(Igray ,0.5);
    imshow(I2)
  imwrite(I{i},sprintf('Z%d.jpg',i))
  

end    



