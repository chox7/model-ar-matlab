addpath("../data/");

doc=xmlread("kacper_zamkniete.obci.xml");
file_name = string(doc.getElementsByTagName('rs:sourceFileName').item(0).getTextContent);
channels_num = str2double(doc.getElementsByTagName('rs:channelCount').item(0).getTextContent);
fs = str2double(doc.getElementsByTagName('rs:samplingFrequency').item(0).getTextContent);
sample_type = string(doc.getElementsByTagName('rs:sampleType').item(0).getTextContent);
sample_count = str2double(doc.getElementsByTagName('rs:sampleCount').item(0).getTextContent);
start_time = str2double(doc.getElementsByTagName('rs:firstSampleTimestamp').item(0).getTextContent);

labels_tag = doc.getElementsByTagName('rs:channelLabels').item(0);
labels = labels_tag.getElementsByTagName('rs:label');

channels = string.empty(0,labels.getLength);
for k = 0:labels.getLength-1
    label = labels.item(k).getTextContent;
    channels(k+1) = string(label);
end

gains_tag = doc.getElementsByTagName('rs:calibrationGain').item(0);
gains = gains_tag.getElementsByTagName('rs:calibrationParam');

calibration_gains = double.empty(0,gains.getLength);
for k = 0:gains.getLength-1
    gain = gains.item(k).getTextContent;
    calibration_gains(k+1) = str2double(gain);
end


offsets_tag = doc.getElementsByTagName('rs:calibrationOffset').item(0);
offsets = offsets_tag.getElementsByTagName('rs:calibrationParam');

calibration_offsets = double.empty(0,offsets.getLength);
for k = 0:offsets.getLength-1
    offset = offsets.item(k).getTextContent;
    calibration_offsets(k+1) = str2double(offset);
end


% wczytywanie danych z pliku (multipleksacja)
file_name = strcat('kacper_zamkniete.obci.raw');
fid = fopen(file_name,'rb');
binaryData = fread(fid, 'float32');
fclose(fid);

Data = reshape(binaryData, [channels_num, sample_count]);


% przeskalowywanie danych
for ch = 1:channels_num
    Data(ch, :) = calibration_gains(ch) .* Data(ch, :) + calibration_offsets(ch);
end