function [ output_args ] = parse_SECTION_info( input_args )

global section_field;
global node_field;


section_field={'.id';
               '.host_lat';
               '.host_lon';
               '.host_alt';
               '.host_heading';
               '.host_position_accu';
               '.host_heading_accu'};
        
node_field={'.node_id';
            '..x';
            '..y';
            '..z'};


end

