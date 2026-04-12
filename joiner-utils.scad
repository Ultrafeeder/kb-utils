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
