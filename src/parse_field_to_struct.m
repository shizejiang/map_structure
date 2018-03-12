function [ o_struct, text, res ] = parse_field_to_struct( field_items, text)

%output init
o_struct=struct();
res=0;

%Parse MUST fields
for i=1:1:length(field_items)
    c_field=field_items{i};
    para_type = c_field(1);
    c_field(1)=[];
    
    [text, field_para, res ] = parse_field( text, c_field, 1 );
    if res==-1
        disp(['parse field: ''' c_field ''' error!']);
        return;
    end
    
    if strcmp(para_type,'d')%if value of filed is digital
        [field_para, status] = str2num(field_para);
        if status==0
            disp(['not a number value of field: ''' c_field '''']);
            res=-1;
            return;
        end
    else
        
    end
 
    c_field(strfind(c_field,'.'))=[];
    o_struct.(c_field)=field_para;  
end

end

