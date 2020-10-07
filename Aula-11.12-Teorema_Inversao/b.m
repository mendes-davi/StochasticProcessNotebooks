clear all; close all; clc;

% x values to test theoretical model
xt = linspace(-2.5, 4.5, 1e4);
f_Xteo = pdf_g(xt);
% Test using our (pseudo) random number generator
N = 1e6;
[x, x_values, f_X] = exampleRandGen(N);

% Plots
plot(x_values, f_X);
hold on;
plot(xt, f_Xteo);
set(findall(gcf,'type','text'), 'FontSize', 30, 'fontWeight', 'bold');
ylabel('f_X');
xlabel('x');
set(gcf, 'Color', 'w');
set(gca, 'FontName', 'Inconsolata Nerd Font', 'FontSize', 20, 'FontWeight', 'bold');
set(gca, 'XMinorTick', 'on', 'YMinorTick', 'on')
set(gca, 'XGrid', 'on', 'YGrid', 'on');
set(gca, 'XMinorGrid', 'on', 'YMinorGrid', 'on');
legend({['Empirical N=' int2str(N)], 'Theoretical'}, 'Location', 'northwest');

%% Using function from exercise B to gen random values
function [x, x_values, f_X] = exampleRandGen(N)
    if ~exist('N', 'var') || isempty(N)
        N = 100;
    end
    u = rand(N, 1);
    x = g(u);
    [f_X, x_values] = pdf_empirical_evaluation(x, min(round(N/10), 1000));
end

function x = g(u)
    x = zeros(size(u));
    x(u == 0) = -2;
    x(u == 1) = 4;
    x(u ~= 0 & u ~= 1) = -2 +6 * sqrt(u(u ~= 0 & u ~= 1));
end

function [p] = pdf_g(x)
    p = zeros(size(x));
    k = find(x > -2 & x < 4);
    p(k) = (x(k)+2)/18;
end

function [epdf, bins_centers] = pdf_empirical_evaluation(x, nbins)
    if ~exist('nbins', 'var') || isempty(nbins)
        nbins = 1000;
    end
    [h, bins_centers] = hist(x, nbins);
    bin_width = (bins_centers(2:end) - bins_centers(1:end-1));
    bin_width = mean(bin_width);
    epdf = (h/length(x))/bin_width;
end
