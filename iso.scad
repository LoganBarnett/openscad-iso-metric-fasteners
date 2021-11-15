/*******************************************************************************
 * The M-series of hex nut dimensions can be found here:
 * https://www.engineersedge.com/hardware/standard_metric_hex_nuts_13728.htm
 *
 * Here we will assume an M5 hex nut.
 ******************************************************************************/

m3=0;
m5=1;
nutDiameterIndex=0;
nutFlatDistanceIndex=1;
nutThicknessIndex=2;
// Add more as we go.
nuts = [
  [6.35, 5.5, 2.4], // m3
  [9.24, 8, 4.7], // m5
];

/**
 * See https://www.insight-security.com/get-to-know-metric-bolt-sizes
 * for sizes.
 */
screwShaftDiameterIndex=0;
screwShaftClearanceDiameterIndex=1;
screwHeadDiameterIndex=2;
screwHeadThicknessIndex=3;
screws = [
  // m3 gets a little too tight around 3.3 and starts threading. Use 3.4.
  [3, 3.4, 5, 5],
  [5, 5.5, 7, 5],
];

hexNutGapHead=16;
// Use this if using the "tall" rotation of the hex nut.
/* hexNutDiameter=9.24; */
// Use this if using the "short" rotation of the hex nut.
/* hexNutFlatDistance=8; */
// The unit 8.0 is given as the maximum size of the nut that are two sides wide.
// This doesn't give us a side, and since it's at an angle we can't simply
// divide by two. However we can treat half of that width as a triangle, and we
// know its angles due to the hexagon shape.
hexNutSideLength = cos(polygonAngle(6) - 90) * (8 / 2);

function polygonAngle(sides) = ((sides - 2) * 180) / sides;
