function [general_struct, map_xml, res ] = prase_file( folder, file_name)

%% init output
res=0;
general_struct = struct();
map_xml = struct();


%% common attribute
map_xml.ATTRIBUTE.generator='JOSM';
map_xml.ATTRIBUTE.version=0.6;
map_xml.node={};
map_xml.way={};


%% open file
folder_file_name = [folder '\' file_name];
[fid,message]=fopen(folder_file_name,'r','n','utf-8');
if -1==fid
   disp([folder_file_name ':' message]);
   res=-1;
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
[ all_text, general_text, res ] = find_HEADER( all_text, 'GENERAL_START', 'GENERAL_END', 1, 0 );
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
%get section header
%/*general field*/
sec_name = [upper(general_struct.element_name) '_SECTION_'];
s_sec = [sec_name 'START'];
e_sec = [sec_name 'END'];

%get extra field
%/*general field*/
if strcmp(general_struct.element_name,'curb')
    [e_section_field, e_node_field] = get_CURB_field();
elseif strcmp(general_struct.element_name,'lane_line')
    [e_section_field, e_node_field] = get_LANE_LINE_field();
elseif strcmp(general_struct.element_name,'lane_marker') 
    [e_section_field, e_node_field] = get_LANE_MARKER_field();
elseif strcmp(general_struct.element_name,'lane')
    [e_section_field, e_node_field] = get_LANE_field();
elseif strcmp(general_struct.element_name,'traffic_sign')
    [e_section_field, e_node_field] = get_TRAFFIC_SIGN_field();
else
    disp(['element_name is unknown: ' general_struct.element_name]);
    res=-1;
    return;
end

%parsing
sec_count = 0;
while(1)
    [ all_text, sec_text, res ] = find_HEADER( all_text, s_sec, e_sec, 1, 1 );
    if res==-1
        if sec_count~=0,    res=0;end
        break;
    end
    
    [ map_xml, res ] = parse_SECTION_info(sec_text, map_xml, general_struct, e_section_field, e_node_field);
    if res==-1
        disp('parse ''SECTION'' error');
        return;
    end
    
    %%if section parse success
    sec_count = sec_count + 1;
end







end