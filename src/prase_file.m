function [ ] = prase_file( folder, file_name)

%%open file
folder_file_name = [folder '\' file_name];
[fid,message]=fopen(folder_file_name,'rt');
if -1==fid
   disp([folder_file_name ':' message]);
   return;
end

all_text={};
tline='';
line_num=0;
while ischar(tline)
    tline=fgetl(fid);
    line_num=line_num+1;
    if isempty(tline) || ~ischar(tline)
       continue; 
    end
    tline = remove_comment(tline, '#');
    if isempty(tline)
       continue; 
    end
    
    if isempty(all_text)
        all_text={line_num tline};
    else
        all_text(end+1,:)={line_num tline};
    end 
    
end
fclose(fid);

%% find GENERAL info & parsing
[ all_text, general_text, res ] = find_GENERAL_info( all_text );
if res==-1
    disp('parse ''GENERAL'' header error');
    return;
end

[ general_struct, res ] = parse_GENERAL_info( general_text );
if res==-1
    disp('parse ''GENERAL'' field error');
    return;
end

%% find SECTION info & parsing
section_exist = 1;
while(section_exist)
    
    
    
end



end