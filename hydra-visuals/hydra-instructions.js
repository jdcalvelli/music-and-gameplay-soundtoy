// this is not meant to be run through node, this is meant to be used specifically through the hydra synth

a.setBins(6);
a.setSmooth(0.9);

shape(12, 1, 0.01)
  .scale(0.6)
  .color(
    () => a.fft[4] * 0.8,
    0.1,
    () => a.fft[2] * 0.8
  )
  .brightness(0.1)
  .modulate(voronoi(20, 0.5, 0.1).modulateRotate(osc(20), 2), 0.1)
  .mult(
    noise(() => 12, 0.2)
      .pixelate(10)
      .thresh(
        () => a.fft[0] * 0.5,
        () => Math.abs(Math.sin(time))
      )
  )
  .repeat(5)
  .brightness(0.1)
  .out();
