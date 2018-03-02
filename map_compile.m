clear;clc;
addpath('src');
addpath('src/xml_io_tools');

input_file_folder='map_element_inputs';
output_file_folder='map_element_outputs';
disp('checking folder ''map_element_inputs''...');
input_file_names=get_input_files(input_file_folder);

for i=1:1:length(input_file_names)
   process_file=input_file_names{i};
   disp('----------------------------------------------');
   disp(['processing file:' process_file]);
   
   prase_file(input_file_folder,process_file);
   
end





