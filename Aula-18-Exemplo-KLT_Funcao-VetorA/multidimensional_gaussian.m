clear all; close all; clc;

% Para caso bidimensional,
N = 2;
Cxx = [1 0; 0 1];
mu = [0; 0];

x1 = linspace(-3*sqrt(Cxx(1,1)), 3*sqrt(Cxx(1,1)), 100);
x2 = linspace(-3*sqrt(Cxx(2,2)), 3*sqrt(Cxx(2,2)), 100);
[X1, X2] = meshgrid(x1, x2);
tpdf = zeros(size(X1));

for i = 1:size(X1, 1)
    for j = 1:size(X1, 2)
        x = [X1(i,j); X2(i,j)];
        tpdf(i, j) = 1/sqrt((2*pi)^N * det(Cxx)) * exp(-0.5 * (x-mu).' * inv(Cxx) * (x-mu));
    end
end

surf(X1, X2, tpdf)

% Em dimensão superior,
N = 5; % dimensão
M = 10000; % numero de realizações
x = randn(N, M); % cada coluna é uma realização
