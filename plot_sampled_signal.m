% Plot the sampled signal
n = 0:length(x_resampled)-1;
t = n*Ts;
stem(t, x_resampled);
xlabel('Time (s)');
ylabel('Amplitude');
title('Sampled speech signal at 8 kHz');