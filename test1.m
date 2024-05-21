%% Takes an audiofile of a song and determines its danceability based on beat strength, overall tempo, and tempo stability
% danceability is how well a song can be danced to throughout the whole
% duration
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

%% display spectrogram
figure(1);
spectrogram(x, N, overlap, nfft, Fs, 'yaxis');
title('spectrogram of unmodified audio')


%% finding beat strength
% beat strength is intensity of beats throughout a song

% 1. locating beats
% spectrogram of only low frequencies in order to distinguish beats 
% which usually consists of drum and bass (the sound you would tap your
% foot or nod your head to)

% we want to look for a beat every ~ half a second
for i = 1:length(T)
    if T(i) > .5
        interval = i;
        break;
    end
end


low_freq = F < 150;
low_freq_energy = sum(abs(S(low_freq, :)), 1);
% isolated beats 
[beats, loc] = findpeaks(low_freq_energy, "MinPeakDistance", interval);

beat_strength = mean(beats);


% figure(2);
% subplot(2,1,1);
% spectrogram(x, N, overlap, nfft, Fs, 'yaxis');
% title('spectrogram of unmodified audio')
% subplot(2,1,2);


