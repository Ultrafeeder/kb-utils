include <./constants.scad>;
// keys are vectors and rows are the first vector layer, and columns are vectors nested in rows

module hole_cutouts(keys, space=keyu, holesize=keyh, encoder=8.4){
  module stab_hole(){
    
}
 for(row=[0:len(keys)-1]) {
   for(col=[0:len(keys[row])-1])
     {
       let(
	   k=keys[row][col],
	   xsize=space*k[0],
	   xpos=(space*col)+(((k[0])-1)*space)+(k[2]*space),
	   ysize=space*k[1],
	   ypos=(space*row)+(((k[1])-1)*space)+(k[3]*space),
	   rotation=k[4],
	   isencoder=k[5]
	   )
	 {
	    translate([xpos,-ypos,0]){
	      if(!isencoder) 
		{
		  if(k[0]==2)
		    {
		      translate([xsize/2,ysize/2,0]) cube([holesize,holesize,25], center=true);
		    }
		      translate([xsize/2,ysize/2,0]) cube([holesize,holesize,25], center=true);
		}
	      else translate([xsize/2,ysize/2,0]) cylinder(h=25, d=encoder, center=true);
	    }
	 }
     }
 } 
}

module keycap_cutouts(keys, delta=0.02, space=keyu, encoder=12){
  for(row=[0:len(keys)-1]) {
   for(col=[0:len(keys[row])-1])
     {
       let(
	   k=keys[row][col],
	   xsize=space*k[0],
	   xpos=(space*col)+(((k[0])-1)*space)+(k[2]*space),
	   ysize=space*k[1],
	   ypos=(space*row)+(((k[1])-1)*space)+(k[3]*space),
	   rotation=k[4],
	   isencoder=k[5]
	   )
	 {
	    translate([xpos,-ypos,0]){
	      if(!isencoder) translate([xsize/2,ysize/2,0]) cube([xsize+delta,ysize+delta,25], center=true);
	      else translate([xsize/2,ysize/2,0]) cylinder(h=25, d=encoder, center=true);
	    }
	 }
     }
 }  
}

module gasket_holes(keys, key_depth, delta=0.02,space=keyu, pcb_holesize=keyg, key_holesize=keyh,  encoder=12){
   for(row=[0:len(keys)-1]) {
   for(col=[0:len(keys[row])-1])
     {
       let(
	   k=keys[row][col],
	   xsize=space*k[0],
	   xpos=(space*col)+(((k[0])-1)*space)+(k[2]*space),
	   ysize=space*k[1],
	   ypos=(space*row)+(((k[1])-1)*space)+(k[3]*space),
	   rotation=k[4],
	   isencoder=k[5]
	   )
	 {
	    translate([xpos,-ypos,0]){
	      if(!isencoder){
		translate([xsize/2,ysize/2,-4]) cube([pcb_holesize+delta, pcb_holesize+delta,5], center=true);
		translate([xsize/2,ysize/2,0]) cube([key_holesize+delta, key_holesize+delta, 10], center=true); 
	      }      
	      else 
		translate([xsize/2,ysize/2,0]) cube([encoder+delta,encoder+delta,8], center=true);
	    }
	 }
     }
 }
}
