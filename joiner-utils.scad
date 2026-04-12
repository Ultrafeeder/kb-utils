include <constants.scad>

module heat_insert_columns(delta=0.1, width, hi_width, height)
{
  $fn=20;
  difference() 
    {
      cylinder(h=height, d=width, center=true);
      cylinder(h=height+delta, d=hi_width, center=true);
    }
}

module bolt_shape_cutout(c_diameter, bolt_diameter, f_height, length)
{
  $fn=20;
  union() 
    {
      translate([0,0,length-.02]) cylinder(h=f_height, d1=bolt_diameter, d2=c_diameter, center = false);
      cylinder(h=length, d=bolt_diameter, center = false);
    }
}

bolt_cutouts=
[
 [m2_cd, m2, m2_head_h, 12, [10,10,0]],
 [m3_cd, m3, m3_head_h, 12, [20,10,0]],
 [m4_cd, m4, m4_head_h, 12, [30,10,0]],
];

// for(b=bolt_cutouts)
// {
//   translate(b[4]) bolt_shape_cutout(c_diameter=b[0], bolt_diameter=b[1], f_height=b[2], length=b[3]);
// }


hi_cols=
  [
   [m2_colw, m2_hi_pilot, 10],
   [m3_colw, m3_hi_pilot, 20],
   [m4_colw, m4_hi_pilot, 30]
  ];

// for(c=hi_cols)
// {
//   translate([c[2],0,0]) heat_insert_columns(width=c[0], hi_width=c[1], height=8);
// }
