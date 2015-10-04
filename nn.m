
classdef nn
    properties
        database = zeros(10,10,28,28);
        database_learn = zeros(10,850,28,28);      %850 training examples for each digit
        database_test = zeros(10,100,28,28);       %100 test samples
        database_validate = zeros(10,50,28,28);    %50 sets left untouched for validation
        
    end
    properties(Access = 'private')
        error_learn = zeros(1,850);
        error_test = zeros(1,100);
        weights = randn(785,10)/10;     % 785 = 28x28 + bias unit
    end %private
    methods
        function import(nn)
           import data; 
           data_obj = data;
           for i=1:10
               nn.database(i,:,:,:) = data_obj.load(i-1, 10);
               test = nn.database(2,10,:,:);
               test = squeeze(test);
               nn.database_learn(i,:,:,:) = nn.database(i,1:850,:,:);
               nn.database_test(i,:,:,:) = nn.database(i,851:950,:,:);
               nn.database_validate(i,:,:,:) = nn.database(i,951:1000,:,:);
           end %for(i)
           
        end %import
        function learn_regular(nn) %one sample per class everytime; all after another
            for i=1:10
               for j=1:850
                   sample = nn.database_learn(i,j,:,:);
                   sample = squeeze(sample);
                   nn.training(sample, i-1);
               end %for(j)
            end %for(i)
        end %learn_regular
        function learn_random(nn)   % samples are chosen randomly
            
        end %learn_random
        function training(nn, sample, label)
            
        end %training
        function test(nn, sample, label)
            
        end %test
        function validate(nn)
            
        end %validate
    end
end
