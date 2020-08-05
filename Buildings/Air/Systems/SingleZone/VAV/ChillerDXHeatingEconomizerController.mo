within Buildings.Air.Systems.SingleZone.VAV;
model ChillerDXHeatingEconomizerController
  "Controller for single zone VAV system"
  extends Modelica.Blocks.Icons.Block;

  parameter Modelica.SIunits.Temperature TSupChi_nominal
    "Design value for chiller leaving water temperature";
  parameter Real minAirFlo(
    min=0,
    max=1,
    unit="1") = 0.2
    "Minimum airflow fraction of system"
    annotation(Dialog(group="Air design"));

  parameter Modelica.SIunits.DimensionlessRatio minOAFra "Minimum outdoor air fraction of system"
    annotation(Dialog(group="Air design"));

  parameter Modelica.SIunits.Temperature TSetSupAir "Cooling supply air temperature setpoint"
    annotation(Dialog(group="Air design"));

  parameter Real kHea(min=Modelica.Constants.small) = 2
    "Gain of heating controller"
    annotation(Dialog(group="Control gain"));

  parameter Real kCoo(min=Modelica.Constants.small)=1
    "Gain of controller for cooling valve"
    annotation(Dialog(group="Control gain"));

  parameter Real kFan(min=Modelica.Constants.small) = 0.5
    "Gain of controller for fan"
    annotation(Dialog(group="Control gain"));

  parameter Real kEco(min=Modelica.Constants.small) = 4
    "Gain of controller for economizer"
    annotation(Dialog(group="Control gain"));

  Modelica.Blocks.Interfaces.RealInput TRoo(
    final unit="K",
    displayUnit="degC") "Zone temperature measurement"
  annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        origin={-120,-80}), iconTransformation(extent={{-14,-14},{14,14}},
          origin={-114,-58})));

  Modelica.Blocks.Interfaces.RealInput TSetRooCoo(
    final unit="K",
    displayUnit="degC")
    "Zone cooling setpoint temperature" annotation (Placement(transformation(
        extent={{20,-20},{-20,20}},
        rotation=180,
        origin={-120,60}), iconTransformation(
        extent={{14,-14},{-14,14}},
        rotation=180,
        origin={-114,56})));
  Modelica.Blocks.Interfaces.RealInput TSetRooHea(
    final unit="K",
    displayUnit="degC")
    "Zone heating setpoint temperature" annotation (Placement(transformation(
        extent={{20,-20},{-20,20}},
        rotation=180,
        origin={-120,100}), iconTransformation(
        extent={{14,-14},{-14,14}},
        rotation=180,
        origin={-114,84})));

  Modelica.Blocks.Interfaces.RealInput TMix(
    final unit="K",
    displayUnit="degC")
    "Measured mixed air temperature"
    annotation (Placement(transformation(extent={{-140,0},{-100,40}}),
        iconTransformation(extent={{-128,14},{-100,42}})));

  Modelica.Blocks.Interfaces.RealInput TSup(
    final unit="K",
    displayUnit="degC")
    "Measured supply air temperature after the cooling coil"
    annotation (Placement(transformation(extent={{-140,-130},{-100,-90}}),
        iconTransformation(extent={{-128,-100},{-100,-72}})));

  Modelica.Blocks.Interfaces.RealInput TOut(
    final unit="K",
    displayUnit="degC")
    "Measured outside air temperature"
    annotation (Placement(transformation(extent={{-140,-60},{-100,-20}}),
        iconTransformation(extent={{-128,-44},{-100,-16}})));

  Modelica.Blocks.Interfaces.RealOutput yHea(final unit="1") "Control signal for heating coil"
    annotation (Placement(transformation(extent={{100,50},{120,70}})));

  Modelica.Blocks.Interfaces.RealOutput yFan(final unit="1") "Control signal for fan"
    annotation (Placement(transformation(extent={{100,80},{120,100}})));

  Modelica.Blocks.Interfaces.RealOutput yOutAirFra(final unit="1")
    "Control signal for outside air fraction"
    annotation (Placement(transformation(extent={{100,20},{120,40}})));

  Modelica.Blocks.Interfaces.RealOutput yCooCoiVal(final unit="1")
    "Control signal for cooling coil valve"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));

  Modelica.Blocks.Interfaces.RealOutput TSetSupChi(
    final unit="K",
    displayUnit="degC")
    "Set point for chiller leaving water temperature"
    annotation (Placement(transformation(extent={{100,-90},{120,-70}})));

  Modelica.Blocks.Interfaces.BooleanOutput chiOn "On signal for chiller"
    annotation (Placement(transformation(extent={{100,-50},{120,-30}})));

  BaseClasses.ControllerHeatingFan conSup(
    minAirFlo = minAirFlo,
    kHea = kHea,
    kFan = kFan) "Heating coil, cooling coil and fan controller"
    annotation (Placement(transformation(extent={{-60,80},{-40,100}})));
  BaseClasses.ControllerEconomizer conEco(
    final kEco = kEco)
    "Economizer control"
    annotation (Placement(transformation(extent={{40,60},{60,80}})));

  Controls.OBC.CDL.Continuous.Hysteresis                   hysChiPla(
    uLow=-1,
    uHigh=0) "Hysteresis with delay to switch on cooling"
    annotation (Placement(transformation(extent={{30,-50},{50,-30}})));

  Modelica.Blocks.Math.Feedback errTRooCoo
    "Control error on room temperature for cooling"
    annotation (Placement(transformation(extent={{-42,-96},{-22,-76}})));
  Controls.Continuous.LimPID conCooVal(
    controllerType=Modelica.Blocks.Types.SimpleController.P,
    final yMax=1,
    final yMin=0,
    final k=kCoo,
    final reverseActing=false)
    "Cooling coil valve controller"
    annotation (Placement(transformation(extent={{0,-30},{20,-10}})));

  Controls.OBC.CDL.Logical.Switch swi
    "Switch the outdoor air fraction to 0 when in unoccupied mode"
    annotation (Placement(transformation(extent={{0,20},{20,40}})));
  Controls.OBC.CDL.Interfaces.BooleanInput           uOcc
    "Current occupancy period, true if it is in occupant period"
    annotation (Placement(transformation(extent={{-140,-30},{-100,10}}),
        iconTransformation(extent={{-156,-30},{-100,26}})));
  Controls.OBC.CDL.Continuous.Sources.Constant con(k=0)
    "Zero outside air fraction"
    annotation (Placement(transformation(extent={{-60,-30},{-40,-10}})));
  Controls.OBC.CDL.Logical.Switch swiFan "Switch fan on"
    annotation (Placement(transformation(extent={{70,120},{90,140}})));
  Controls.OBC.CDL.Continuous.Hysteresis hysHea(uLow=0.01, uHigh=0.05)
    "Hysteresis for heating"
    annotation (Placement(transformation(extent={{-30,120},{-10,140}})));
  Modelica.Blocks.MathBoolean.Or orFan(nu=3)
    "Switch fan on if heating, cooling, or occupied"
    annotation (Placement(transformation(extent={{40,100},{60,120}})));
  Modelica.Blocks.Logical.And and1
    annotation (Placement(transformation(extent={{70,-40},{90,-20}})));
