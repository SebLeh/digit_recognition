clc; clear; close all;

import nn;
%import data;

NN = nn;

NN = NN.import();
%NN = NN.learn();
NN = NN.load_weights();
%NN.plot_error();

%NN = NN.validateCustomImage('numb28.png');

accuracy = 0;
for i=1:50
   for j=1:10 
      NN = NN.validate(j-1,i); 
      accuracy = accuracy + NN.correct;
   end
end

accuracy = accuracy / 500;
accuracy

% NN = NN.validate(0,1); % (digit to test, example no. of digit)
% NN = NN.validate(0,2);
% NN = NN.validate(0,3);

% NN = NN.validate(1,1);
% NN = NN.validate(1,2);
% NN = NN.validate(1,3);

% NN = NN.validate(2,1);
% NN = NN.validate(2,2);
% NN = NN.validate(2,3);





