function [mean_hi, mean_low, ratio] = edfPlot(fname)
    [hdr, record] = edfread(fname);
    row = 0;
    for i = 1:length(hdr.label)
        if contains(lower(hdr.label{i}), 'emg')
            row = i;
        end
    end
    fprintf('emg row found\n');
    low_cutoff = 5;
    high_cutoff = 60;
    filter_order = 5;
    measure_f = hdr.frequency(row);
    y = record(row, :);
    x = linspace(0, length(y)/measure_f, length(y));
    y2 = detrend(y);
    rec_y = abs(y2);
    [b1, a1] = butter(filter_order, low_cutoff/measure_f, 'low');
    low_y = filtfilt(b1, a1, rec_y);
    [b2, a2] = butter(filter_order, high_cutoff/measure_f, 'high');
    high_y = filtfilt(b2, a2, rec_y);
    
    [r, c] = size(record);
    rms_high = find_rms(high_y(1:c-mod(c, 10000)));
    rms_low = find_rms(low_y(1:c-mod(c, 10000)));
    x1 = 1:length(rms_low);
    subplot(2, 2, 1);
    plot(x(1:10000), high_y(1:10000), 'r-');
    hold on
    plot(x(1:10000), low_y(1:10000), 'b-');
    hold off

    subplot(2, 2, 2);
    plot(x(1:10000), y(1:10000), 'b-');
    hold on
    plot(x(1:10000), low_y(1:10000), 'r-')
    hold off

    subplot(2, 2, 3);
    plot(x1(1:10000), rms_high(1:10000), 'r-');
    hold on
    plot(x1, rms_low, 'b-');
    hold off

    ratio = rms_high./rms_low;
    subplot(2, 2, 4);
    plot(x1, ratio);
    
    mean_hi = mean(rms_high);
    mean_low = mean(rms_low);
    ratio = mean_hi / mean_low;
end