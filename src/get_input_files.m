function [ file_names ] = get_input_files( file_folder )

%%find all files in folder
dir_out=dir(fullfile(file_folder,'*'));
file_names={dir_out.name}';
file_names(1:2)=[];

disp('input files:');
for i=1:1:length(file_names)
    disp(['    ' file_names{i}]);
end

end

