%Ploting the Quantized signal
t = linspace(0, length(x_reconstructed)/Fs_samp, length(x_reconstructed));
plot(t, x_reconstructed);
xlabel('Time');
ylabel('Amplitude');
title('Quantized speech signal');