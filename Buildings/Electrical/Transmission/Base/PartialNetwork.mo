within Buildings.Electrical.Transmission.Base;
partial model PartialNetwork "Partial model that represent an electric network"
  replaceable parameter Buildings.Electrical.Transmission.Grids.PartialGrid grid
    "Record that describe the grid (number of nodes, links, connections, etc.)"
    annotation (choicesAllMatching=true);
  replaceable Buildings.Electrical.Interfaces.BaseTerminal terminal[grid.Nnodes]
    "Electric terminals for each node of the network"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  replaceable Buildings.Electrical.Transmission.Base.PartialBaseLine lines[grid.Nlinks](
    each mode=Types.CableMode.commercial,
    l=grid.L[:,1],
    each P_nominal=1000,
    each V_nominal=120)
    "Array of line models. Each line connect two nodes of the grid";
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Solid,
          fillColor={255,255,255}),
        Ellipse(
          extent={{-6,86},{6,74}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-86,46},{-74,34}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-36,-24},{-24,-36}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{74,46},{86,34}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{74,-54},{86,-66}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-6,-74},{6,-86}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-66,6},{-54,-6}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{54,6},{66,-6}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-80,40},{0,80}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{-60,0},{0,80}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{0,-80},{60,0}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{-32,-28},{-60,0}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{80,40},{0,80}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{0,-80},{0,80}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(
          points={{80,-62},{80,40}},
          color={0,0,0},
          smooth=Smooth.None),
        Text(
          extent={{-140,140},{140,100}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="%name")}), Documentation(revisions="<html>
<ul>
<li>
June 3, 2014, by Marco Bonvini:<br/>
Added User's guide.
</li>
</ul>
</html>", info="<html>
<p>
This partial model represents a generalized electric network.
</p>
<p>
The model has three main components. The <code>grid</code> is a parameter of type
<a href=\"modelica://Buildings.Electrical.Transmission.Grids.PartialGrid\">
Buildings.Electrical.Transmission.Grids.PartialGrid</a>
that contains the information about the topology of the network (e.g., number of nodes, 
how they are connected, length of each connection). The <code>terminal[...]</code> is 
an array of generalized electric connectors that are associated to each node of the grid.
The <code>lines[...]</code> is an array of 
<a href=\"modelica://Buildings.Electrical.Transmission.Base.PartialBaseLine\">
Buildings.Electrical.Transmission.Base.PartialBaseLine</a> that represent the cables
in the grid.
</p>
<h4>Note:</h4>
<p>
This is a partial model that once extended can represent either DC or AC networks.
This model is based on the assumption that the topology of the network does not depend on
the type of cables that connect the nodes.
</p>
</html>"));
end PartialNetwork;
