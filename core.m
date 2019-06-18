
%------------------Trabalho de Conclusão de Curso-----------------------%
%                 Universidade Federal de Pelotas                       %
%                    Engenharia Eletrônica                              %
%    Sistema de trava eletronica controlada por reconhecimento facial   %
%              Rober de Jesus Pinho Sant'Ana Junior                     %
%-----------------------------------------------------------------------%

clear al
close all
cam = webcam;
 preview(cam)
% %Webcam Funcionamento
for i = 1 : 10 
    w = waitforbuttonpress;
    if w == 1
      img = snapshot(cam); 
      imgSize = size(img); 
      imshow(img)
      img= imresize(img, 0.5);
      hold on;
      drawnow
      image(img)
      [fname, path] = uiputfile();
      imwrite(img,sprintf('%d.jpg',i))
    end
end

% %HELP - especificar o time de operation 
 close all;
 clear all;
