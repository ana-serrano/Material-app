clear all
close all

%Load data from json
%data_null  -> cell with token-names with null data
%data_valid -> cell with valid answers
path = 'data/';
list = dir(strcat(path,'*.json'));
data = cell(length(list),1);
j=1;
for i=1:length(list)
    fid = fopen(strcat(path,list(i).name));
    raw = fread(fid,inf);
    str = char(raw');
    fclose(fid);
    if (~strcmp(str,'null'))
        data{i} = parse_json(str);
    else
        data_null{j} = list(i).name(1:end-5);
        j=j+1;
    end
end
data_valid = data(~cellfun('isempty',data));

%Load list of attributes
fid = fopen('attributes.txt');
tline = fgetl(fid);
i=1;
while ischar(tline)
    attributes{i} = tline(1:end);
    i = i+1;
    tline = fgetl(fid);
end
fclose(fid);
%Load list of images
fid = fopen('names.txt');
tline = fgetl(fid);
i=1;
while ischar(tline)
    names{i} = strcat('i_',tline(1:end-4));
    i = i+1;
    tline = fgetl(fid);
end
fclose(fid);


%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                GET VALID DATA                           %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for img=1:length(names)
    images_count.(regexprep(names{img},'[-/\s]','')) = 0;
    for k=1:length(attributes)
        images.(regexprep(names{img},'[-/\s]','')).(attributes{k}) = [];
    end
end    


%For each survey
for id=1:length(data_valid)
    if (length(fieldnames(data_valid{id}))<13)
            continue;
    end
    %for every image in the survey
    for img=1:(length(fieldnames(data_valid{id}))-2)   
        index = sprintf('alpha_%d',img);
        %If control img
        if (strcmp(data_valid{id}.(index).image, 'blue-fabric_5PCs.png'))
            glossy = str2double(data_valid{id}.(index).answers.glossy);
            matte = str2double(data_valid{id}.(index).answers.matte);
            metallic = str2double(data_valid{id}.(index).answers.metallic);
            refstrng = str2double(data_valid{id}.(index).answers.metallic);
            refsharp = str2double(data_valid{id}.(index).answers.refsharp);
            if ((glossy==4 || glossy==5) || (metallic==4 || metallic==5) || (refstrng==4 || refstrng==5) || (refsharp==4 || refsharp==5))
                data_valid{id}=[];
                break;
            end
                       
        end             
    end    
    if (~isempty(data_valid{id}))
        for img=1:(length(fieldnames(data_valid{id}))-2)
            index = sprintf('alpha_%d',img);
            image = strcat('i_',regexprep((data_valid{id}.(index).image),'[-/\s]',''));
            image = image(1:end-4);
            images_count.(image) = images_count.(image)+1;
            for k=1:length(attributes)
                    images.(image).(attributes{k})=[images.(image).(attributes{k});str2double(data_valid{id}.(index).answers.(attributes{k}))];
            end 
        end
    end
        
end
data_valid_valid = data_valid(~cellfun('isempty',data_valid));

%If a BRDF is confusing for users (Q3-Q1 > 3 for >4 attributes) discard BRDF
%If a BRDF is not seen by at least 5 users, discard BRDF
id = 1;
imgs = fieldnames(images);
att = fieldnames(images.i_001);

for i=1:length(imgs)
    mtx = [];
    if (length(images.(imgs{i}).(att{1}))<5)
        images_invalid{id} = imgs{i};
        id=id+1;
        continue;
    end
    for k=1:length(att)
        mtx = [mtx;(images.(imgs{i}).(att{k}))'];
    end
    
    Y = prctile(mtx',[25 50 75],1);
    dif = Y(3,:)-Y(1,:);
    if ((sum(dif>=3))>4)
        images_invalid{id} = imgs{i};
        id = id+1;
    end
    if (isempty(mtx))
        images_invalid{id} = imgs{i};
        id = id+1;
    end
end
images_valid = rmfield(images,images_invalid);


imgs = fieldnames(images_valid);
clear att
fid = fopen('attributes.txt');
tline = fgetl(fid);
i=1;
while ischar(tline)
    att{i} = tline(1:end);
    i = i+1;
    tline = fgetl(fid);
end
fclose(fid);

mtx = zeros(length(imgs),length(att));
kd = 1.5;
for i=1:length(imgs)
    for k=1:length(att)
        %Remove outliers
        v = images_valid.(imgs{i}).(att{k});
        Q = prctile(v,[25 50 75],1);
        Qd = Q(3)-Q(1);
        v(v<Q(1) - kd*Qd)=0;
        v(v>Q(3) + kd*Qd)=0;
        v = v(v~=0);
        mtx(i,k) = (mean(v) - 1)/4;
    end
end

ans_mtx.values = mtx;
ans_mtx.names = imgs;
save('_final_ans_mtx.mat','ans_mtx');

clear all
close all
Natt = 14;
Npcs = 5;
%Load vectors answers
load('_final_ans_mtx.mat');

%Load images L - PCs
fid = fopen('names.txt');
tline = fgetl(fid);
i=1;
while ischar(tline)
    names{i} = strcat('i_',tline(1:end-4));
    i = i+1;
    tline = fgetl(fid);
end
fclose(fid);
path = 'projections_Lab/';
list = dir(strcat(path,'*.mat'));
L_mtx = zeros(Npcs,length(list));
for i=1:length(list)
    load(strcat(path,list(i).name));
    L_names{i} = strcat('i_',regexprep(list(i).name(1:end-4),'[-/\s]',''));
    L_mtx(:,i) = L;
end

MTX = zeros(size(ans_mtx.values,1),Natt+Npcs);
for i=1:length(ans_mtx.names)
    MTX(i,1:Natt) = ans_mtx.values(i,1:Natt);
    k = strmatch(ans_mtx.names(i),L_names);
%     if (~isempty(k))
        MTX(i,Natt+1:Natt+Npcs) = L_mtx(:,k)/100;
%     else
%         fprintf(ans_mtx.names)
%     end
end
save('_final_mtx.mat','MTX');
