%clearing and closing
clc
close all
warning off
fs=8000; %Fs is Sampling frequency in Hertz
ch=1; %mono audio
datatype='uint8';
nbits=16;
Nsecs=3;

%to record audio from external device user recorder function
disp('Start Speaking (max duration 3 seconds)');
recorder=audiorecorder(fs,nbits,ch);
%to stop the recording use recordblocking function
recordblocking(recorder,Nsecs);
disp('Recorded.');

%storing audio in numeric array use getaudiodata function
x=getaudiodata(recorder,datatype);
%to write the audio file
audiowrite('test.wav',x,fs);
%reading the audio file
filename = 'test.wav';
[x,fs] = audioread(filename);

%finding modulating frequency
[s,f,t] = spectrogram(x,hamming(256),128,256,fs);
[dummy, I] = max(abs(s));  %max amp
freq = f(I); %finding corresponding frequency
fm = mean(freq); % taking mean of corres freq to get modulating freq

%display
disp(['The modulating frequency of the audio is: ', num2str(fm), 'Hz']);

% Load speech signal from audio file
[x, Fs] = audioread('test.wav');

% Define sampling frequency and sampling period
Fs_samp = 8000;
Ts = 1/Fs_samp;

% Sample the speech signal
x_resampled = x(1:Fs/Fs_samp:end);

%defining quantization levels
nQBits = 8;
nLevels = 2^nQBits;
% Compute Quantization step size
maxVal = max(abs(x_resampled));
stepSize = maxVal / (nLevels -1);
%Quantize Signals
x_quantized = quantiz(x_resampled, linspace(-maxVal, maxVal, nLevels-1));

%converting quantized signal to orignal amplitude scale
x_reconstructed = (x_quantized - 0.5) * stepSize * 2;

%converting quantized signal to 8 bit binary stream
nBBits = 8;
x_quantized_norm = (x_quantized - min(x_quantized)) / (max(x_quantized) - min(x_quantized));
x_binary = de2bi(round(x_quantized_norm * (2^nBBits-1)), nBBits, 'left-msb');
x_binary_stream = x_binary(:)';
%Displaying binary stream
disp('Binary Stream: ');
disp(num2str(x_binary_stream));

%printing binary stream
hex_output = dec2hex(x_binary_stream);
fid = fopen('output.txt', 'w');
fprintf(fid, '%s', hex_output);
fclose(fid);