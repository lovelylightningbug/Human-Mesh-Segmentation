input_dir = '/home/ze/Downloads/caffe-master/matlab/mycode/human_feature/';



for i=1:20
    input_data = [input_dir,num2str(i),'.off.txt'];   
    input_label = [input_dir,num2str(i),'_labels.txt'];
    output_label = [input_dir,num2str(i),'label_new.txt'];
    data = load(input_data);
    label = zeros(size(data,1),1);

    fidin=fopen(input_label,'r'); 
    fidtmp=fopen(output_label,'w'); 


    while ~feof(fidin) % whether it is the end of the file
        tline=fgetl(fidin); % read one line the file, doesnot include /n
         if ~isempty(tline) % whether this line is empty
             %detect different parts of a body
             %lowerleg
             if double(tline(1))==108 &&double(tline(6))==108
                 tline=fgetl(fidin);
                  label_tmp = str2num(tline);
                  for j = label_tmp
                      label(j,1)= 0;
                  end   
             end
             %upperleg
             if double(tline(1))==117 && double(tline(6))==108
                 tline=fgetl(fidin);
                 label_tmp = str2num(tline);
                 for j = label_tmp
%                      label(j,2)= 1;
                       label(j,1)=1;
                 end   
            end
            %torse
            if double(tline(1))==116
                 tline=fgetl(fidin);
                 label_tmp = str2num(tline);
                 for j = label_tmp
%                    label(j,3 )= 1;
                     label(j,1)=2;
                 end   
            end
            %hand
            if double(tline(1))==104 && double(tline(2)==97)
                 tline=fgetl(fidin);
                 label_tmp = str2num(tline);
                 for j = label_tmp
%                     label(j,4)= 1;
                      label(j,1)= 3;
                 end   
             end
             %head
             if double(tline(1))==104 && double(tline(2)==101)
                 tline=fgetl(fidin);
                 label_tmp = str2num(tline);
                 for j = label_tmp
%                     label(j,5)= 1;
                      label(j,1)=4;
                 end   
             end
             %upperarm
             if double(tline(1))==117 && double(tline(6)==97)
                 tline=fgetl(fidin);
                 label_tmp = str2num(tline);
                 for j = label_tmp
%                     label(j,6)= 1;
                    label(j,1)=5;
                 end   
             end
             %lowerarm
              if double(tline(1))==108 && double(tline(6)==97)
                     tline=fgetl(fidin);
                     label_tmp = str2num(tline);
                     for j = label_tmp
%                         label(j,7)= 1;
                        label(j,1)=6;
                     end   
              end
              %feet
              if double(tline(1))==102
                 tline=fgetl(fidin);
                 label_tmp = str2num(tline);
                 for j = label_tmp
%                     label(j,8)= 1;
                        label(j,1)=7;
                 end   
              end      
          end
    end

    [l1,l2]=size(label);
    for k=1:l1
       for t=1:l2
          if t==l2
            fprintf(fidtmp,'%g\n',label(k,t));
          else
           fprintf(fidtmp,'%g ',label(k,t));
          end
       end
    end
    fclose(fidtmp);
end