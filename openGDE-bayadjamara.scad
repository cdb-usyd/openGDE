//Parameters to change
/* [Component to load] */
component = "example"; // [GDE, gasket, Aq, Aq_resin, gdl_insert, membrane_holder_upper, membrane_holder_lower, mesh_insert, mesh_mod, example, calibration_piece, spacer, pressure_top, pressure_bottom,tube_mold, none]

/* [Global parameters] */
// in mm  //OD = 11.2838 is 1cm^2 area of electrode
GDE_OD = 11.2838; //[9:0.0001:50]     
// in mm //GDE cake or flow field insert thickness
GDE_H = 1.5; // [0.5:0.05:10.0]

//Add text to your printed reactor
serial = "CDB";
textsize = 3;
textdepth = 0.2; //[0.1:0.02:1.5]
//larger = smoother
$fn=100; //[10:1000]
//how many facets make up each edge (100 is usually good, larger numbers are higher resolution but take longer to load.)


//make a multiple of nozzle diameter
wall = 1.6; //four lines of 0.4 mm
bolt_d = 3.2; //m3 (calibrate)
bolt_hex_d = 6.5; //m3 (calibrate)
bolt_hex_h = 1.5;//0.8;
trapped_hex_h = 2.5; //measured height of m3 nut 2.3 mm (calibrate)
bolt_inset_h = 0.12; 
wire_d = 0.65; //0.45 too small
tubing = 4.2; //diameter of the inlet/outlet tubing (calibrate)
//the extra diameter of the flattened part of the tube
tubing_extra = 1.5;
//tube mould
tube_id = 2;
tube_od = tubing+tubing_extra;
nubbinh = 3;
base = 2;


tubing_location = (GDE_OD-tubing-tubing_extra)/2; 

///* [GDE specific variables] */

GDE_ref = true;
wire_knot = true; //insert a knotted wire from inside to outside
bridge_m3 = true;
// tick if printing on smooth glass - use support
mating_face_down = false;
// tick if using GDL insert
include_alignment_pin = false; //whether the GDE component has an alignment cutout for the GDL insert

/* [gasket variables] */
gasket_h = 0.45;
gasket_OD = GDE_OD+3*wall;
gasket_ID = GDE_OD-1*wall;

gas_chamber_h = GDE_H + 2*wall; //2 walls is a good starting point, increase if desired

/* [Aq specific variables] */
//match or make larger than GDE_OD
aqueous_chamber_d = 12; //[9:0.1:50]
//aqueous chamber height
chamber_h = 25; //[10:1:100]
chamber_transition_height = 10;
chamber_base_h = 2*wall; //2 walls is a good starting point, increase if desired
// whether you want nut recesses
aqueous_nuts = true;
// optional whether you want all nuts to have recesses
aqueous_nuts_all = false; //optional
//recommended on for resin, off for FDM (see slicer trick)
inbuilt_mesh = false;
//recommended for resin, optional for FDM
sloped_base = false;
//recommended for resin, not needed for FDM
drain_hole = false; 
//drainage hole for resin print
drain_hole_d = 1.0; // [0.1:0.1:2.0]
//Not recommended
no_base = false;



/* [gdl_insert specific variables] */
//gdl_insert flow field type
flowfieldtype = "parallel"; //[pin, parallel]
//bigger = looser
flowfield_tolerance = 0.2; //make bigger if the insert does not fit the GDE hole. Make smaller if the insert is too small

gdl_path_w = 0.4; // [0.01:0.01:8]
gdl_wall = 0.45; // [0.2:0.1:1.6]
ff_gas_inlet_d = 1.2; //the hole through which gas enters and leaves
solid_layer = 0.90; //the base of the insert, must be smaller than GDE_H-layer_height
alignment_pin = 0.8;
FF_GDE_OD = GDE_OD-2*flowfield_tolerance;
count = FF_GDE_OD/(gdl_path_w+gdl_wall);

