[file,path] = uigetfile('*.png;*.jpg;*.jpeg;*.bmp');
% Pretrained network mobilenetv2 ile ultrason görüntüsü yükleme ve düzenleme
selectedfile = fullfile(path,file);
 I=imread(selectedfile);
I=imresize(I,[224 224]);
net = mobilenetv2

tic
[a,b]=classify(net,I)
sure=toc
[~,idx] = sort(b,'descend');
idx = idx(3:-1:1);
% trained networkteki class isimlerini otomatik almasın diye
classNamesTop = {'benign','malignant','normal'};
scoresTop = b(idx);
barh(scoresTop)
xlim([0 1])
title('3 Tahmin')
xlabel('Olasılık')
yticklabels(classNamesTop)