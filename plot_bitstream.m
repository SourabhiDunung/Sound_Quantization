% Generate random binary bit stream
bitstream = randi([0 1], [1 1000]); % 1000 bits

% Plot bit stream transitions over time
figure;
plot(1:length(bitstream), bitstream, 'LineWidth', 2);
xlabel('Time');
ylabel('Bit State');
ylim([-0.1 1.1]);
title('Bit Stream ');
