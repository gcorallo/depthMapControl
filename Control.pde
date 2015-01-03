import controlP5.*;

ControlP5 cp5;
boolean doble,invert;
float edge1a, edge1b, edge2a, edge2b;
Range range;
void controlSet() {

  cp5 = new ControlP5(this);

  cp5.addSlider("edge1a")
    .setPosition(width-200, 50)
      .setRange(0, 100)
        .setValue(20)
          .setWidth(80)
            ;
  cp5.addSlider("edge1b")
    .setPosition(width-200, 70)
      .setRange(0, 100)
        .setValue(50)
          .setWidth(80)
            ;


  cp5.addSlider("edge2a")
    .setPosition(width-200, 100)
      .setRange(0, 100)
        .setValue(80)
          .setWidth(80)
            ;
  cp5.addSlider("edge2b")
    .setPosition(width-200, 120)
      .setRange(0, 100)
        .setValue(100)
          .setWidth(80)
            ;

  cp5.addToggle("doble")
     .setPosition(width-340,70)
     .setSize(20,20)
     .setValue(false)
     //.setMode(ControlP5.SWITCH)
     ;
     cp5.addToggle("invert")
     .setPosition(width-300,70)
     .setSize(20,20)
     .setValue(false)
     //.setMode(ControlP5.SWITCH)
     ;
     
   range=cp5.addRange("range")
             // disable broadcasting since setRange and setRangeValues will trigger an event
             .setBroadcast(false) 
             .setPosition(WW+25,20)
             .setSize(width-WW-80,20)
             .setHandleSize(20)
             .setRange(-2000,2000)
             .setRangeValues(200,1000)
             // after the initialization we turn broadcast back on again
             .setBroadcast(true)
             .setColorForeground(color(255,40))
             .setColorBackground(color(255,40))  
             ; 
     
}