/* [spacer parameters] */
spacer_w = 10; //[5:0.1:30]
//ensure this is smaller than your bed width
spacer_l = 100; // [40:1:300]
//This gets added to the height, a calibration workaround.
depth_offset = 0; // [-0.5:0.001:0.5]

/* [example parameter] */
cutout = false;

/* [Hidden] */
cal_d = gas_chamber_h-bolt_inset_h; 
cal_w = tubing+tubing_extra + 2*wall;
cal_l = 5*wall + 2*bolt_hex_d + 2*(tubing+tubing_extra);
//one layer for base (check either water tight or mesh slicer trick)
cal_layer = 0.2; 


mesh_h = 0.8; //the height for mesh. 0.8 mm is four layers of 0.2 mm, which seems good for strength
mesh_x = 0.7;
mesh_lw = 0.45;
resin_slope_h = 5;
m3_head = 6.0; //5.55 mm, so 6 for space.


//[GDE, Aq, Aq_resin, gasket, membrane_holder_upper, membrane_holder_lower, example]

if (component == "GDE"){
    if (mating_face_down == false){rotate([180,0,0])GDE();}else{GDE();}
    } else if (component == "gdl_insert"){
        gdl_insert();
    } else if (component == "Aq") {
        aqueous();
    } else if (component == "Aq_resin"){
        rotate([180,0,0])aqueous();
    } else if (component == "Aq_mod"){
        aq_mod();
    } else if (component == "gasket"){
        gasket();
    } else if (component == "membrane_holder_upper"){
        membrane_cage_u();
    } else if (component == "membrane_holder_lower"){
        membrane_cage_l();
    } else if (component == "mesh_insert"){
        mesh_insert();
    } else if (component == "mesh_mod"){
        mesh_mod();
    } else if (component == "example" && cutout == false){
        example();
    } else if (component == "example" && cutout == true){
        difference(){
            example();
            translate([0,-(GDE_OD+4*wall+2*bolt_hex_d)/2,0])cube([(GDE_OD+4*wall+2*bolt_hex_d)/2,GDE_OD+4*wall+2*bolt_hex_d,20]);
        }
    } else if (component == "calibration_piece"){
        calibration();
    } else if (component == "spacer"){
        spacer();
    } else if (component == "pressure_top"){
    if (mating_face_down == false){rotate([180,0,0])pressure_top();}else{pressure_top();}
    } else if (component == "pressure_bottom"){
        if (mating_face_down == false){rotate([180,0,0])pressure_bottom();}else{pressure_bottom();}
    } else if (component == "tube_mold"){
        tube_mold();
    } else if (component == "none"){
        //render nothing
    }


module calibration(){
    difference(){
        calibration_tool();
       translate([cal_l/2,textdepth,cal_d/2-textsize/2])rotate([90,0,0])linear_extrude(textdepth)text(serial,size=textsize, halign="center",valign="bottom");
    }
}

module calibration_tool(){ 
    
    difference(){
        cube([cal_l,cal_w,cal_d]);
        //m3#1
        translate([1*wall+bolt_hex_d/2,cal_w/2,0])countersunk_m3();
        //tubing
        translate([2*wall+bolt_hex_d+(tubing+tubing_extra)/2,cal_w/2,cal_d])rotate([180,0,0])countersunk_tubing_deep();
        //basin
        translate([3*wall+bolt_hex_d+tubing+tubing_extra+(tubing+tubing_extra)/2,cal_w/2,cal_layer])rotate([0,0,0])cylinder(h=cal_d-cal_layer,d=tubing+tubing_extra);
        //m3#2
        translate([4*wall+bolt_hex_d+2*(tubing+tubing_extra)+bolt_hex_d/2,cal_w/2,cal_d])rotate([0,180,0])countersunk_m3_bridged();
        //wires
        translate([wall+bolt_hex_d+wall/2,0,wall/2])rotate([0,0,90]){
            cube([cal_w,wire_d,wire_d]);
            translate([0,-wire_d/4,-wire_d/4])cube([cal_w/2,wire_d*1.5,wire_d*1.5]);}
        
    }
}

