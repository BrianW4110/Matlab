%% Takes an audiofile of a song and determines its danceability based on beat strength, overall tempo, and tempo stability
[x,Fs] = audioread("Daft Punk - One More Time.wav");
x = mean(x,2); % convert from stereo to mono
duration = length(x) / Fs;
minutes = floorDiv(duration,60);
seconds = mod(duration, 60);
sprintf('Duration: %i minutes, %.1f seconds', minutes,seconds)
N = 1024; % window size
overlap = N /2; % 50% overlap
nfft = 2^nextpow2(1024);
[S,F,T] = spectrogram(x, N, overlap, nfft, Fs);

%%
figure(1);
spectrogram(x, N, overlap, nfft, Fs, 'yaxis');
