%change path to testdata here:
filepath = 'C:\Users\Sebi\OneDrive\Dokumente\Master\Erasmus\Vorlesungen\sound and image processing\matlab_scripts\data\separated digits';

file0 = strcat(filepath,'\data0');
file1 = strcat(filepath,'\data1');
file2 = strcat(filepath,'\data2');
file3 = strcat(filepath,'\data3');
file4 = strcat(filepath,'\data4');
file5 = strcat(filepath,'\data5');
file6 = strcat(filepath,'\data6');
file7 = strcat(filepath,'\data7');
file8 = strcat(filepath,'\data8');
file9 = strcat(filepath,'\data9');
fileIn = fopen(file0,'r');

if (fileIn ~= 0)
    [t1,N]=fread(fileIn,[28 28],'uchar');
    imshow(t1);
end