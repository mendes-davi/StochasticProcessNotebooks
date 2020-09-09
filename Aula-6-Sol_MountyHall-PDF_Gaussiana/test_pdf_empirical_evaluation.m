clear all; close all; clc;
N = 1e6;
nbins = 1000;
x = randn(N, 1);

% Empirical Method
[epdf, bins_centers] = pdf_empirical_evaluation(x, nbins);

% Theoretical Method
m = 0;
v = 1;
tpdf = 1/sqrt(2*pi*v) * exp(-0.5*(bins_centers-m).^2/v);

% Plots
plot(bins_centers, epdf);
hold on; plot(bins_centers, tpdf, 'r--');
legend('Empirical PDF', 'Theoretical PDF');

% Chi-Square Random Variable
y = x.^2;
figure;
[epdfy, bins_centersy] = pdf_empirical_evaluation(y, nbins);
plot(bins_centersy, epdfy);
grid on;
title('Chi-Square Random Variable');

% Mean and Variance
mu_x = sum(x)/length(x);
mu_y = sum(y)/length(y);
disp(['Sample mean of X: ' num2str(mu_x)]);
disp(['Sample variance of X:' num2str( sum((x-mu_x).^2) / (length(x)-1))]); % len-1 -> non-biased estimator
disp(['Sample mean of x: ' num2str(mu_y)]);
disp(['Sample variance of y:' num2str( sum((y-mu_y).^2) / (length(y)-1))]); % len-1 -> non-biased estimator
% >> test_pdf_empirical_evaluation
% Sample mean of X: -0.00085288
% Sample variance of X:0.99913
% Sample mean of x: 0.99913
% Sample variance of y:2.0004

function [epdf, bins_centers] = pdf_empirical_evaluation(x, nbins)
    if ~exist('nbins', 'var') || isempty(nbins)
        nbins = 1000;
    end
    [h, bins_centers] = hist(x, nbins);
    bin_width = (bins_centers(2:end) - bins_centers(1:end-1));
    bin_width = mean(bin_width);
    epdf = (h/length(x))/bin_width;
end