module GDE(){
    difference(){
        half_cell_gas();
        translate([0,tubing_location,gas_chamber_h-textdepth])linear_extrude(textdepth)text(serial,size=textsize,halign="center",valign="bottom");
    }
}

module pressure_top(){
    difference(){
        pressure_top_component();
        translate([0,tubing_location,gas_chamber_h-textdepth])linear_extrude(textdepth)text(serial,size=textsize,halign="center",valign="bottom");
    }
}

module pressure_bottom(){
    difference(){
        pressure_bottom_component();
        translate([0,tubing_location,gas_chamber_h-textdepth])linear_extrude(textdepth)text(serial,size=textsize,halign="center",valign="bottom");
    }
}

module aqueous(){
    difference(){
        aqueous_chamber();
        translate([aqueous_chamber_d/2+wall-textdepth,0,chamber_base_h+resin_slope_h+chamber_transition_height+chamber_h/2])rotate([0,90,0])linear_extrude(textdepth)text(serial,size=textsize,valign="center");
    }
}

module example(){

color([0,0,1])translate([0,0,15])half_cell_gas();
translate([0,0,12])gasket();
color([1,0,0])translate([0,0,10])cylinder(h=0.2, d = GDE_OD+4*wall+2*bolt_hex_d);
translate([0,0,08])gasket();
translate([0,0,5])rotate([0,180,0])half_cell_gas();
    
}

module aqueous_chamber() {
    difference(){
        union(){
            //bottom
        cylinder(h=chamber_base_h+bolt_hex_h, d = GDE_OD+2*wall);
            //slope
        translate([0,0,chamber_base_h+bolt_hex_h])cylinder(h=chamber_transition_height, d1 = GDE_OD+2*wall, d2 = aqueous_chamber_d+2*wall);
            //top
        translate([0,0,chamber_base_h+bolt_hex_h+chamber_transition_height])cylinder(h=chamber_h, d = aqueous_chamber_d+2*wall);
        }
        union(){
        //bottom
        if (no_base == true){
            cylinder(h=chamber_base_h+bolt_hex_h, d = GDE_OD);
        } else if (inbuilt_mesh == true){
            mesh();
            } else if (component == "Aq_resin"){
                mesh();
                } else {
                    translate([0,0,mesh_h])cylinder(h=chamber_base_h+bolt_hex_h-mesh_h, d = GDE_OD);
                    }
        //slope
        translate([0,0,chamber_base_h+bolt_hex_h])cylinder(h=chamber_transition_height, d1 = GDE_OD, d2 = aqueous_chamber_d);
        //top
        translate([0,0,chamber_base_h+bolt_hex_h+chamber_transition_height])cylinder(h=chamber_h, d = aqueous_chamber_d);   
        

    }
    //drainage hole
           if (drain_hole == true){
               drainage_hole();
               } else if (component == "Aq_resin"){
                    drainage_hole();
               }
           }
    //base for bolts
    difference(){
        union(){
        cylinder(h=chamber_base_h+bolt_hex_h, d = GDE_OD+4*wall+2*bolt_hex_d);
        if (sloped_base == true){
            translate([0,0,chamber_base_h+bolt_hex_h])cylinder(h=resin_slope_h, d1 = GDE_OD+4*wall+2*bolt_hex_d, d2 = GDE_OD+2*wall);
            } else if (component == "Aq_resin") {
                translate([0,0,chamber_base_h+bolt_hex_h])cylinder(h=resin_slope_h, d1 = GDE_OD+4*wall+2*bolt_hex_d, d2 = GDE_OD+2*wall);
            }
        }
        cylinder(h=chamber_base_h+bolt_hex_h+resin_slope_h, d = aqueous_chamber_d);
        //nut insets
        
            for(i=[-1:2:1]){
            radius_out = (GDE_OD + 2*wall + bolt_hex_d)/2;
            //on axis holes
            translate([i*radius_out,0,0]){
                if (aqueous_nuts_all == true){countersunk_m3_resin();} else {countersunk_m3_head();}
                }
            translate([0,i*radius_out,0])if (aqueous_nuts_all == true){countersunk_m3_resin();} else {countersunk_m3_head();}
            for(j=[-1:2:1]){
                //off axis holes  
                translate([i*(sin(45)*radius_out),j*(cos(45)*radius_out),0])if (aqueous_nuts == true){countersunk_m3_resin();} else {countersunk_m3_head();}
                }
            }
    }
}

