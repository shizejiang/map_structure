function [ o_struct, e_section_field ] = parse_addition_field_to_struct( text, in_struct, e_section_field )

%% output init
o_struct = in_struct;

%% parse addition section fields
for i=1:size(text,1)
    tline = text{i,2};
    [ field_name, field_para, re ] = parse_addition_field( tline,'.' );
    if re==-1,  continue; end
       
    c_field_name{1} = ['s' field_name];
    e_section_field = [e_section_field; c_field_name];
    
    field_name(strfind(field_name,'.'))=[];
    o_struct.(field_name)=field_para;
    
end

end

