% Add caffe/matlab to you Matlab search PATH to use matcaffe
if exist('../+caffe', 'dir')
  addpath('..');
else
  error('Please run this demo from caffe/matlab/demo');
end

caffe.reset_all();
%prev_rng = seed_rand(conf.rng_seed);
%caffe.set_random_seed(conf.rng_seed);

% Set caffe mode
if exist('use_gpu', 'var') && use_gpu
  caffe.set_mode_gpu();
  gpu_id = 0;  % we will use the first gpu in this demo
  caffe.set_device(gpu_id);  
else
  caffe.set_mode_cpu();
end

% Initialize the network
model_dir = '../mycode/';
net_model = [model_dir 'model.prototxt'];
net_solver = [model_dir 'solver.prototxt'];
phase = 'train'; % run with phase train (so that some layers wont be applied)


net= caffe.Net(net_model, phase);
solver = caffe.Solver(net_solver);

%net.forward_prefilled();

% %training
%solver.solve();
% %iterations number of training, just do n*batch_size iterations
% solver.step(2);
%get the iteration number;
iter = solver.iter();
max_iter = Inf;

%net_inputs = {single(zeros([30 20 1 64])), single(ones([64,1]))};
%solver.net.reshape_as_input(net_inputs); solver.net.set_input(net_inputs);
loss_progress = [];
loss_current = [];
acc_progress = [];
acc_current = [];

dispint = 2000;
valint = 5;
tic;

while (iter < max_iter)
    %net_inputs ＝ {};
    %net_inputs = {zeros([30 20 1 64])};
    
    solver.step(1);
    iter = solver.iter();
    
    loss_current = [loss_current solver.net.blobs('loss').get_data()];

    
    if mod(iter, dispint) == 0
       dt = toc;
       fprintf('iter=%d, %.3f, dt=%0.3f\n', iter, mean(loss_current), dt); 
       loss_progress = [loss_progress mean(loss_current)];
       loss_current = [];
       tic;
       plot(dispint:dispint:iter,loss_progress);
       drawnow;
    end
    
    

end



%% matcaffe command
% train_net = solver.net;
% test_net = solver.test_nets(1);
% 
% solver.test_net.set_input_arrays(test_X, test_Y);
% solver.test_net.forward();
% solver.net.save(model_path);

% pool1_feat = net.blobs('pool1').get_data();


%% multiple inout layers
% input_dir = '/home/ze/Downloads/caffe-master/matlab/mycode/human_feature/';
% input_data_file = [input_dir 'data_1.txt'];
% input_label_file = [input_dir 'label_1.txt'];
% input_data = load(input_data_file);
% input_label = load(input_label_file);

%data preprocessing
% input_data = reshape(input_data,size(input_data,1),1, 20,30);
% input_label = reshape(input_label, size(input_label, 1),1, 8);

% input_data = permute(input_data, [4,3,2,1]);
% input_data_cell = {input_data};


%scores = net.forward(input_data_cell);  %input_data must be 4-d array cell.

%solver.reshape_as_input(input_data);






