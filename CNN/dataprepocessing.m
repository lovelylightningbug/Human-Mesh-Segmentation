input_dir = '/home/ze/Downloads/caffe-master/matlab/mycode/human_feature/';

i=20;
% for i=1:20
input_data = [input_dir,num2str(i),'.off.txt'];
output_data = [input_dir,num2str(i),'data_new.txt'];


a= load(input_data);
b = a(1:size(a,1),1:600);

fid=fopen(output_data,'wt');
[m,n]=size(b);
 for i=1:1:m
   for j=1:1:n
      if j==n
        fprintf(fid,'%g\n',b(i,j));
     else
       fprintf(fid,'%g ',b(i,j));
      end
   end
end
fclose(fid);
% end
