%Get Information About Audio File
info = audioinfo("test.wav")
%read audio file
[x,Fs] = audioread("test.wav");
sound(x,Fs);
%plot the audio data
t = 0:seconds(1/Fs):seconds(info.Duration);
t = t(1:end-1);
plot(t,x);
xlabel('Time');
ylabel('Audio Signal');
title('Speech signal');