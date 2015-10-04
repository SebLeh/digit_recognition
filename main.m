
import nn;
import data;


% call user interface?

% instance of nn object
% nn-> learn with data

%%% Testing %%%


data_obj = data;

NN = nn;

NN.import();
NN.learn_regular();


num = 7;
amount = 1000;
imgs = data_obj.load(num, amount);

img = imgs(1,:,:);
img = squeeze(img);

imshow(img);


%getReport(data_obj.ex_no_digit(num));

