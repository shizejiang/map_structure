function [ general_struct, res ] = parse_GENERAL_info( text )

global general_field;

res=0;
general_struct=struct();

general_field = {'.element_name';
                 '.author';
                 '.timestamp';
                 '.version'};
     
for i=1:1:length(general_field)
    k=find_str_line(text(:,2),general_field{i});
    if isempty(k)
        disp(['missing field: ''' general_field{i} '''']);
        res=-1;
        return;
    end
    
    tline = text{k(1),2};
    [ field_para, res ] = parse_field( tline );
    if res==-1
       disp(['missing value of field: ''' general_field{i} '''']);
       return; 
    end
    
    c_field=general_field{i};
    general_struct.(c_field(2:end))=field_para;
    disp([c_field ':' field_para]);
    
end

end

