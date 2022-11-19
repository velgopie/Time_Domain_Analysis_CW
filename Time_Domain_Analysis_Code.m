% Import both sets of data into MATLAB
data1 = readtable("data1_trend.txt");
data2 = readtable("data2-amp0.5.txt");

% Setting each column to a variable
data1time = data1.Var1;
data1L = data1.Var2;

data2time = data2.Var1;
data2L = data2.Var2;

% Wavelet Transform to denoise L and L-L0 values
dn_data1L = wdenoise(data1L,4);
dn_data2L = wdenoise(data2L,4);

% Find peaks and location of peaks of the periodic signal data
[pks,locs] = findpeaks(dn_data2L,data2time,"MinPeakDistance",50,"MinPeakHeight",0.4);

% Find period by finding the mean differences between peaks
period = mean(diff(locs)); 

p=sprintf('\nPeriodicity = %.5f',period);disp(p);

% Plot data on a graph
plot(data1time,dn_data1L)
title("Signal Data")
xlabel('Time (sec)')
yyaxis left
ylabel('L')
hold on
yyaxis right
plot(data2time,dn_data2L)
ylabel('L-L0')
plot(locs,pks+0.05,'vk')
legend('data1-trend','data2-amp0.5','Local Peaks')
hold off