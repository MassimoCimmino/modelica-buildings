within Buildings.ThermalZones.Detailed.Examples.FFD;
package UsersGuide
  extends Modelica.Icons.Information;
  annotation (preferredView="info",
  Documentation(info="<html>
<h4>Introduction</h4>
<p>
For an introduction to the coupled simulation and for detailed information
on <a href=\"modelica://Buildings.ThermalZones.Detailed.CFD\">Buildings.ThermalZones.Detailed.CFD</a>,
please refer to <a href=\"modelica://Buildings.ThermalZones.Detailed.UsersGuide.CFD\">Buildings.ThermalZones.Detailed.UsersGuide.CFD</a>.
For a step by step guide on performing the coupled simulation, please refer to <a href=\"modelica://Buildings.ThermalZones.Detailed.Examples.FFD.Tutorial\">Buildings.ThermalZones.Detailed.Examples.FFD.Tutorial</a>.
</p>
<h4>Files for the Coupled Simulation</h4>
<p>
The source code of the FFD program is located at <code>Buildings/Resources/src/FastFluidDynamics</code>.
The <code>Buildings</code> library contains precompiled versions of this source
code in the subdirectories of <code>Buildings/Resources/Library</code>.
</p>
<p>
To run the coupled simulation with FFD, the following files are needed and  provided in the <code>Buildings</code> library:
</p>
<ul>
<li>
dynamic link files located at <code>Buildings/Resources/Library</code>:
<ul>
<li>
Windows: <code>ffd.dll</code>
</li>
<li>
Linux: <code>libffd.so</code>
</li>
</ul>
</li>
<li>
FFD input files for simulation parameters, called <code>*.ffd</code> and
located at <code>Buildings/Resources/Data/Rooms/FFD/</code>
</li>
<li>
Mesh files <code>*.cfd</code>  and obstacles files <code>*.dat</code> generated by the program <code>SCI_FFD</code> and located at <code>Buildings/Resources/Data/Rooms/FFD/</code>.
Note that the <code>SCI_FFD</code> program is maintained at <a href=\"https://github.com/FastFluidDynamics/Mesh\">https://github.com/FastFluidDynamics/Mesh</a>.
</li>
</ul>
<h4>Compiling library files</h4>
<p>
The FFD program can be compiled into a dlls using Microsoft Visual Studio Express in Windows and gcc in Linux. Compiled files are distributed
with the <code>Buildings</code> library.
If you want to compile the files yourself, proceed as follows:
<ul>
<li>
On Windows, method 1:
<ol>
<li>
Go to <code>Buildings/Resources/src/FastFluidDynamics/</code>
</li>
<li>
Run <code>compile.bat</code> as administrator
</li>
</ol>
</li>
<li>
On Windows, method 2:
<ol>
<li>
Open cmd.
</li>
<li>
Change to the directory <code>Buildings/Resources/src/FastFluidDynamics/</code>
</li>
<li>
type <code>compile.bat</code>
</li>
</ol>
</li>
<li>
On Linux:
<ol>
<li>
Open a console.
</li>
<li>
Change to the directory <code>Buildings/Resources/src/FastFluidDynamics/</code>
</li>
<li>
Type <code>make all</code>
</li>
</ol>
</li>
</ul>
<p>
please note to make use you have the right of executing the <code>compile.bat</code> when using method 2 on Windows.
To check the availability right click the file and choose <code>Properties</code>. Go to <code>Security</code> tab and edit if you don't have the
access to execute the file.
</p>
</html>"));
end UsersGuide;
