fid=fopen('p_6301423_calibration_p300.obci.xml', 'rb');
tekst=fread(fid, '*char');
fclose(fid);

tekst = tekst';

file_name = string(regexp(tekst, '<rs:sourceFileName>(.*)</rs:sourceFileName>', 'tokens', 'once'));
channels_num = str2double(regexp(tekst,'<rs:channelCount>(.*)</rs:channelCount>', 'tokens', 'once'));
fs = str2double(regexp(tekst,'<rs:samplingFrequency>(.*)</rs:samplingFrequency>', 'tokens', 'once'));
sample_type = string(regexp(tekst,'<rs:sampleType>(.*)</rs:sampleType>', 'tokens', 'once'));
if sample_type == "FLOAT"
    sample_type = 'float32';
end
sample_count = str2double(regexp(tekst,'<rs:sampleCount>(.*)</rs:sampleCount>', 'tokens', 'once'));
start_time = str2double(regexp(tekst,'<rs:firstSampleTimestamp>(.*)</rs:firstSampleTimestamp>', 'tokens', 'once'));

labels_tag = regexp(tekst,'<rs:channelLabels>(.*)</rs:channelLabels>', 'tokens', 'once');
labels = regexp(labels_tag,'<rs:label>(.*?)</rs:label>', 'tokens');
channels = string([labels{:}]);

gains_tag = regexp(tekst,'<rs:calibrationGain>(.*)</rs:calibrationGain>', 'tokens', 'once');
gains = regexp(gains_tag,'<rs:calibrationParam>(.*?)</rs:calibrationParam>', 'tokens');
calibration_gains = str2double(string([gains{:}]));

offsets_tag= regexp(tekst,'<rs:calibrationOffset>(.*)</rs:calibrationOffset>', 'tokens', 'once');
offsets = regexp(offsets_tag,'<rs:calibrationParam>(.*?)</rs:calibrationParam>', 'tokens');
calibration_offsets = str2double(string([offsets{:}]));

fid=fopen('p_6301423_calibration_p300.obci.raw', 'rb');
signal=fread(fid, sample_type);
fclose(fid);

signal = reshape(signal, [channels_num, sample_count]);
signal_gained = signal.*calibration_gains';

signal_go = signal_gained + calibration_offsets';

time = 0: 1/fs : sample_count/fs;
