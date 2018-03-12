function [text, field_para, res ] = parse_field( text, field, is_del )


%% init output
res=0;
field_para='';

%% find field line
if isempty(text)
    disp(['missing field: ''' field '''']);
    res=-1;
    return;
end

k=find_str_line(text(:,2),field);
if isempty(k)
    disp(['missing field: ''' field '''']);
    res=-1;
    return;
end
tline = text{k(1),2};

%% if need to delete
if is_del
    
    text(k(1),:)=[];
    
end

%% find the value of field
k = strfind(tline,'=');
if isempty(k)
    disp(['missing value of field: ''' field '''']);
    res=-1;
    return;
end

field_para = tline(k(1)+1:end);
%%remove space
field_para(isspace(field_para))=[];
if isempty(field_para)
    disp(['empty value of field: ''' field '''']);
    res=-1;
    return;
end


end

