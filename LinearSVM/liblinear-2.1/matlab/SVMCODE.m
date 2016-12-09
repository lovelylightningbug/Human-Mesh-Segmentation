%load 'human_feature\1data_new.txt'
%load 'human_feature\1label_new.txt'

% Read 20 meshes and labels

clear , clc
input_dir = 'human_feature/';

features = [input_dir,num2str(1),'data_new.txt'];
label = [input_dir,num2str(1),'label_new.txt'];
load(features);
load(label);

All_Data = X1data_new;
All_Label= X1label_new;

mesh_data = ['X',num2str(1),'data_new']
mesh_label = ['X',num2str(1),'label_new']

disp('now deleting')
clear (mesh_data)
clear (mesh_label)



for i=2:9
    disp('mesh: ')
    i
    
features = [input_dir,num2str(i),'data_new.txt'];
label = [input_dir,num2str(i),'label_new.txt'];
load(features);
load(label);
% assemble the data togather 
mesh_data = ['X',num2str(i),'data_new']
mesh_label = ['X',num2str(i),'label_new']
All_Data=[All_Data;eval(mesh_data)];
All_Label=[All_Label;eval(mesh_label)];

disp('now deleting')
clear (mesh_data)
clear (mesh_label)


end

% set all data togather for training and testing
disp(' Training ......')
A=sparse(All_Data);
model = train(All_Label, A,'-c 1 -s 2');
% 
% 
load ('human_feature\19data_new.txt')
load ('human_feature\19label_new.txt')
B=sparse(X19data_new);
predict_label, accuracy, dec_values] = predict(X19label_new, B, model); % test the training data

%   