module half_cell_gas() {
    wire_l = 2*wall+bolt_hex_d+wire_d/4+0.1;
    ref_ang = 70;
    wire_ang = 45/2;
    
    difference(){
        cylinder(h=gas_chamber_h, d = GDE_OD+4*wall+2*bolt_hex_d);
        cylinder(h=GDE_H, d = GDE_OD);

        // alignment pin  
        if (include_alignment_pin == true)translate([-alignment_pin/2,GDE_OD/2-gdl_wall,0])cube([alignment_pin+flowfield_tolerance,alignment_pin+gdl_wall+flowfield_tolerance,GDE_H], center=false);
        //nut insets
        for(i=[-1:2:1]){
        radius_out = (GDE_OD + 2*wall + bolt_hex_d)/2;
        //on axis holes
        translate([i*radius_out,0,0]){if(bridge_m3==true){countersunk_m3_bridged();}else{countersunk_m3();}}
        translate([0,i*radius_out,0]){if(bridge_m3==true){countersunk_m3_bridged();}else{countersunk_m3();}}
        for(j=[-1:2:1]){
            //off axis holes  
            translate([i*(sin(45)*radius_out),j*(cos(45)*radius_out),0])cylinder(h=gas_chamber_h, d=bolt_d);
            }
        }
        //tubing inlets 
        translate([tubing_location,0,GDE_H])countersunk_tubing();
        translate([-tubing_location,0,GDE_H])countersunk_tubing();
    //reference wire
    if(GDE_ref == true){
        #translate([cos(ref_ang)*GDE_OD/2+wire_d/2,sin(ref_ang)*GDE_OD/2-wire_d/2,0])rotate([0,0,ref_ang])cube([wire_l,wire_d,wire_d]);
    }
    //current collector wire
    translate([cos(wire_ang)*(wire_l+GDE_OD-wire_d/4)/2,sin(wire_ang)*(wire_l+GDE_OD-wire_d/4)/2,GDE_H-wire_d/2])rotate([0,0,wire_ang]){
         cube([wire_l,wire_d,wire_d],center = true);
         if(wire_knot == true){
             translate([-wire_l/4,0,0])cube([wire_l/2,wire_d*1.5,wire_d*1.5],center = true);
             }
    }}
    if(component == "example"){
        //load red tubes for gas inlet/outlet
        translate([tubing_location,0,GDE_H])tubing();
        translate([-tubing_location,0,GDE_H])tubing();
    }
}

module gdl_insert(){
    union(){
    translate([-alignment_pin/2,FF_GDE_OD/2-gdl_wall,0])cube([alignment_pin,alignment_pin+gdl_wall,GDE_H], center=false);
    translate([0,0,solid_layer])flowfieldring();
    difference(){
        cylinder(h=GDE_H, d=FF_GDE_OD);
        translate([0,0,solid_layer])flowfield();        
        //gas in/out
        translate([tubing_location,0,0])cylinder(h=GDE_H,d=ff_gas_inlet_d);
        translate([-tubing_location,0,0])cylinder(h=GDE_H,d=ff_gas_inlet_d);
    }
}
}


