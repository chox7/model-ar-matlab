% Funkcja wczytująca dane za pomocą pliku xml
function [Data, Fs, num_ch, labels, firstSampleTime]  = readSvarogData(fileXML)
    % wczytywanie zawartości pliku xml
    str = fileread(fileXML);
    
    % znajdowanie nazwy pliku z danymi
    % expression = '<rs:sourceFileName>(.*?)\.obci\.raw</rs:sourceFileName>';
    % match = regexp(str, expression, 'tokens');
    filePath = strcat('./kacper_zamkniete.obci.raw');


    % liczbie kanałów
    expression ='<rs:channelCount>(.*?)</rs:channelCount>';
    match = regexp(str, expression, 'tokens');
    num_ch = str2double([match{1}{1}]);


    % częstość próbkowania
    expression ='<rs:samplingFrequency>(.*?)</rs:samplingFrequency>';
    match = regexp(str, expression, 'tokens');
    Fs = str2double([match{1}{1}]); 
    

    % typ danych
    expression ='<rs:sampleType>(.*?)</rs:sampleType>';
    match = regexp(str, expression, 'tokens');
    dataType = [match{1}{1}];

    % Mapowanie na formaty fread
    switch upper(dataType)
        case 'FLOAT'
            dataType = 'float32';
        case 'DOUBLE'
            dataType = 'float64';
        case 'INT16'
            dataType = 'int16';
        case 'UINT16'
            dataType = 'uint16';
        case 'INT32'
            dataType = 'int32';
        case 'UINT32'
            dataType = 'uint32';
        otherwise
            error('Nieobsługiwany typ danych: %s', dataType);
    end  


      % nazwy kanaów
    expression = '<rs:channelLabels>(.*?)</rs:channelLabels>';
    match = regexp(str, expression, 'tokens');
    labelsStr = [match{1}{1}];

    expression = '<rs:label>(.*?)</rs:label>';
    match = regexp(labelsStr, expression, 'tokens');
    labels = [match{:}];

    % parametr kalibracji wzmocnienia
    expression = '<rs:calibrationGain>(.*?)</rs:calibrationGain>';
    match = regexp(str, expression, 'tokens');
    gainStr = [match{1}{1}];

    expression = '<rs:calibrationParam>(.*?)</rs:calibrationParam>';
    match = regexp(gainStr, expression, 'tokens');
    calibrationGainParams = str2double([match{:}]);
  

    % parametr kalibracji przesunięcia
    expression = '<rs:calibrationOffset>(.*?)</rs:calibrationOffset>';
    match = regexp(str, expression, 'tokens');
    OffsetStr = [match{1}{1}];

    expression = '<rs:calibrationParam>(.*?)</rs:calibrationParam>';
    match = regexp(OffsetStr, expression, 'tokens');
    calibrationOffsetParams = str2double([match{:}]);

    
    % czas pierwszej próbki sygnału
    expression ='<rs:firstSampleTimestamp>(.*?)</rs:firstSampleTimestamp>';
    match = regexp(str, expression, 'tokens');
    firstSampleTimestamp = str2double([match{1}{1}]);
    firstSampleDateTime = datetime(firstSampleTimestamp, 'ConvertFrom', 'posixtime');
    firstSampleTime = datestr(firstSampleDateTime);
    

    % wczytywanie danych z pliku (multipleksacja)
    fid = fopen(filePath,'rb');
    binaryData = fread(fid, dataType);
    fclose(fid);

    sample_count = floor(length(binaryData)./num_ch); % liczba próbek
    Data = reshape(binaryData, [num_ch, sample_count]);


    % przeskalowywanie danych
    for ch = 1:num_ch
        Data(ch, :) = calibrationGainParams(ch) .* Data(ch, :) + calibrationOffsetParams(ch);
    end


end