protected
  Modelica.Blocks.Sources.Constant TSetSupChiConst(
    final k=TSupChi_nominal)
    "Set point for chiller temperature"
    annotation (Placement(transformation(extent={{40,-90},{60,-70}})));

  Modelica.Blocks.Sources.Constant conMinOAFra(
    final k=minOAFra)
    "Minimum outside air fraction"
    annotation (Placement(transformation(extent={{-60,30},{-40,50}})));

  Modelica.Blocks.Sources.Constant TSetSupAirConst(
    final k=TSetSupAir)
    "Set point for supply air temperature"
    annotation (Placement(transformation(extent={{-60,-60},{-40,-40}})));

equation
  connect(errTRooCoo.y, hysChiPla.u) annotation (Line(points={{-23,-86},{0,-86},
          {0,-40},{28,-40}},                           color={0,0,127}));
  connect(TSetRooCoo, errTRooCoo.u2) annotation (Line(points={{-120,60},{-80,60},
          {-80,-98},{-32,-98},{-32,-94}}, color={0,0,127}));
  connect(TSetSupAirConst.y,conCooVal. u_s)
    annotation (Line(points={{-39,-50},{-10,-50},{-10,-20},{-2,-20}},
                                                         color={0,0,127}));
  connect(conSup.TSetRooHea, TSetRooHea) annotation (Line(points={{-61,96},{-80,
          96},{-80,100},{-120,100}},
                                   color={0,0,127}));
  connect(conSup.TSetRooCoo, TSetRooCoo) annotation (Line(points={{-61,90},{-80,
          90},{-80,60},{-120,60}}, color={0,0,127}));
  connect(conSup.TRoo, TRoo) annotation (Line(points={{-61,84},{-74,84},{-74,
          -80},{-120,-80}},
                       color={0,0,127}));
  connect(conEco.TMix, TMix) annotation (Line(points={{39,75},{-2,75},{-2,76},{
          -26,76},{-26,20},{-120,20}},
                      color={0,0,127}));
  connect(conEco.TRet, TRoo) annotation (Line(points={{39,72},{-22,72},{-22,12},
          {-86,12},{-86,-80},{-120,-80}},     color={0,0,127}));
  connect(conEco.TOut, TOut) annotation (Line(points={{39,65},{4,65},{4,66},{
          -18,66},{-18,8},{-92,8},{-92,-40},{-120,-40}},
                                           color={0,0,127}));
  connect(conSup.yHea, yHea) annotation (Line(points={{-39,86},{80,86},{80,60},
          {110,60}},color={0,0,127}));
  connect(conEco.yOutAirFra, yOutAirFra) annotation (Line(points={{61,70},{80,
          70},{80,30},{110,30}},
                             color={0,0,127}));
  connect(conCooVal.y, yCooCoiVal)
    annotation (Line(points={{21,-20},{40,-20},{40,0},{110,0}},
                                              color={0,0,127}));
  connect(TSetSupChiConst.y, TSetSupChi)
    annotation (Line(points={{61,-80},{110,-80}}, color={0,0,127}));
  connect(conCooVal.u_m, TSup)
    annotation (Line(points={{10,-32},{10,-110},{-120,-110}},
                                                            color={0,0,127}));
  connect(conMinOAFra.y, swi.u1) annotation (Line(points={{-39,40},{-30,40},{
          -30,38},{-2,38}}, color={0,0,127}));
  connect(uOcc, swi.u2) annotation (Line(points={{-120,-10},{-68,-10},{-68,0},{
          -14,0},{-14,30},{-2,30}}, color={255,0,255}));
  connect(swi.y, conEco.minOAFra) annotation (Line(points={{22,30},{30,30},{30,
          68},{39,68}}, color={0,0,127}));
  connect(TRoo, errTRooCoo.u1) annotation (Line(points={{-120,-80},{-86,-80},{
          -86,-86},{-40,-86}}, color={0,0,127}));
  connect(con.y, swi.u3) annotation (Line(points={{-38,-20},{-30,-20},{-30,-10},
          {-6,-10},{-6,22},{-2,22}}, color={0,0,127}));
  connect(hysChiPla.y, conEco.cooSta) annotation (Line(points={{52,-40},{60,-40},
          {60,52},{24,52},{24,62},{39,62}},
                                    color={255,0,255}));
  connect(con.y, swiFan.u3) annotation (Line(points={{-38,-20},{-30,-20},{-30,
          -10},{-6,-10},{-6,122},{68,122}}, color={0,0,127}));
  connect(conSup.yFan, swiFan.u1) annotation (Line(points={{-39,94},{18,94},{18,
          138},{68,138}}, color={0,0,127}));
  connect(swiFan.y, yFan) annotation (Line(points={{92,130},{96,130},{96,90},{
          110,90}}, color={0,0,127}));
  connect(conSup.yHea, hysHea.u) annotation (Line(points={{-39,86},{-34,86},{
          -34,130},{-32,130}},                     color={0,0,127}));
  connect(swiFan.u2, orFan.y)
    annotation (Line(points={{68,130},{64,130},{64,110},{61.5,110}},
                                                   color={255,0,255}));
  connect(hysHea.y, orFan.u[1]) annotation (Line(points={{-8,130},{24,130},{24,
          114.667},{40,114.667}},
                              color={255,0,255}));
  connect(hysChiPla.y, orFan.u[2]) annotation (Line(points={{52,-40},{60,-40},{
          60,52},{24,52},{24,110},{40,110}},
                                     color={255,0,255}));
  connect(uOcc, orFan.u[3]) annotation (Line(points={{-120,-10},{-68,-10},{-68,
          0},{-14,0},{-14,102},{14,102},{14,105.333},{40,105.333}},
                                              color={255,0,255}));
  connect(conEco.TMixSet, conCooVal.u_s) annotation (Line(points={{39,78},{-10,
          78},{-10,-20},{-2,-20}}, color={0,0,127}));
  connect(hysChiPla.y, and1.u2)
    annotation (Line(points={{52,-40},{60,-40},{60,-38},{68,-38}},
                                                 color={255,0,255}));
  connect(and1.y, chiOn) annotation (Line(points={{91,-30},{96,-30},{96,-40},{
          110,-40}}, color={255,0,255}));
  connect(conEco.yCoiSta, and1.u1) annotation (Line(points={{61,62},{64,62},{64,
          -30},{68,-30}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(extent={{-100,-120},{100,140}}),
                   graphics={Line(points={{-100,-100},{0,2},{-100,100}}, color=
              {0,0,0})}), Documentation(info="<html>
<p>
This is the controller for the VAV system with economizer, heating coil and cooling coil.
</p>
</html>", revisions="<html>
<ul>
<li>
June 21, 2017, by Michael Wetter:<br/>
Refactored implementation.
</li>
<li>
June 1, 2017, by David Blum:<br/>
First implementation.
</li>
</ul>
</html>"),
    Diagram(coordinateSystem(extent={{-100,-120},{100,140}})));
end ChillerDXHeatingEconomizerController;
