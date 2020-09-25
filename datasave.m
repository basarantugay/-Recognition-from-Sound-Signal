clc; clear all; close all;

A = dir('Data/');
no_sample = 160;
Data = [];

for i = 3:size(A, 1)
    isim = A(i).name;
    kelime2 = audioread(fullfile('Data', isim));
    
    half = 0;
    katsayi = [];
    for t = 1:49
        pencere = kelime2(1+half:no_sample+half);
        task = max(abs(fft(pencere)));
        half = (no_sample/2)+half;
        katsayi = [katsayi, task, lpc(pencere, 11)];
    end
    Data = [Data; katsayi];
end
save('Data.mat', 'Data');