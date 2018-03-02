function [ all_text, general_text, res ] = find_GENERAL_info( all_text )

gs_command = 'GENERAL_START';
ge_command = 'GENERAL_END';

%%output init
res=0;
general_text={};

g_start = find_str_line(all_text(:,2),gs_command);
g_end   = find_str_line(all_text(:,2),ge_command);

if length(g_start)>1
   disp(['more than one ''' gs_command ''' found!']);
   res=-1;
   return;
elseif isempty(g_start)
   disp(['no ''' gs_command ''' found!']);
   res=-1;
   return; 
end

if length(g_end)>1
   disp(['more than one ''' ge_command ''' found!']);
   res=-1;
   return;
elseif isempty(g_end)
   disp(['no ''' ge_command ''' found!']);
   res=-1;
   return; 
end

if g_start>=g_end
    disp(['''' gs_command ''' should before ''' ge_command '''']);
end

general_text=all_text(g_start+1:g_end-1,:);
all_text(g_start:g_end,:)=[];


end

