clc;
clear;

% مسیرها
dbFolder = fullfile(pwd, 'DB');
excelFile = fullfile(pwd, 'book.xlsx');

% خواندن فایل اکسل
[~, ~, raw] = xlsread(excelFile);
fileNames = raw(:,1);  % ستون اول: نام فایل‌ها
keywordsRaw = raw(:,2); % ستون دوم: کلمات کلیدی

% تبدیل پایگاه داده  به ساختار مناسب
n = length(fileNames);
db = struct([]);
for i = 1:n
    db(i).name = fileNames{i};
    keywords = strsplit(lower(keywordsRaw{i}), '_'); % کلمات کلیدی به صورت lower
    db(i).keywords = keywords;
end

% گرفتن کلمات جستجو از کاربر
query = input('کلمه یا کلمات کلیدی مورد نظر را وارد کنید (با فاصله جدا کنید): ', 's');
queryWords = strsplit(lower(strtrim(query)));

% جستجو و امتیازدهی
scores = zeros(n, 1);
for i = 1:n
    matchCount = sum(ismember(queryWords, db(i).keywords));
    scores(i) = matchCount;
end

% فیلتر کردن نتایج با حداقل یک تطابق
validIdx = find(scores > 0);
if isempty(validIdx)
    disp('هیچ تصویری با کلمه(های) کلیدی مورد نظر یافت نشد.');
else
    % مرتب‌سازی بر اساس امتیاز
    [~, sortIdx] = sort(scores(validIdx), 'descend');
    sortedIdx = validIdx(sortIdx);
    
    % نمایش نتایج
    figure;
    for i = 1:min(length(sortedIdx), 10) % حداکثر 10 تصویر نمایش بده
        imgPath = fullfile(dbFolder, db(sortedIdx(i)).name);
        img = imread(imgPath);
        subplot(2,5,i); imshow(img);
        title(strrep(db(sortedIdx(i)).name, '_', '\_'));
    end
end
