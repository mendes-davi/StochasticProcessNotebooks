clear all; close all; clc;

N = 100; % comprimento (dimensão do contradomínio do processo)
M = 1000;

x = randn(N, M); % M realizações de um processo gaussiano não-correlato
                 % r[n] = delta[n]

PSDx = zeros(N, 1);
for k = 1:M
    X = fft(x(:, k));
    PSDx = PSDx + ((abs(X).^2) / N)/M;
end

plot(linspace(-0.5, 0.5, length(PSDx)), fftshift(PSDx));
axis([-0.5 0.5 0 3]);
xlabel('Freq. linear normalizada f');
ylabel('PSD_X(f)');

h = fir1(10, [0.23 0.31]*2); % passa faixas projetado por janelamento de hamming

y = zeros(N+length(h)-1, M);
PSDy = zeros(size(y, 1), 1);
for k = 1:M
    y(:,k) = conv(h, x(:,k));
    Y = fft(y(:, k));
    PSDy = PSDy + ((abs(Y).^2) / (N+length(h)-1))/M;
end

plot(linspace(-0.5, 0.5, length(PSDy)), fftshift(PSDy));
axis([-0.5 0.5 0 3]);
xlabel('Freq. linear normalizada f');
ylabel('PSD_Y(f)');
