// rows contain columns in vectors
layout = [
  [[1,1,0,.25,0,false], [1,1,0,0,0,false], [1,1,0,0,0,false], [1,1,0,0,0,false], [1,1,0,0,0,false], [1,1,0,0,0,false], [1,1,0,0,0,false]],

  [[1,1,0,.25,0,false], [1,1,0,0,0,false], [1,1,0,0,0,false], [1,1,0,0,0,false], [1,1,0,0,0,false], [1,1,0,0,0,false], [1,1,0,0,0,false]],

  [[1,1,0,.25,0,false], [1,1,0,0,0,false], [1,1,0,0,0,false], [1,1,0,0,0,false], [1,1,0,0,0,false], [1,1,0,0,0,false], [1,1,0,0,0,false]],

  [[1,1,0,.25,0,false], [1,1,0,0,0,false], [1,1,0,0,0,false], [1,1,0,0,0,false], [1,1,0,0,0,false], [1,1,0,0,0,false], [1,1,0,0,0,true]],

  [[1,1,0,.25,0,false], [1,1,0,0,0,false], [1,1,0,0,0,false], [1,1,0,1,0,false], [1,1,0,1,0,false], [1,2,0,0,0,false], [1,2,0,0,0,false]],
];


module hole_cutouts(rowCol=layout, space=19.5, holesize=14, encoder=8.4){
  module stab_hole(){
    
}
 for(row=[0:len(rowCol)-1]) {
   for(col=[0:len(rowCol[row])-1])
     {
       let(
	   k=rowCol[row][col],
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
// hole_cutouts();

module keycap_cutouts(rowCol=layout, delta=0.02, space=19.5, encoder=12){
  for(row=[0:len(rowCol)-1]) {
   for(col=[0:len(rowCol[row])-1])
     {
       let(
	   k=rowCol[row][col],
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
// translate([200,0,0]) keycap_cutouts();

points =[
	 [0,0],
	 [0,150],
	 [170,150],
	 [170,0]
];

module top_assembly(
		    polygon_points=points,
		    rowCol=layout,
		    top_plate_height=9,
		    top_plate_bottom_face_offset,
		    top_plate_key_cutout_pos,
		    key_plate_height=4,
		    key_plate_depth=1,
		    key_plate_offset,
		    key_plate_hole_cutout_pos
		    )
{
  module shape(p=polygon_points, h)
  {
   	linear_extrude(height=h, center = true, convexity = 10, twist = 0, slices = 20, scale = 1.0) polygon(p);
  }

  module top_plate()
  {
    difference() {
      minkowski() {
	shape(h=top_plate_height);
	sphere(4);
      }
      translate([0,0,-10]) cube([500,500,10],center=true);
      translate([0,0,-3]) shape(h=key_plate_height+key_plate_depth);
      translate([20,120,0]) keycap_cutouts(rowCol = layout, delta = 0.02, space = 19.5, encoder = 12);
    }
  }

  module key_plate(h=rowCol)
  {
    difference()
      {
      shape(h=key_plate_height);
      translate([20,120,0]) hole_cutouts();
      }    
  }
 
  // top_plate();
  translate([0,0,-20]) key_plate();
}

top_assembly();


