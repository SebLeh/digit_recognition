
classdef nn
    properties
        database;
        database_learn;      
        database_test;       
        database_validate;    
        learning_rate;
    end
    properties(Access = 'private')
        error_learn;
        weights;
        outputs;
        inputs;

    end %private
    methods
        function nn = nn()      %constructor
            nn.database = zeros(10,1000,28,28);
            nn.database_learn = zeros(10,200,28,28);      %850 training examples for each digit
            nn.database_test = zeros(10,100,28,28);       %100 test samples
            nn.database_validate = zeros(10,50,28,28);    %50 sets left untouched for validation
            nn.learning_rate = 0.2;     
            
            nn.error_learn = zeros(1,2000);
            nn.weights = randn(785,10)/10;     % 785 = 28x28 + bias unit  
            
            nn.outputs = zeros(1,10);
            nn.inputs = zeros(1,784);
            
        end
        
        function nn = import(nn)
           import data; 
           data_obj = data;
           for i=1:10
               nn.database(i,:,:,:) = data_obj.load(i-1, 1000);
               nn.database_learn(i,:,:,:) = nn.database(i,1:200,:,:);
               nn.database_test(i,:,:,:) = nn.database(i,851:950,:,:);
               nn.database_validate(i,:,:,:) = nn.database(i,951:1000,:,:);
           end %for(i)
        end %import
        
        function nn = learn(nn) %one sample per class everytime; all after another
            ii = 0;
            for i=1:200     %200 samples per class (0 to 9)
               for j=1:10   %the ten classes
                   ii = ii +1; %iterator for error-array (goes up to 2000); to display plot later
                   target = zeros(1,10); % output vector (digit)
                   sample = nn.database_learn(j,i,:,:);
                   sample = squeeze(sample);
                   for k=1:10   %calculate target-bits (output vector)(digit)
                       if k==j
                           target(k) = 1;
                       end
                   end %for(k)
                   sample = nn.normalize_input(sample);
                   nn.inputs = nn.calc_inputs(sample);
                   nn.outputs = nn.feedforward(nn.inputs);
                   for jj = 1:10    %iteration through network outputs
                      nn.error_learn(ii) = nn.error_learn(ii) +  abs(nn.outputs(jj)-target(jj));
                      error = nn.outputs(jj)*(1-nn.outputs(jj))*(target(jj)-nn.outputs(jj));
                      nn.weights = nn.adapt_weights(error, nn.inputs, jj);
                   end %for(jj)
               end %for(j)   
            end %for(i)
            csvwrite('csv_weights.csv',nn.weights);
        end %learn
        
		function nn = load_weights(nn) %load files from CSV file
			nn.weights = csvread('csv_weights.csv');
		end %load_weights
        
        function output = feedforward(nn, inputs)
            output = zeros(1,10);
            for i = 1:10    %output neurons
                net = 1 * nn.weights(1,i);
                for j = 1:784
                    net = net + inputs(j)* nn.weights(j+1,i);
                end % for(j)
                output(i) = 1 / (1+exp(-net)); % sigmoid
            end % for(i)            
        end %training
        
        function nn = validate(nn, digit, num)
            target = zeros(1,10);
            inputs = zeros(1,784);
            outputs = zeros(1,10);
            smp = nn.database_validate(digit+1, num, :, :); %digit+1 because matlab starts counting at 1
            smp = squeeze(smp);
            image = smp;
            smp = nn.normalize_input(smp);
            inputs = nn.calc_inputs(smp);
            output = nn.feedforward(inputs);
            imshow(image);
            for i = 1:10
                if i == digit+1
                    target(i) = 1;
                end
            end
            %just initializing
            max = output(1); % max output value of NN will be written here
            class = 0;       % the classification-output of the NN will be written here     
            for j = 1:10                
                if max < output(j)
                    max = output(j);
                    class = j-1;
                end
            end
            
            max
            class
            
        end %validate
        
        function nn = validateCustomImage(nn,fileName)
            
            inputs = zeros(1,784);
            outputs = zeros(1,10);
            
            smp = imread(fileName);
            
            smp = squeeze(smp);
            image = smp;
            smp = nn.normalize_input(smp);
            inputs = nn.calc_inputs(smp);
            output = nn.feedforward(inputs);
            imshow(image);
            
            %just initializing
            max = output(1); % max output value of NN will be written here
            class = 0;       % the classification-output of the NN will be written here     
            for j = 1:10                
                if max < output(j)
                    max = output(j);
                    class = j-1;
                end
            end
            
            max
            class
            
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
        
        function weights = adapt_weights(nn, error, inputs, index_out)
            weights = nn.weights;
            for i = 1:784
				weights(i,index_out) = weights(i,index_out) + nn.learning_rate*error*inputs(i);
            end % for(i)
        end %method adapt_weights
        
        function inputs = calc_inputs(nn, sample)
            %putting all lines of the image behind each other
            % -> making 28x28 array to 1x784 array
            inputs = zeros('like', nn.inputs);
            for i = 1:10
                for j = 1:784
                    if mod(j,28) == 0
                        x = 28;
                    else
                        x = mod(j,28);
                    end
                    y = ceil(j/28); %round up to next integer
                    inputs(j) = sample(x,y);
                end %for(j)
            end %for(i)
        end % method calc_inputs

    end %private methods
end
