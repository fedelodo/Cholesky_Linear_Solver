function newFileName = getNewFileName(outputFileName, index) 
    fileName = strcat(outputFileName, "_", num2str(index), ".csv");
    if isfile(fileName)
       newFileName = getNewFileName(outputFileName, index + 1);
    else
         newFileName = fileName;
    end
end