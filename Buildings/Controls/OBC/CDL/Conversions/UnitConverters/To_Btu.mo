block To_Btu "Block that converts work from British thermal units to joule"

  Buildings.Controls.OBC.CDL.Interfaces.RealInput u(
    final quantity = "Work")
    "Work in British thermal units"
    annotation (Placement(transformation(extent={{-80,-20},{-40,20}}),
      iconTransformation(extent={{-140,-20},{-100,20}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealOutput y(
    final unit = "J",
    final quantity = "Work")
    "Work in joule"
    annotation (Placement(transformation(extent={{40,-10},{60,10}}),
      iconTransformation(extent={{100,-10},{120,10}})));

protected
  parameter Real k = 1./1055.056 "Multiplier";

  Buildings.Controls.OBC.CDL.Continuous.Gain conv(
    final k = k) "Unit converter"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));

equation
  connect(u, conv.u)
    annotation (Line(points={{-60,0},{-12,0}}, color={0,0,127}));
  connect(conv.y, y)
    annotation (Line(points={{11,0},{50,0}}, color={0,0,127}));
  annotation (
      defaultComponentName = "To_Btu",
    Icon(graphics={
        Rectangle(
          extent={{-100,-100},{100,100}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{20,58}}, color={28,108,200}),
        Text(
          lineColor={0,0,255},
          extent={{-150,110},{150,150}},
          textString="%name"),
        Text(
          extent={{-80,40},{0,0}},
          lineColor={0,0,127},
          textString="Btu"),
        Text(
          extent={{0,-40},{80,0}},
          lineColor={0,0,127},
          textString="J")}),
        Documentation(info="<html>
<p>
Converts work given in British thermal units [Btu] to joule [J].
</p>
</html>", revisions="<html>
<ul>
<li>
July 05, 2018, by Milica Grahovac:<br/>
First implementation.
</li>
</ul>
</html>"));
end To_Btu;
