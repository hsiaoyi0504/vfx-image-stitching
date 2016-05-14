% inFolder = '../data/our/2/';
% outFolder = '../data/our/2d/';
% imageList = [
%     'IMG_4420.JPG';
%     'IMG_4421.JPG';
%     'IMG_4422.JPG';
%     'IMG_4423.JPG';
%     'IMG_4424.JPG';
%     'IMG_4425.JPG';
%     'IMG_4426.JPG';
%     'IMG_4427.JPG';
%     'IMG_4428.JPG';
%     'IMG_4429.JPG';
%     'IMG_4430.JPG';
%     'IMG_4431.JPG';
% ];
inFolder = '../data/our/chair/';
outFolder = '../data/our/chaird/';
imageList = [
    'DSC00047.JPG';
    'DSC00048.JPG';
    'DSC00049.JPG';
    'DSC00050.JPG';
    'DSC00051.JPG';
    'DSC00052.JPG';
    'DSC00053.JPG';
    'DSC00054.JPG';
    'DSC00055.JPG';
    'DSC00056.JPG';
    'DSC00057.JPG';
    'DSC00058.JPG';
    'DSC00059.JPG';
    'DSC00060.JPG';
    'DSC00061.JPG';
    'DSC00062.JPG';
];


for i=1:size(imageList,1)
    I = imread([inFolder imageList(i,:)]);
    I = imresize(I,0.1);
    imwrite(I, [outFolder imageList(i,:)]);
end