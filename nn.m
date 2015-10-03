
classdef nn
    properties
        database = zeros(10,1000,28,28);
        database_learn = zeros(10,850,28,28);      %850 training examples for each digit
        database_test = zeros(10,100,28,28);       %100 test samples
        database_validate = zeros(10,50,28,28);    %50 sets left untouched for validation
    end
    methods
        function import
           import data; 
           data_obj = data;
           for i=1:10
               database(i,:,:,:) = data_obj.load(i, 1000);
               database_learn(i,:,:,:) = database(i,1:850,:,:);
               databse_test(i,:,:,:) = database(i,851:950,:,:);
               databse_verify(i,:,:,:) = database(i,951:1000,:,:);
           end %for(i)
           
        end %import
        function learn
            
        end %learn
        function test
            
        end %test
        function validate
            
        end %validate
    end
end
