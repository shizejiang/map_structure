function [ field_name, field_para, res ] = parse_addition_field( text,sn )

%output init
field_name='';
field_para='';
res=0;

k1 = strfind(text,sn);
k2 = strfind(text,'=');

if isempty(k1)||isempty(k2)
   res=-1;
   return;
end

field_name = text(k1(1):k2(1)-1);
%%remove space
field_name(isspace(field_name))=[];
if isempty(field_name)
    disp(['empty field: ''' text '''']);
    res=-1;
    return;
end

c_text{1,2} = text;
[~, field_para, res ] = parse_field( c_text, field_name, 0 );
if res==-1
    disp(['parse field: ''' field_name ''' error!']);
    return;
end




end

