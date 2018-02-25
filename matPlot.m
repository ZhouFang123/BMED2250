function matPlot(fname)
    low_cutoff = 5;
    high_cutoff = 60;
    filter_order = 5;
    measure_f = 250;
    val = load(fname);
    y = val(7,:);
    x = linspace(0, 0.004*length(y), length(y));
    y2 = detrend(y);
    rec_y = abs(y2);
    [b1, a1] = butter(filter_order, low_cutoff/measure_f, 'low');
    low_y = filtfilt(b1, a1, rec_y);
    [b2, a2] = butter(filter_order, high_cutoff/measure_f, 'high');
    high_y = filtfilt(b2, a2, rec_y);
    % high_y(1000:4000) = high_y(1000:4000) .* 50;

    rms_high = find_rms(high_y);
    rms_low = find_rms(low_y);
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
    plot(x1(1:70), rms_high(1:70), 'r-');
    hold on
    plot(x1, rms_low, 'b-');
    hold off

    ratio = rms_high./rms_low;
    subplot(2, 2, 4);
    plot(x1, ratio);
end