within Buildings.Utilities.Comfort.Examples;
model PMV_tester
  extends Modelica.Icons.Example;
  Buildings.Utilities.Comfort.Fanger comfort(
    use_vAir_in=true,
    use_M_in=true,
    use_ICl_in=true,
    use_pAir_in=false,
    M=58,
    ICl=0.6) "Thermal comfort model"
    annotation (Placement(transformation(extent={{6,-2},{26,18}})));
  Modelica.Blocks.Sources.CombiTimeTable Table_inputs(table=[0,293.15,0.1,0.5,58,
        0.6; 100,295.15,0.1,0.5,58,0.6; 200,297.15,0.1,0.5,58,0.6; 300,299.15,0.1,
        0.5,58,0.6; 400,301.15,0.1,0.5,58,0.6; 500,303.15,0.1,0.5,58,0.6; 600,297.15,
        0.05,0.5,58,0.6; 700,297.15,0.15,0.5,58,0.6; 800,297.15,0.1,0.2,58,0.6;
        900,297.15,0.1,0.3,58,0.6; 1000,297.15,0.1,0.4,58,0.6; 1100,297.15,0.1,
        0.5,58,0.6; 1200,297.15,0.1,0.6,58,0.6; 1300,297.15,0.1,0.7,58,0.6; 1400,
        297.15,0.1,0.5,72.5,0.6; 1500,297.15,0.1,0.5,87,0.6; 1600,297.15,0.1,0.5,
        101.5,0.6; 1700,297.15,0.1,0.5,58,0.4; 1800,297.15,0.1,0.5,58,0.6; 1900,
        297.15,0.1,0.5,58,0.8; 2000,297.15,0.1,0.5,58,1; 2100,297.15,0.1,0.5,58,
        1],            smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments)
    "PMV input conditions"
    annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
  Modelica.Blocks.Interaction.Show.RealValue realValue(significantDigits=3)
    annotation (Placement(transformation(extent={{60,2},{80,22}})));
  Modelica.Blocks.Sources.CombiTimeTable Table_PMV_reference(table=[0,-1.91;
        100,-1.20; 200,-0.52; 300,0.17; 400,0.87; 500,1.58; 600,-0.48; 700,-0.70;
        800,-0.76; 900,-0.68; 1000,-0.60; 1100,-0.52; 1200,-0.44; 1300,-0.36;
        1400,0.08; 1500,0.45; 1600,0.73; 1700,-1.04; 1800,-0.52; 1900,-0.12;
        2000,0.20; 2100,0.20], smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments)
    "PMV value calculated from CBE Thermal Comfort Tool (comfort.cbe.berkeley.edu)"
    annotation (Placement(transformation(extent={{-82,-40},{-62,-20}})));
equation
  connect(comfort.PMV, realValue.numberPort)
    annotation (Line(points={{27,12},{58.5,12}},   color={0,0,127}));
  connect(Table_inputs.y[1], comfort.TAir) annotation (Line(points={{-59,50},{
          -28,50},{-28,18},{5,18}}, color={0,0,127}));
  connect(Table_inputs.y[1], comfort.TRad) annotation (Line(points={{-59,50},{
          -26,50},{-26,14},{5,14}}, color={0,0,127}));
  connect(Table_inputs.y[2], comfort.vAir_in) annotation (Line(points={{-59,50},
          {-28,50},{-28,7},{5,7}}, color={0,0,127}));
  connect(Table_inputs.y[3], comfort.phi) annotation (Line(points={{-59,50},{
          -28,50},{-28,10},{5,10}}, color={0,0,127}));
  connect(Table_inputs.y[4], comfort.M_in) annotation (Line(points={{-59,50},{
          -28,50},{-28,4},{5,4}}, color={0,0,127}));
  connect(Table_inputs.y[5], comfort.ICl_in) annotation (Line(points={{-59,50},
          {-28,50},{-28,1},{5,1}}, color={0,0,127}));
 annotation (experiment(
      StopTime=2300,
      Interval=100,
      Tolerance=1e-06),
__Dymola_Commands(file="modelica://Buildings/Resources/Scripts/Dymola/Utilities/Comfort/Examples/Fanger.mos"
        "Simulate and plot"),
    Documentation(info="<html>
This is a test of the Thermal Comfort Model.
</html>"));
end PMV_tester;
