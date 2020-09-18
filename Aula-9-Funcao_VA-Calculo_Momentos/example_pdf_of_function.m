clear all; close all; clc;
% example_pdf_of_function

N = 10000;
x = rand(N, 1); % N realizações entre 0 e 1.
y = x.^2;

nbins = 1e3;
[epdfy, bins_centers] = pdf_empirical_evaluation(y, nbins); % empirical PDF
yt = linspace(-0.5, 1.5, 10000);
tpdfy = zeros(size(yt));
k = find(yt > 0 & yt < 1);
tpdfy(k) = 1./(2*sqrt(yt(k)));

plot(bins_centers, epdfy);
hold on;
plot(yt, tpdfy, 'r--');
xlabel('y');
ylabel('f_Y(y)');
grid on; grid minor;
 legend('Empirical PDF of function', 'Theoretical PDF of function');

function [epdf, bins_centers] = pdf_empirical_evaluation(x, nbins)
    if ~exist('nbins', 'var') || isempty(nbins)
        nbins = 1000;
    end
    [h, bins_centers] = hist(x, nbins);
    bin_width = (bins_centers(2:end) - bins_centers(1:end-1));
    bin_width = mean(bin_width);
    epdf = (h/length(x))/bin_width;
end
