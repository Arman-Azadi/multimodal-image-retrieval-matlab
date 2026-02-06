function d = bhattacharyya(h1, h2)
    % فاصله Bhattacharyya برای دو هیستوگرام نرمال‌شده
    d = sqrt(1 - sum(sqrt(h1 .* h2)));
end