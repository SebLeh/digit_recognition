classdef data
    properties(Access = 'private')
        file0;
        file1;
        file2;
        file3;
        file4;
        file5;
        file6;
        file7;
        file8;
        file9;
        loaded;
    end %private properties
    
    properties (Access = 'public')
        number = -1;
    end %public properties
    
    methods        
        function loaded = load(data, num, amount)
        % will return an array of up to 1000 pictures of the given number
        %loaded = zeros(amount,28,28);
        data.number = num;
        
        if amount > 1000
            amount = 1000;
        end
        loaded = zeros(amount,28,28);
        
        current_file = mfilename('fullpath');
        path = fileparts(current_file);
        separated_digits = strcat(path,'\data\separated digits');

        data.file0 = strcat(separated_digits,'\data0');
        data.file1 = strcat(separated_digits,'\data1');
        data.file2 = strcat(separated_digits,'\data2');
        data.file3 = strcat(separated_digits,'\data3');
        data.file4 = strcat(separated_digits,'\data4');
        data.file5 = strcat(separated_digits,'\data5');
        data.file6 = strcat(separated_digits,'\data6');
        data.file7 = strcat(separated_digits,'\data7');
        data.file8 = strcat(separated_digits,'\data8');
        data.file9 = strcat(separated_digits,'\data9');

        switch data.number
            case 0
                fileIn = fopen(data.file0,'r');
            case 1
                fileIn = fopen(data.file1,'r');
            case 2
                fileIn = fopen(data.file2,'r');
            case 3
                fileIn = fopen(data.file3,'r');
            case 4
                fileIn = fopen(data.file4,'r');
            case 5
                fileIn = fopen(data.file5,'r');
            case 6
                fileIn = fopen(data.file6,'r');
            case 7
                fileIn = fopen(data.file7,'r');
            case 8
                fileIn = fopen(data.file8,'r');
            case 9
                fileIn = fopen(data.file9,'r');    
        end %switch 
        
        for i =1:amount
            img = fread(fileIn,[28 28],'uchar');
            loaded(i,:,:) = transpose(img);
        end %for(i)
        end %method open

    end %methods
end




    
