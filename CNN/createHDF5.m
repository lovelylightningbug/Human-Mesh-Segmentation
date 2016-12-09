%% WRITING TO HDF5
clear;
input_dir = '/home/ze/Downloads/caffe-master/matlab/mycode/human_feature/';
   
train_data_file = [input_dir, num2str(1),'data_new.txt'];
train_label_file = [input_dir,num2str(1),'label_new.txt'];
train_data = load(train_data_file);
train_label = load(train_label_file);

for i = 2:10
    train_data_file = [input_dir, num2str(i),'data_new.txt'];
    train_label_file = [input_dir,num2str(i),'label_new.txt'];
    train_data_tmp = load(train_data_file);
    train_label_tmp = load(train_label_file);
    train_data = [train_data; train_data_tmp];
    train_label = [train_label; train_label_tmp];
end

%  train_data_file = [input_dir, num2str(6),'data_new.txt'];
%  train_label_file = [input_dir,num2str(6),'label_new.txt'];
%  train_data_tmp = load(train_data_file);
%  train_label_tmp = load(train_label_file);
%  train_data = [train_data; train_data_tmp];
%  train_label = [train_label; train_label_tmp];



s1 = randperm(size(train_data,1));
train_data = train_data(s1,:);
train_label = train_label(s1,:);

train_data = reshape(train_data,size(train_data,1),1, 20,30);
train_data = permute(train_data, [4,3,2,1]);
train_label = permute(train_label, [2,1]);

%validation dataset
validation_data_file = [input_dir, num2str(19),'data_new.txt'];
validation_label_file = [input_dir,num2str(19),'label_new.txt'];
validation_data = load(validation_data_file);
validation_label = load(validation_label_file);

% validation_data_file = [input_dir, num2str(18),'data_new.txt'];
% validation_label_file = [input_dir,num2str(18),'label_new.txt'];
% validation_data_tmp = load(validation_data_file);
% validation_label_tmp = load(validation_label_file);
% validation_data = [validation_data; validation_data_tmp];
% validation_label = [validation_label; validation_label_tmp];


s2 = randperm(size(validation_data,1));
validation_data = validation_data(s2,:);
validation_label = validation_label(s2,:);

validation_data = reshape(validation_data,size(validation_data,1),1, 20,30);
validation_data = permute(validation_data, [4,3,2,1]);
validation_label = permute(validation_label, [2,1]);

%test dataset
test_data_file = [input_dir, num2str(20),'data_new.txt'];
test_label_file = [input_dir,num2str(20),'label_new.txt'];
test_data = load(test_data_file);
test_label = load(test_label_file);

% test_data_file = [input_dir, num2str(20),'data_new.txt'];
% test_label_file = [input_dir,num2str(20),'label_new.txt'];
% test_data_tmp = load(test_data_file);
% test_label_tmp = load(test_label_file);
% test_data = [test_data; test_data_tmp];
% test_label = [test_label; test_label_tmp];

s3 = randperm(size(test_data,1));
test_data = test_data(s3,:);
test_label = test_label(s3,:);

test_data = reshape(test_data,size(test_data,1),1, 20,30);
test_date_data = permute(test_data, [4,3,2,1]);
test_label = permute(test_label, [2,1]);


h5create('train_10.hdf5','/data',size(train_data),'Datatype','double');
h5create('train_10.hdf5','/label',size(train_label),'Datatype','double');
h5write('train_10.hdf5','/data',train_data);
h5write('train_10.hdf5','/label',train_label);

h5create('test.hdf5','/data',size(test_data),'Datatype','double');
h5create('test.hdf5','/label',size(test_label),'Datatype','double');
h5write('test.hdf5','/data',test_data);
h5write('test.hdf5','/label',test_label);


h5create('validation.hdf5','/data',size(validation_data),'Datatype','double');
h5create('validation.hdf5','/label',size(validation_label),'Datatype','double');
h5write('validation.hdf5','/data',validation_data);
h5write('validation.hdf5','/label',validation_label);

% CREATE list.txt containing filename, to be used as source for HDF5_DATA_LAYER
FILE1=fopen('train_10.txt', 'w');
fprintf(FILE1, '%s', 'train_5.hdf5');
fclose(FILE1);
fprintf('HDF5 filename listed in %s \n', 'train.txt');

FILE2=fopen('test.txt', 'w');
fprintf(FILE2, '%s', 'test.hdf5');
fclose(FILE2);
fprintf('HDF5 filename listed in %s \n', 'test.txt');

FILE3=fopen('validation.txt', 'w');
fprintf(FILE3, '%s', 'validation.hdf5');
fclose(FILE3);
fprintf('HDF5 filename listed in %s \n', 'validation.txt');


%% check whether hdf5 file is right
% num_total_samples = size(input_label,2);

%num_total_samples=10000;
% to simulate data being read from disk / generated etc.
%data_disk=rand(5,5,1,num_total_samples); 
%label_disk=rand(10,num_total_samples); 

% chunksz=100;
% created_flag=false;
% totalct=0;
% for batchno=1:num_total_samples/chunksz
%   fprintf('batch no. %d\n', batchno);
%   last_read=(batchno-1)*chunksz;
% 
%   % to simulate maximum data to be held in memory before dumping to hdf5 file 
%   batchdata=input_data(:,:,1,last_read+1:last_read+chunksz); 
%   batchlabs=input_label(:,last_read+1:last_read+chunksz);
% 
%   % store to hdf5
%   startloc=struct('dat',[1,1,1,totalct+1], 'lab', [1,totalct+1]);
%   curr_dat_sz=store2hdf5(filename, batchdata, batchlabs, ~created_flag, startloc, chunksz); 
%   created_flag=true;% flag set so that file is created only once
%   totalct=curr_dat_sz(end);% updated dataset size (#samples)
% end



%% READING FROM HDF5

% % Read data and labels for samples #1000 to 1999
% data_rd=h5read(filename, '/data', [1 1 1 1000], [30, 20, 1, 1000]);
% label_rd=h5read(filename, '/label', [1 1000], [8, 1000]);
% fprintf('Testing ...\n');
% try 
%   assert(isequal(data_rd, single(input_data(:,:,:,1000:1999))), 'Data do not match');
%   assert(isequal(label_rd, single(input_label(:,1000:1999))), 'Labels do not match');
% 
%   fprintf('Success!\n');
% catch err
%   fprintf('Test failed ...\n');
%   getReport(err)
% end

%delete(filename);



