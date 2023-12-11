[file,path] = uigetfile('*.png;*.jpg;*.jpeg;*.bmp');
% Bizim eğittiğimiz network ile ultrason görüntüsü yükleme ve düzenleme
selectedfile = fullfile(path,file);
 I=imread(selectedfile);
I=imresize(I,[100 100]);

tic
[a,b]=classify(net,I)
sure=toc
[~,idx] = sort(b,'descend');
idx = idx(3:-1:1);
classNamesTop = net.Layers(end).ClassNames(idx);
scoresTop = b(idx);
barh(scoresTop)
xlim([0 1])
title('3 Tahmin')
xlabel('Olasılık')
yticklabels(classNamesTop)