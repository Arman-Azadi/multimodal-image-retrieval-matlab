function h = getHSVHist(img)
    img = imresize(img, [256 256]); % نرمال‌سازی اندازه
    hsv = rgb2hsv(img);
    h = histcounts(hsv(:,:,1), 32, 'Normalization','probability'); % فقط Hue برای سادگی
end