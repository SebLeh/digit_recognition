
classdef nn
    properties
        database;
        database_learn;      %850 training examples for each digit
        database_test;       %100 test samples
        database_validate;    %50 sets left untouched for validation
        learning_rate;
    end
    properties(Access = 'private')
        error_learn;
        error_test;
        weights;
        outputs;
    end %private
    methods
        function nn = nn()      %constructor
            nn.database = zeros(10,1000,28,28);
            nn.database_learn = zeros(10,850,28,28);      %850 training examples for each digit
            nn.database_test = zeros(10,100,28,28);       %100 test samples
            nn.database_validate = zeros(10,50,28,28);    %50 sets left untouched for validation
            nn.learning_rate = 0.2;     
            
            nn.error_learn = zeros(1,850);
            nn.error_test = zeros(1,100);
            nn.weights = randn(785,10)/10;     % 785 = 28x28 + bias unit  
            
            nn.outputs = zeros(1,10);
        end
        
        function nn = import(nn)
           import data; 
           data_obj = data;
           for i=1:10
               nn.database(i,:,:,:) = data_obj.load(i-1, 1000);
               nn.database_learn(i,:,:,:) = nn.database(i,1:850,:,:);
               nn.database_test(i,:,:,:) = nn.database(i,851:950,:,:);
               nn.database_validate(i,:,:,:) = nn.database(i,951:1000,:,:);
           end %for(i)
        end %import
        
        function nn = learn_regular(nn) %one sample per class everytime; all after another
            label = zeros(1,10);
            for i=1:850
               for j=1:10
                   label = zeros(1,10);
                   sample = nn.database_learn(j,i,:,:);
                   sample = squeeze(sample);
                   for k=1:10   %calculate label-bits
                       if k==j
                           label(k) = 1;
                       end
                   end %for(k)
                   sample = nn.normalize_input(sample);
                   nn.outputs = nn.feedforward(sample);
                   nn.error_learn(i) = nn.error_learn(i) + abs(nn.outputs(j)-label(j));
               end %for(j)
            end %for(i)
        end %learn_regular
        
        function nn = learn_random(nn)   % samples are chosen randomly
            
        end %learn_random
        
        function output = feedforward(nn, sample)
            output = zeros(1,10);
            for i = 1:10    %output neurons
                net = 1 * nn.weights(1,i);
                for j = 1:784
                    if mod(j,28) == 0
                        x = 28;
                    else
                        x = mod(j,28);
                    end
                    y = ceil(j/28); %round up to next integer
                    net = net + sample(x,y)* nn.weights(j+1,i);
                end % for(j)
                output(i) = 1 / (1+exp(-net)); % sigmoid
            end % for(i)            
        end %training
        
        function nn = test(nn, sample, label)
            
        end %test
        
        function nn = validate(nn)
            
        end %validate
        
        function plot_error(nn)
            plot(nn.error_learn);
        end %plot_error

    end %public methods
            
    methods (Access = 'private')
        function normalized = normalize_input(nn, sample)
            normalized = zeros('like', sample);
            for i=1:28
                for j=1:28
                    normalized(i,j) = sample(i,j)/255;
                end %for
            end %for(i)
        end %method normalize_input
    end %private methods
end
