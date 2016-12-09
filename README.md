# CSE881_project
LinearSVM folder contains the SVM code and library files, you can find another README in this folder to instruct you how to run the matlab code.

FeatureExtraction folder conrtains to C++ code and many related libraries to extract the geometric features from triangle meshes. You need to compile Clapack library in the computer first, and then open the Project1 solution in Microsoft Visual studio 2015, and run MeshSegmentation.cpp with your mesh file, then you can get the geometric feature vector. 

CNN folder contains the matlab code used for preprocessing our data. Solver.prototxt and model.prototxt are our cnn network file.
You can run datapreprocessing.m and labelpreprocessing.m for data preprocessing, run the CreatHDF5.m to get the input file for caffe, and run the meshtraining.m to train our neural network. 

Since our data is too big, we didnt upload any data in github.
