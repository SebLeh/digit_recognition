
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
        inputs;
    end %private
    methods
        function nn = nn()      %constructor
            nn.database = zeros(10,1000,28,28);
            nn.database_learn = zeros(10,850,28,28);      %850 training examples for each digit
            nn.database_test = zeros(10,100,28,28);       %100 test samples
            nn.database_validate = zeros(10,50,28,28);    %50 sets left untouched for validation
            nn.learning_rate = 0.2;     
            
            nn.error_learn = zeros(1,8500);
            nn.error_test = zeros(1,1000);
            nn.weights = randn(785,10)/10;     % 785 = 28x28 + bias unit  
            
            nn.outputs = zeros(1,10);
            nn.inputs = zeros(1,784);
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
        
        function nn = learn_regular(nn, epoch_size) %one sample per class everytime; all after another
            % epoch_size gives the number of iterations before weight
            % adaption should be done
            epoch = 0;
            epoch_error = zeros('like', nn.outputs);
            ii = 0;
            for i=1:850
               epoch = epoch +1;
               for j=1:10
                   ii = ii +1;
                   label = zeros(1,10);
                   sample = nn.database_learn(j,i,:,:);
                   sample = squeeze(sample);
                   for k=1:10   %calculate label-bits
                       if k==j
                           label(k) = 1;
                       end
                   end %for(k)
                   sample = nn.normalize_input(sample);
                   nn.inputs = nn.calc_inputs(sample);
                   nn.outputs = nn.feedforward(nn.inputs);
                   for jj = 1:10
                      nn.error_learn(ii) = nn.error_learn(ii) +  abs(nn.outputs(jj)-label(jj));
                      %%%nn.error_learn(ii) = abs(nn.outputs(j)-label(j));
                      %error = nn.outputs(jj)-label(jj); %simple
                      error = nn.outputs(jj)*(1-nn.outputs(jj))*(label(jj)-nn.outputs(jj));
                      nn.weights = nn.adapt_weights_simple(error, nn.inputs, jj);
                   end
                   %%%nn.error_learn(ii) = abs(nn.outputs(j)-label(j));
                   %%%nn.weights = nn.adapt_weights_simple(nn.error_learn(ii), nn.inputs);
               end %for(j)
               
            end %for(i)
        end %learn_regular
        
        function nn = learn_random(nn)   % samples are chosen randomly
            
        end %learn_random
        
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
        
        function nn = test(nn, sample, label)
            
        end %test
        
        function nn = validate(nn, digit, num)
            target = zeros(1,10);
            inputs = zeros(1,784);
            outputs = zeros(1,10);
            class = -1;
            smp = nn.database_validate(digit+1, num, :, :);
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
            
            max = output(1);
            
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
            %holdon
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
        
        function weights = adapt_weights_simple(nn, error, inputs, index_out)
            weights = nn.weights;
            for i = 1:784
                %for j = 1:10
                    weights(i,index_out) = weights(i,index_out) + nn.learning_rate*error*inputs(i);
                %end %for(j)
            end % for(i)
        end %method adapt_weights
        
        function weights = adapt_weights_backprop(nn, error, inputs, index_out)
           weights = n.weights; 
        end
        
        function inputs = calc_inputs(nn, sample)
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
