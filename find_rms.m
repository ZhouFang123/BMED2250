function rms = find_rms(list)
    % find_rms  Find rms of a given list with 250 length
    %           sublist, and 60% overlap.
    % rms       rms should be an array
    %           rms(1) = root mean square(list(1:250))
    %           rms(2) = root mean square(list(101:350))
    %           rms(3) = root mean square(list(201:450))
    %           rms(4) = ......
    % Test the function using the following cases:
    %   rms(sin(x)) = 1/sqrt(1)
    %   rms(1 when (mod(x, 1) < 0.5), -1 when (mod(x,1) >= 0.5)) = 1
    xx = list;
    rms = [];
    while ~isempty(xx)
       xxnew = xx(1:250);
       rms_new = sqrt((1/250)*(sum(xxnew.^2)));
       rms = [rms rms_new];
       xx = xx(251:end);
    end
end

