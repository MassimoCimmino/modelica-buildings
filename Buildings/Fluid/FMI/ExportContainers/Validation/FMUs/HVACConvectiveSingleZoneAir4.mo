within Buildings.Fluid.FMI.ExportContainers.Validation.FMUs;
block HVACConvectiveSingleZoneAir4 "Validation model for the convective HVAC system"
  extends Buildings.Fluid.FMI.ExportContainers.Validation.FMUs.HVACConvectiveSingleZoneAir1(
    redeclare package Medium = Buildings.Media.Air(extraPropertiesNames={"CO2"}));
annotation (
    Documentation(info="<html>
<p>
This example validates that
<a href=\"modelica://Buildings.Fluid.FMI.ExportContainers.HVACConvectiveSingleZone\">
Buildings.Fluid.FMI.ExportContainers.HVACConvectiveSingleZone</a>
exports correctly as an FMU.
</p>
</html>", revisions="<html>
<ul>
<li>
April 14, 2016 by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"),
__Dymola_Commands(file="modelica://Buildings/Resources/Scripts/Dymola/Fluid/FMI/ExportContainers/Validation/FMUs/HVACConvectiveSingleZoneAir4.mos"
        "Export FMU"));
end HVACConvectiveSingleZoneAir4;
