module fustrum(
    bw, // bottom width
    bd, // bottom depth
    tw, // top width
    td, // top depth
    xs, // x skew
    ys, // y skew
    ht  // height
)
{
    Points = [
        [ 0,     0,      0 ], // 0
        [ bw,    0,      0 ], // 1
        [ bw,    bd,     0 ], // 2
        [ 0,     bd,     0 ], // 3
        [ xs,    ys,    ht ], // 4
        [ xs+tw, ys,    ht ], // 5
        [ xs+tw, ys+td, ht ], // 6
        [ xs,    ys+td, ht ], // 7
    ];
    
    Faces = [
        [ 0, 1, 2, 3 ], // bottom
        [ 4, 5, 1, 0 ], // front
        [ 7, 6, 5, 4 ], // top
        [ 5, 6, 2, 1 ], // right
        [ 6, 7, 3, 2 ], // back
        [ 7, 4, 0, 3 ] // left
    ];
    
    polyhedron(Points, Faces);
}

module centered_fustrum(
    bw, // bottom width
    bd, // bottom depth
    tw, // top width
    td, // top depth
    ht  // height
)
{
    xs = (bw - tw) / 2; // x skew
    ys = (bd - td) / 2; // y skew
    
    fustrum(bw, bd, tw, td, xs, ys, ht);
}

difference()
{
    centered_fustrum(10, 20, 5, 10, 4);
    
    translate([0.5, 0.5, 0.5])
    centered_fustrum( 9, 19, 4,  9, 3);
}


