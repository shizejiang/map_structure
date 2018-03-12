function [ general_struct, res ] = parse_GENERAL_info( text )

global general_field;

res=0;
general_struct=struct();

%if need modify the strings of fields
%modify the '/*general field*/' meanwhile
general_field = {'.element_name';
                 '.author';
                 '.timestamp';
                 '.version'};
     
for i=1:1:length(general_field)
    [ text, field_para, res ] = parse_field( text, general_field{i}, 1 );
    if res==-1
        disp(['parse field: ''' general_field{i} ''' error!']);
        return;
    end
    
    c_field=general_field{i};
    general_struct.(c_field(2:end))=field_para;
    disp([c_field ':' field_para]);
    
end

end

