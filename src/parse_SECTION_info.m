function [ map_xml, res ] = parse_SECTION_info(sec_text, map_xml, general_struct, e_section_field, e_node_field )

%% init output
res = 0;

%if need modify the strings of section_field
%modify the '/*section field*/' meanwhile
section_field={'d.id';
               'd.host_lat';
               'd.host_lon';
               'd.host_heading'};

%if need modify the strings of node_field
%modify the '/*node field*/' meanwhile
node_field={'d.node_id';
            'd..x';
            'd..y'};
        
        
s_field=[section_field; e_section_field];
n_field=[node_field; e_node_field];

[ s_text, n_text, res ] = find_HEADER( sec_text, 'NODE_START', 'NODE_END', 1, 0 );
if res==-1
    disp('no ''NODE'' section found!');
    return;
end

%% parse section fields
[ s_struct, s_text, res ] = parse_field_to_struct( s_field, s_text);
if res==-1
    return;
end

%% parse addition section fields
[ s_struct, e_section_field ] = parse_addition_field_to_struct( s_text, s_struct, e_section_field );

%% TODO set way attr and tags
%/*section field*//*general field*/
tmp_way = struct();
tmp_way.ATTRIBUTE.user = general_struct.author;
tmp_way.ATTRIBUTE.timestamp = general_struct.timestamp;
tmp_way.ATTRIBUTE.version   = floor(str2num(general_struct.version));
tmp_way.ATTRIBUTE.id = s_struct.id;
%%add tags
for i=1:1:size(e_section_field,1)
    tmp_tag = struct();
    tmp_tag.CONTENT=[];
    field_name = e_section_field{i}(2:end);
    field_name(strfind(field_name,'.'))=[];
    tmp_tag.ATTRIBUTE.k=field_name;
    tmp_tag.ATTRIBUTE.v=s_struct.(field_name);
    
    tmp_way.tag(i,:)=tmp_tag;
end

%% parse node fields
c_field=n_field{1};node_field_start = c_field(2:end);node_field_end = node_field_start;n_text{end,2}=node_field_start;
node_count = 0;
while(1)
    node_count = node_count + 1;
    [ n_text, sn_text, re ] = find_HEADER( n_text, node_field_start, node_field_end, 1, 0 );
    if re==-1,  break; end;
    
    
    [ n_struct, sn_text, res ] = parse_field_to_struct( n_field, sn_text);
    if res==-1
        continue;
    end
    
    %% parse node addition fields
    te_node_field = e_node_field;
    [ n_struct, te_node_field ] = parse_addition_field_to_struct( sn_text, n_struct, te_node_field );
    
    %set xml struct
    %/*node field*//*section field*//*general field*/
    [ node_global ] = BackwardGaussProjection( s_struct.host_lat, s_struct.host_lon, s_struct.host_heading,n_struct.x,n_struct.y );
    tmp_node = struct();
    
    tmp_node.ATTRIBUTE.user = general_struct.author;
    tmp_node.ATTRIBUTE.timestamp = general_struct.timestamp;
    tmp_node.ATTRIBUTE.version   = floor(str2num(general_struct.version));
    tmp_node.ATTRIBUTE.id  = n_struct.node_id;
    tmp_node.ATTRIBUTE.lat = node_global(1);
    tmp_node.ATTRIBUTE.lon = node_global(2);
    %%add tags
    for i=1:1:size(te_node_field,1)
        tmp_tag = struct();
        tmp_tag.CONTENT=[];
        field_name = te_node_field{i}(2:end);
        field_name(strfind(field_name,'.'))=[];
        tmp_tag.ATTRIBUTE.k=field_name;
        tmp_tag.ATTRIBUTE.v=n_struct.(field_name);
        
        tmp_node.tag(i,:)=tmp_tag;
    end
    %%add node ref in way
    tmp_node_nf = struct();
    tmp_node_nf.CONTENT=[];
    tmp_node_nf.ATTRIBUTE.ref = tmp_node.ATTRIBUTE.id;
    tmp_way.nd(node_count,:) = tmp_node_nf;
    
    
    %add to xml struct
    map_xml.node{end+1} = tmp_node;
end

%add to xml struct
map_xml.way{end+1} = tmp_way;
end

