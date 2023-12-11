clear
clc
layers = [
    imageInputLayer([100 100 3],"Name","imageinput")
    convolution2dLayer([3 3],8,"Name","conv_1","Padding","same")
    batchNormalizationLayer("Name","batchnorm_1")
    reluLayer("Name","relu_1")
    maxPooling2dLayer([2 2],"Name","maxpool_1","Stride",[1 1])
    convolution2dLayer([3 3],16,"Name","conv_2","Padding","same")
    batchNormalizationLayer("Name","batchnorm_2")
    reluLayer("Name","relu_2")
    maxPooling2dLayer([2 2],"Name","maxpool_2","Stride",[1 1])
    globalAveragePooling2dLayer("Name","gapool")
    fullyConnectedLayer(3,"Name","fc")
     softmaxLayer("Name","softmax")
    classificationLayer("Name","classoutput")];
imds = imageDatastore('ultrasound','IncludeSubfolders',true,'LabelSource','foldernames');
[imdsTrain,imdsTest1] = splitEachLabel(imds,0.7,'randomized');
[imdsTest,imdsValidation] = splitEachLabel(imdsTest1,0.5,'randomized');
% resize yaparak girdiye uyduruyoruz
imdsTrain = augmentedImageDatastore([100 100 3],imdsTrain);
imdsTest = augmentedImageDatastore([100 100 3],imdsTest);
%gamze
imdsValidation = augmentedImageDatastore([100 100 3],imdsValidation);
options = trainingOptions('adam', ...
    'MiniBatchSize',32, ...
    'MaxEpochs',1, ...
    'InitialLearnRate',0.005, ...
    'Shuffle','every-epoch', ...
    'ValidationData',imdsValidation, ...
    'ValidationFrequency',10, ...
    'Verbose',true, ...
    'Plots','training-progress' );
net = trainNetwork(imdsTrain,layers,options);
[Ypred,scores] = classify(net,imdsTest);
accuracy = mean(YPred == imdsTest.Labels)
confusionchart(YPred,imdsTest.Labels)
konf(Ypred,augimds2.Labels)
save egitimli_ag

