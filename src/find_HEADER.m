function [ all_text, extract_text, res ] = find_HEADER( all_text, sc, ec, is_del, is_print )

%%output init
res=0;
extract_text={};

g_start = find_str_line(all_text(:,2),sc);
g_end   = find_str_line(all_text(:,2),ec);

if length(g_start)~=length(g_end)
    disp(['number of ''' sc ''' is:' num2str(length(g_start))]);
    disp('but');
    disp(['number of ''' ec ''' is:' num2str(length(g_end))]);
    res=-1;
    return;
end

if isempty(g_start) || isempty(g_end)
    if is_print
        disp(['remain ''' sc '''' ' and ''' ec ''' is:0']);
    end
    res=-1;
    return;
end


if g_start(1)>g_end(1)
    disp(['''' sc ''' should before ''' ec '''']);
end

if is_print
    disp(['remain ''' sc '''' ' and ''' ec ''' is:' num2str(length(g_start))]);
end

if strcmp(sc,ec)
    if length(g_start)<2
        res=-1;
        return;
    end
    extract_text=all_text(g_start(1):g_start(2)-1,:);
    
    if is_del
        all_text(g_start(1):g_start(2)-1,:)=[];
    end
    
else
    extract_text=all_text(g_start(1)+1:g_end(1)-1,:);

    if is_del
        all_text(g_start(1):g_end(1),:)=[];
    end
end


end

