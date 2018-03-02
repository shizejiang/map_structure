function [ field_para, res ] = parse_field( text )

res=0;
field_para='';

k = strfind(text,'=');
if isempty(k)
   res=-1;
   return;
end

field_para = text(k(1)+1:end);
%%remove space
field_para(isspace(field_para))=[];
if isempty(field_para)
   res=-1;
   return;
end


end