module flowfield(){
    if (flowfieldtype == "parallel"){
        dist = gdl_path_w+gdl_wall;
        for (i = [-count/2+1:1:count/2-1])
             #translate([i*dist,0,(GDE_H-solid_layer)/2])cube([gdl_path_w, sqrt(pow(FF_GDE_OD-2*gdl_wall,2)-pow(dist*2*i,2)),GDE_H-solid_layer], center = true);
       
           difference(){
            cylinder(h=GDE_H-solid_layer,d=FF_GDE_OD-2*gdl_wall);
            cylinder(h=GDE_H-solid_layer,d=FF_GDE_OD-4*gdl_wall);
        }
    }
    if (flowfieldtype == "pin"){ 
        for (i = [-count/2:1:count/2]){
            translate([i*(gdl_path_w+gdl_wall),-FF_GDE_OD/2,0])cube([gdl_path_w,FF_GDE_OD,GDE_H-solid_layer]);//X-axis
            translate([-FF_GDE_OD/2,i*(gdl_path_w+gdl_wall),0])cube([FF_GDE_OD,gdl_path_w,GDE_H-solid_layer]);//Y-axis
        }
        difference(){
            cylinder(h=GDE_H-solid_layer,d=FF_GDE_OD-2*gdl_wall);
            cylinder(h=GDE_H-solid_layer,d=FF_GDE_OD-4*gdl_wall);
    }}
}

module flowfieldring(){
    difference(){
        cylinder(h=GDE_H-solid_layer,d=FF_GDE_OD);
        cylinder(h=GDE_H-solid_layer,d=FF_GDE_OD-2*gdl_wall);
    }
}

module mesh_insert(){
    cylinder(h=mesh_h, d=GDE_OD);
}

module gasket() {
    difference(){
        cylinder(h=gasket_h, d = GDE_OD+4*wall+2*bolt_hex_d);
        cylinder(h=gasket_h, d = GDE_OD);
        //bolt holes
        for(i=[-1:2:1]){
        radius_out = (GDE_OD + 2*wall + bolt_hex_d)/2;
        //on axis holes
        translate([i*radius_out,0,0])cylinder(h=gasket_h,d=bolt_d);
        translate([0,i*radius_out,0])cylinder(h=gasket_h,d=bolt_d);
            for(j=[-1:2:1]){
            //off axis holes  
           translate([i*(sin(45)*radius_out),j*(cos(45)*radius_out),0])cylinder(h=gasket_h,d=bolt_d);
            }
        }
    }
}

module membrane_cage_l(){
    difference(){
        cylinder(h=mesh_h+gasket_h, d = GDE_OD+4*wall+2*bolt_hex_d+3*wall-flowfield_tolerance);
        translate([0,0,mesh_h])cylinder(h=gasket_h, d = GDE_OD+4*wall+2*bolt_hex_d+wall);

    }
}

module membrane_cage_u(){
    difference(){
        cylinder(h=2*mesh_h+gasket_h, d = GDE_OD+4*wall+2*bolt_hex_d+5*wall);
        #translate([0,0,mesh_h])cylinder(h=mesh_h+gasket_h, d = GDE_OD+4*wall+2*bolt_hex_d+3*wall);

    }
}


module spacer(){
    difference(){
        cube([spacer_w, spacer_l, GDE_H+depth_offset], center = false);
        #translate([spacer_w/2,wall,GDE_H+depth_offset-textdepth])linear_extrude(textdepth)text(str(GDE_H),size=textsize, halign = "center");
    }
}

module pressure_top_component() {
    difference(){
        cylinder(h=gas_chamber_h, d = GDE_OD+4*wall+2*bolt_hex_d);
        cylinder(h=GDE_H, d = GDE_OD);
       //nut insets
        for(i=[-1:2:1]){
        radius_out = (GDE_OD + 2*wall + bolt_hex_d)/2;
        //on axis holes
        translate([i*radius_out,0,0]){if(bridge_m3==true){countersunk_m3_bridged();}else{countersunk_m3();}}
        translate([0,i*radius_out,0]){if(bridge_m3==true){countersunk_m3_bridged();}else{countersunk_m3();}}
        for(j=[-1:2:1]){
            //off axis holes  
            translate([i*(sin(45)*radius_out),j*(cos(45)*radius_out),0])cylinder(h=gas_chamber_h, d=bolt_d);
            }
        }
        translate([0,0,GDE_H])countersunk_tubing();
    }
}

