% clear;
clc;
addpath('src');
addpath('src/xml_io_tools');
addpath('src/projection');

input_file_folder='map_element_inputs';
output_file_folder='map_element_outputs';
disp('checking folder ''map_element_inputs''...');
input_file_names=get_input_files(input_file_folder);

for i=1:1:length(input_file_names)
   process_file=input_file_names{i};
   disp('-----------------------------------------------------------------------------------------------------------');
   disp(['processing file:''' process_file '''']);
   
   [general_struct, map_xml, res ] = prase_file(input_file_folder,process_file);
   if res==-1
      disp(['parse file:' process_file ' error']);
      continue;
   end
   osm = map_xml;
   
   
   prefix = 'map_element_outputs/';
   suffix_filename = ['map_' general_struct.element_name '_' general_struct.author '_' general_struct.timestamp '_' general_struct.version '.osm'];
   save_filename = [prefix suffix_filename];
   
   disp(['parsing file Complete, Writing file:''' save_filename '''']);
   
   Pref=[];Pref.NoCells = false;Pref.CellItem = false;Pref.StructItem = false;
   xml_write(save_filename, osm, 'osm',Pref);
   disp('Writing file Complete!');
end







