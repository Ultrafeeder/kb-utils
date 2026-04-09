include <./constants.scad>;
// keys are vectors and rows are the first vector layer, and columns are vectors nested in rows

module hole_cutouts(keys, space=19.5, holesize=14, encoder=8.4){
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

module keycap_cutouts(keys=layout, delta=0.02, space=19.5, encoder=12){
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

module gasket_holes(keys=layout, delta=0.02,space=19.5, holesize=18, encoder=12){
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
	      if(!isencoder) translate([xsize/2,ysize/2,0]) cube([holesize+delta, holesize+delta,8], center=true);
	      else translate([xsize/2,ysize/2,0]) cube([encoder+delta,encoder+delta,8], center=true);
	    }
	 }
     }
 }
}

module heat_insert_columns(delta=0.1, width, hi_width, height)
{
  $fn=20;
  difference() 
    {
      cylinder(h=height, d=width, center=true);
      cylinder(h=height+delta, d=hi_width, center=true);
    }
}

cols=
  [
   [m2_colw, m2_hi_pilot, 10],
   [m3_colw, m3_hi_pilot, 20],
   [m4_colw, m4_hi_pilot, 30]
  ];

for(c=cols)
{
  translate([c[2],0,0]) heat_insert_columns(width=c[0], hi_width=c[1], height=8);
}