module pressure_bottom_component() {
    
    difference(){
        cylinder(h=gas_chamber_h, d = GDE_OD+4*wall+2*bolt_hex_d);
        cylinder(h=GDE_H, d = GDE_OD);
       //nut insets
        for(i=[-1:2:1]){
        radius_out = (GDE_OD + 2*wall + bolt_hex_d)/2;
        //on axis holes
        translate([i*radius_out,0,0]){if(bridge_m3==true){countersunk_m3_bridged();}else{countersunk_m3();}}
        translate([0,i*radius_out,0]){if(bridge_m3==true){countersunk_m3_bridged();}else{countersunk_m3();}}
        for(j=[-1:2:1]){
            //off axis holes  
            translate([i*(sin(45)*radius_out),j*(cos(45)*radius_out),0])cylinder(h=gas_chamber_h, d=bolt_d);
            }
        }
    }
}

module tube_mold(){
    cylinder(h=base,d=2*wall+tube_od);
    translate([0,0,base])cylinder(h=nubbinh,d1=tube_id,d2=tube_id/2);
    translate([0,0,base])difference(){
        cylinder(h=wall,d=2*wall+tube_od);
        cylinder(h=wall,d=tube_od);
    }
}

//sub assemblies

module mesh_mod(){
    cylinder(h=mesh_h,d=GDE_OD);
}

module countersunk_m3_head(){
    cylinder(h = chamber_base_h+bolt_hex_h, d = bolt_d);
    translate([0,0,chamber_base_h+bolt_hex_h])cylinder(h=resin_slope_h,d=m3_head);
}
module countersunk_m3() {
    cylinder(h=chamber_base_h+bolt_hex_h,d=bolt_d);
    translate([0,0,chamber_base_h])cylinder(h=bolt_hex_h,d=bolt_hex_d,$fn=6);
}
module countersunk_m3_resin() {
    cylinder(h=chamber_base_h+bolt_hex_h+resin_slope_h,d=bolt_d);
    translate([0,0,chamber_base_h])cylinder(h=bolt_hex_h+resin_slope_h,d=bolt_hex_d,$fn=6);
}
module countersunk_m3_bridged() {
    cylinder(h=gas_chamber_h-bolt_inset_h-bolt_hex_h,d=bolt_d);
    translate([0,0,gas_chamber_h-bolt_hex_h])cylinder(h=bolt_hex_h,d=bolt_hex_d,$fn=6);
}


module countersunk_tubing() {
    cylinder(h=1,d=tubing+tubing_extra);
    cylinder(h=2*wall, d=tubing);
}

module countersunk_tubing_deep() {
    translate([0,0,0])cylinder(h=1,d=tubing+tubing_extra);
    cylinder(h=cal_d*1.1, d=tubing);
}

module countersunk_sideways_tubing(){
    translate([0,0,0])cylinder(h=1,d=tubing+2);
    cylinder(h=4*wall+bolt_hex_d, d=tubing);
}

module tubing(){
    color([1,0,0])cylinder(h=1,d=tubing+3);
    difference(){
        color([1,0,0])cylinder(h=40, d = tubing);
        cylinder(h=40, d = tubing-2);
    }
}

module mesh(){ //cylinder mesh for bottom (simple)
    translate([0,0,mesh_h])cylinder(h=chamber_base_h+bolt_hex_h-mesh_h, d = GDE_OD);
    difference(){
        for (i = [-10:1:10])
            for (j = [-10:1:10])
                translate([i*(mesh_lw+mesh_x),j*(mesh_lw+mesh_x),0])cube([mesh_x,mesh_x,mesh_h]);
    }
}

module drainage_hole(){
    translate([0,aqueous_chamber_d/2+wall,chamber_base_h+bolt_hex_h+chamber_transition_height+chamber_h])rotate([90,0,0])cylinder(h=1.1*wall,d=drain_hole_d);
    } 

