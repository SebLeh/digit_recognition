
import nn;
%import data;

NN = nn;

NN = NN.import();
NN = NN.learn_regular(1);
NN.plot_error();



