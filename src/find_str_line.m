function [ result ] = find_str_line( text, str )

k=strfind(text,str);
result=~cellfun('isempty', k);
result=find(result==1);

end

