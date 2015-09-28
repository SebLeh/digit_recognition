
function backprop_try
% -- generate data and labels --
training_set = randi([0,1],[50,11]);
training_labels = zeros(50, 2);

test_set = randi([0,1],[100,11]);
test_labels = zeros(100,2);

hidden_neurons = zeros(1, 5);
output = zeros(1,2);

verify = randi([0,1],[50,11]);

e_sum = zeros(1,50);

learning_rate = 0.1;
bias = 1;

% -- generate initial weights --
% first layer
weights_1st = randn(12,6)/10;

%second layer
weights_2nd = randn(6,2)/10;

label_data;
backprop;
plot_error;

% labels
    function label_data
        for i = 1:50
           value = 0;
           for j = 1:11
               if training_set(i,j) == 1
                   value = value +1;
               end
           end
           if value > 5
               training_labels(i, 1) = 1;
           else
               training_labels(i, 2) = 1;
           end
        end

        for i = 1:100
           value = 0;
           for j = 1:11
               if test_set(i,j) == 1;
                   value = value +1;
               end
           end
           if value > 5
               test_labels(i, 1) = 1;
           else               
               test_labels(i, 2) = 1;
           end
        end
    end % label_data

    function feed_forward(step)

       %calculate hidden neurons
       for j=1:5
          hidden_neurons(j) = hidden_neurons(j) + bias*weights_1st(1,1);
          for k=1:11
             hidden_neurons(j) = hidden_neurons(j) + training_set(step)*weights_1st(k+1,j+1); %+1, because bias uses weight 1
          end %k
          % sigmoid
          hidden_neurons(j) = 1 / (1 - exp(hidden_neurons(j)));
       end %j, hidden neurons
       % calculate output
       for j=1:2
            output(j) = output(j) + bias*weights_2nd(1,1);
            for k=1:5
                output(j) = output(j) + hidden_neurons(k)*weights_2nd(k+1, j); %+1, because bias uses weight 1
            end
            % sigmoid
            output(j) = 1 / (1 - exp(output(j)));
       end %j, output

    end % feed_forward

    function backprop
        e_output = zeros(1,2); % e for error
        e_hidden = zeros(1,5);
        for i=1:50 %training data samples
            output = zeros(1,2); %overwrite with zeros again
            hidden_neurons = zeros(1,5);
            feed_forward(i);
            if output == training_labels(i)
                % no error, correctly classified
            else
                % propagate error back through net
                for j=1:2   %output
                    e_output(j) = output(j)*(1-output(j))*(training_labels(i,j)-output(j));
                end %j, output
                for j=1:5   %hidden
                    e_hidden(j) = hidden_neurons(j)*(1-hidden_neurons(j)*(weights_2nd(j+1,1)*e_output(1)+weights_2nd(j+1,2)*e_output(2)));
                end %j, hidden
                
                % update weights
                for j=1:5   %hidden
                    weights_2nd(j+1,1) = weights_2nd(j+1,1) + learning_rate*e_output(1)*hidden_neurons(j);
                    weights_2nd(j+1,2) = weights_2nd(j+1,2) + learning_rate*e_output(2)*hidden_neurons(j);
                end
                for j=1:11 %input
                    for k=1:5
                       weights_1st(j+1,k+1) = weights_1st(j+1,k+1) + learning_rate*e_hidden(k)*training_set(i,j);
                    end
                end
                
                %bias-weights
                weights_2nd(1,1) = weights_2nd(1,1)+learning_rate*e_output(1);
                weights_2nd(1,2) = weights_2nd(1,2)+learning_rate*e_output(2);
                for j=1:5
                   weights_1st(1,j) = weights_1st(1,j)+learning_rate*e_hidden(j);
                end
            end %if
            e_sum(i) = abs(e_output(1))+abs(e_output(2));
        end %i, feed forward
    end % backprop

    function plot_error
        plot(e_sum);
    end

end


