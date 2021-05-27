//OpenSCAD script for creating Stemife.org construction beams
//Feel free to adapt and improve and share your OpenSCAD script (please send contact me)
//Contact: paulo.kiefe@stemfie.org (https://stemfie.org)


//Number of BlockUnits in the X direction
    BSX=5;
//Number of BlockUnits in the Y direction
    BSY=1; 
//Number of BlockUnits in the Z direction 
    BSZ=1; 
    
//Universal values
    BU=12.5; //Universal voxel block unit (mm) in Stemfie (BlockUnit)
    Hole=3.5; //Universal radius (mm) of the connection hole
    SurfTess=32; //Universal tesselation value of curved surfaces
    ChamferHole=2.45; //Chamfer size adjustment value for connection holes
    ChamferEdge=BU*1.25; //Chamfer size adjustment value for outer edges

difference(){
    cube([BU*BSX, BU*BSY, BU*BSZ]);   
        for(i = [0:BSX-1]){
            translate([i*BU,0,0]) XHoles();
        }
        for(i = [0:BSY-1]){
            translate([0,i*BU,0]) YHoles();
        }
        ZArray();
}



//MODULES
module XHoles(){
    union(){
        translate([BU/2,-ChamferHole,BU/2]) rotate([270,0,0]) cylinder(h=BU/2, r1=BU/2, r2=0, $fn=SurfTess);
        translate([BU/2,ChamferHole+BSY*BU,BU/2]) rotate([90,0,0]) cylinder(h=BU/2, r1=BU/2, r2=0, $fn=SurfTess);
        translate([BU/2,0,BU/2]) rotate([270,0,0]) cylinder(r=Hole, h=BSY*BU, $fn=SurfTess);
    }
}

module YHoles(){
    union(){
        translate([0,BU/2,BU/2]) rotate([0,90,0]) cylinder(r=Hole, h=BSX*BU, $fn=SurfTess);
        translate([-ChamferHole,BU/2,BU/2]) rotate([0,90,0]) cylinder(h=BU/2, r1=BU/2, r2=0, $fn=SurfTess);
        translate([ChamferHole+BSX*BU,BU/2,BU/2]) rotate([0,270,0]) cylinder(h=BU/2, r1=BU/2, r2=0, $fn=SurfTess);
    }
}
module ZHoles(){
    union(){
        translate([BU/2,BU/2,-ChamferHole]) rotate([0,0,0]) cylinder(h=BU/2, r1=BU/2, r2=0, $fn=SurfTess);
        translate([BU/2,BU/2,ChamferHole+BU]) rotate([180,0,0]) cylinder(h=BU/2, r1=BU/2, r2=0, $fn=SurfTess);
        translate([BU/2,BU/2,0]) rotate([0,0,0]) cylinder(r=Hole, h=BU, $fn=SurfTess);
    }
}

module ZArray(){
    for(a = [0:BSX-1]){
        translate([a*BU,0,0]){
            for(i = [0:BSY-1]){
            translate([0,i*BU,0]) ZHoles();
            }
        }
    }
}

