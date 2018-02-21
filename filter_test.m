clear
close all
clc

low_cutoff = 5;
high_cutoff = 5;
filter_order = 5;
measure_f = 250;
load('slp32m.mat');
y = val(7,:);
x = linspace(0, 0.004*length(y), length(y));
y2 = detrend(y);
rec_y = abs(y2);
[b1, a1] = butter(filter_order, low_cutoff/measure_f, 'low');
low_y = filtfilt(b1, a1, rec_y);
[b2, a2] = butter(filter_order, high_cutoff/measure_f, 'high');
high_y = filtfilt(b2, a2, rec_y);

rms_high = zeros(1000000/100);
rms_low = zeros(1000000/100);
x1 = zeros(1000000/100);
for i = 1:100:length(y)-250
    % integrate high_y^2 over i to i+249
    % find rms
    % integrate low_y^2 over i to i+249
    % find rms
    % generate x-axix as i/100
    ind = floor(i/100) + 1;
    x(ind) = ind;
    rms_high(ind) = sqrt(trapz(x(i:i+249), high_y(i:i+249).^2)./(x(i+249)-x(i)));
    rms_low(ind) = sqrt(trapz(x(i:i+249), low_y(i:i+249).^2)./(x(i+249)-x(i)));
end
x1(1) = 0;

subplot(2, 1, 1);
plot(x(1:10000), high_y(1:10000), 'r-');
hold on
plot(x(1:10000), low_y(1:10000), 'b-');
hold off

subplot(2, 1, 2);
plot(x(1:10000), y(1:10000), 'b-');
hold on
plot(x(1:10000), low_y(1:10000), 'r-')
hold off