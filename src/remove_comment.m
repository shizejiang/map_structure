function [ tline ] = remove_comment( tline, comment_char )

%%remove comments
shape_index = find(tline==comment_char);
if ~isempty(shape_index)
    tline(shape_index(1):end)=[];
end
    

end

