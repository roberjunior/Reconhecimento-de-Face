



%% 
dir = fullfile( 'C:\','Users','rober-jr','Documents','MATLAB','tccOK','FaceDatabase','c1');
dir_teste = fullfile( 'C:\','Users','rober-jr','Documents','MATLAB','tccOK','FaceDatabase','Cadastro_1_teste');
%Create the object que gerencia sua imagem
imgSet = [imageSet(fullfile(dir)),...
          imageSet(fullfile(dir_teste))];
minSet = min([imgSet.Count]);      

imgSet = partition(imgSet, minSet, 'randomize');
[training, training_teste] = partition(imgSet, 0.3, 'randomize');
img = read(training(1), 5);
train_size = [size(img, 1), size(img, 2)];
%Aplica o metodo de Otsu para binarizar a imagem com um limite previamente
%escolhido(Valores acim deste limite são pretos e abaixo brancos) 
img_processada = imbinarize(rgb2gray(img));

[hog_2x2, vis2x2] = extractHOGFeatures(img, 'CellSize',[2 2]);
[hog_4x4, vis4x4] = extractHOGFeatures(img, 'CellSize',[4 4]);
[hog_8x8, vis8x8] = extractHOGFeatures(img, 'CellSize',[8 8]);
cellSize = [4 4];
HOGfeature = length(hog_4x4);%Dimensão melhor atribuida para extracao de caracteristicas
figure;

%numImg=> Numero de imsgens presentes em training


trainingFeatures = [];
trainingLabel = [];
for pic=1:numel(training)
    numImage = training(pic).Count;
    features= zeros(numImage, HOGfeature,'single');
    
    for i = 1: numImage
        img = read(training(pic), i);
        img = imresize(img, train_size);
        img_gray = graythresh(img);
        img = im2bw(img, img_gray);
        features(i, : )=extractHOGFeatures(img, 'CellSize',cellSize);
    end
    %Construction label "rótulo" images
    label = repmat({training(pic).Description}, numImage, 1);
    trainingFeatures = [trainingFeatures; features];
    trainingLabel = [trainingLabel; label];
end
%%
testFeatures = [];
testLabel = [];
for pic=1:numel(training_teste)
    numImage = training_teste(pic).Count;
    Tfeatures= zeros(numImage, HOGfeature,'single');
    
    for i = 1 : numImage
        img = read(training_teste(pic), i);
        img = imresize(img, train_size);
        img_gray = graythresh(img);
        img = im2bw(img, img_gray);
        Tfeatures(i, : )=extractHOGFeatures(img, 'CellSize',cellSize);
    end
    %Construction label "rótulo" images
    Tlabel = repmat({training_teste(pic).Description}, numImage, 1);
    testFeatures = [testFeatures; Tfeatures];
    testLabel = [testLabel; Tlabel];
end

%%


%Classifica usando a extração de caracteristicas de cada image
classifica = fitcecoc(trainingFeatures, trainingLabel);
%[testFeatures, testLabel] = helperExtractHOGFeaturesFromImageSet(training_teste, HOGfeature, 'CellSize');

% Make class predictions(previsões) using the test features.
previsao_class = predict(classifica, testFeatures);

% Tabulate the results using a confusion matrix.
Matriz_tabulada = confusionmat(testLabel, previsao_class);

helperDisplayConfusionMatrix(Matriz_tabulada)




%%
%  dir = fullfile( 'C:\','Users','rober-jr','Documents','MATLAB','tccOK','FaceDatabase','Cadastro_1');
%  dir_teste = fullfile( 'C:\','Users','rober-jr','Documents','MATLAB','tccOK','FaceDatabase','Cadastro_1_teste');
%  %Create the object que gerencia sua imagem
%  imgSet = [imageSet(fullfile(dir)),...
%  imageSet(fullfile(dir_teste))];
% %%
% %Display montage of first face 
% figure;
% montage(imgSet(1).ImageLocation);
% title('Image training');
% %%
% PessoaHabilitada = 1;
% QuadroFace = read(imgSet(PessoaHabilitada),1);
% figure;
% for i =1 : size(imgSet, 2)
%     faceList(i)=imgSet(i).ImageLocation(1);
% end
% subplot(1,2,1);imshow(QuadroFace);title('Image face');
% subplot(1,2,2);montage(faceList);
% title('Image double');
% diff = zeros(1,10);
% %%
% % minSet = min([imgSet.Count]);
% % imgSet = partition(faceList, minSet, 'randomize');
% 
% %Divide a imagens em dois gruopos TESTE(80%) e TREINAMENTO(20%)
% [training, test]= partition(imgSet,[0.8 0.2]);
% 
% 
% %Extract do histogram of oriented Gradient features for single face 
% person =5;
% %%
% [hogFeature, visualization]=extractHOGFeatures(read(training(person), 'CellSize', [4 4]));
% 
% figure;
% subplot(2,1,1);imshow(read(training(person),1));title('Input Face');
% subplot(2,1,2);plot(visualization);title('HoG caracteristicas');
