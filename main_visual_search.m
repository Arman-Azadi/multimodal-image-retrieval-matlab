clc;
clear;

% مسیر پوشه تصاویر
dbFolder = fullfile(pwd, 'DB');

% انتخاب تصویر با GUI
[filename, pathname] = uigetfile({'*.jpg;*.png;*.bmp','Image Files'}, 'یک تصویر انتخاب کنید');
if isequal(filename,0)
    disp('هیچ تصویری انتخاب نشد.');
    return;
end
queryImgPath = fullfile(pathname, filename);
queryImg = imread(queryImgPath);

% نمایش تصویر ورودی
figure('Name','تصویر ورودی');
imshow(queryImg);
title('تصویر انتخابی شما');

% تبدیل به HSV و استخراج هیستوگرام
queryHist = getHSVHist(queryImg);

% بررسی همه تصاویر در پوشه DB
imgFiles = dir(fullfile(dbFolder, '*.*'));
imgFiles = imgFiles(~[imgFiles.isdir]); % حذف پوشه‌ها

similarities = [];
names = {};

for i = 1:length(imgFiles)
    % ext = extention
    [~, ~, ext] = fileparts(imgFiles(i).name);
    if ~ismember(lower(ext), {'.jpg', '.jpeg', '.png', '.bmp'})
        continue;
    end
    
    imgPath = fullfile(dbFolder, imgFiles(i).name);
    dbImg = imread(imgPath);
    
    try
        dbHist = getHSVHist(dbImg);
    catch
        continue;
    end

    % مقایسه هیستوگرام با استفاده از فاصله Bhattacharyya
    dist = bhattacharyya(queryHist, dbHist);
    
    % یک عنصر به آخر اضافه کردن
    similarities(end+1) = dist;
    names{end+1} = imgFiles(i).name;
end

% مرتب‌سازی نتایج (کمترین فاصله = بیشترین شباهت)
[~, sortIdx] = sort(similarities);
topN = 4; % حداکثر 4 تصویر نمایش داده شود
topIdx = sortIdx(1:min(topN, length(sortIdx)));

% نمایش نتایج
figure('Name','تصاویر مشابه');
for i = 1:length(topIdx)
    img = imread(fullfile(dbFolder, names{topIdx(i)}));
    subplot(3, 3, i);
    imshow(img);
    title(strrep(names{topIdx(i)}, '_', '\_'));
end
