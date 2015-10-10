
import nn;
%import data;

NN = nn;

NN = NN.import();
NN = NN.learn_regular(1);
NN.plot_error();

NN = NN.validate(0,1, 0);
NN = NN.validate(0,2, 0);
NN = NN.validate(0,3, 0);
NN = NN.validate(0,4, 0);
NN = NN.validate(0,5, 0);





