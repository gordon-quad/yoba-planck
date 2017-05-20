$fn=60;
laser_thickness = 0.1;
key_size = 14;
key_space = 19.05;
screw_dia = 2;
screw_tap_dia = 1.6;
round = 2;

//band_length = (6*key_space + (key_space - key_size) / 2 - 2 * round) * 2 +
//              (4*key_space + (key_space - key_size) - 2 * round) * 2 +
//              4 * 2 * 3.14159265 * round;
band_length = 111.25 * 2 + 73.15 * 2;
band_width = 15;

module key(size=key_size, sq=false)
{
    if (sq)
    {
        square(size, center=true);
    }
    else
    {
        union()
        {
            square(size-2*laser_thickness, center=true);
            translate([0, ((size-laser_thickness)/2 - 3/2)]) square([size-laser_thickness+2, 3-laser_thickness], center=true, r=1);
            translate([0, -((size-laser_thickness)/2 - 3/2 )]) square([size-laser_thickness+2, 3-laser_thickness], center=true,  r=1);
        }
    }
}

module screws(dia)
{
    translate([2.5, 1.5] * key_space) circle(d=dia);
    translate([0.5, 0.5] * key_space) circle(d=dia);
    translate([4.5, 0.5] * key_space) circle(d=dia);
    translate([0.5, 2.5] * key_space) circle(d=dia);
    translate([4.5, 2.5] * key_space) circle(d=dia);
}

module plate(dia)
{
    difference()
    {
        translate([-key_space/2 , -key_space/2 - (key_space - key_size)/2])
            minkowski() { translate([round, round])
                square([key_space*6 + (key_space - key_size)/2 - 2*round, key_space*4 +
                    (key_space - key_size) - 2*round]); circle(round);
            };
        screws(dia);
    }
}

module top_plate()
{
    difference() {
        plate(screw_dia);
        union() {
            for (i = [0:3]) {
                for (j = [0:5]) {
                    translate([j*key_space, i*key_space]) key(sq=true);
                }
            }
        }
    }
}

module band()
{
    square([band_length, band_width]);
}

echo(band_length);

//translate([0,0]) top_plate();
//translate([key_space*6.5, 0]) plate(screw_tap_dia);

//translate([key_space*5+3,key_space*4.5]) mirror() top_plate();
//translate([key_space*11.5+3, key_space*4.5]) mirror() plate(screw_tap_dia);

band();
