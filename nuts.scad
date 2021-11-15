include <iso.scad>

/**
 * This gives us the hex nut sans the bore.
 */
module hexNutBoreless(mSize) {
  let (
    hexNutDiameter = nuts[mSize][nutDiameterIndex],
    hexNutThickness = nuts[mSize][nutThicknessIndex]
  ) {
    rotate(a=90, v=[1, 0, 0])
      rotate(a=90, v=[0, 0, 1])
      // Do we want it at its widest angle going up and down? Probably not. But
      // keep this in case we change our minds.
      /* rotate(a=90, v=[0, 0, 1]) */
      translate([0, 0, -hexNutThickness / 2])
      linear_extrude(hexNutThickness)
      circle(d=hexNutDiameter, $fn=6);
  }
}

/**
 * The hex nut gap is for placing both a hex nut and a screw inside of the
 * object in question.
 */
module hexNutCaptureSlot(mSize, countersinkDepth, nutDepth) {
  let (
    tolerance = 1.3
  ) {
    scale(tolerance) {
      union() {
        hexNutBoreless(mSize);
      }
      let (
        nutThickness = nuts[mSize][nutThicknessIndex]
      ) {
        translate([0, -(nutThickness + nutDepth), 0])
          screwShaft(mSize, countersinkDepth + nutThickness);
      }
      hexNutContinuation(mSize, nutDepth);
    }
  }
}

module hexNutContinuation(mSize, depth) {
  let (
    hexNutFlatDistance = nuts[mSize][nutFlatDistanceIndex],
    hexNutThickness = nuts[mSize][nutThicknessIndex]
  ) {
    translate([0, 0, depth / 2])
      cube([hexNutFlatDistance, hexNutThickness, depth], center=true);
  }
}

/**
 * The shaft of the screw.
 */
module screwShaft(mSize, length, nutThickness) {
  let (
    screwBodyDiameter = screws[mSize][screwShaftClearanceDiameterIndex]
  ) {
    $fn=100;
    rotate(a=90, v=[1, 0, 0])
      translate([0, 0, -length / 2])
      cylinder(
        d=screwBodyDiameter,
        h=length,
        center=true
      );
  }
}

module hexNutCapturePocket(mSize) {
  hexNutBoreless(mSize);
}

previewNutGap = false;
if(previewNutGap) {
  translate([20, 20, -20])
    hexNutCaptureSlot(m5, 20, 10);
}
