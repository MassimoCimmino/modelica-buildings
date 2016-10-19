within Buildings.Utilities.IO.Python27;
package Functions "Package with functions that call Python"
  extends Modelica.Icons.BasesPackage;


  function cymdist "Function that communicates with CymDist"
    input String moduleName
    "Name of the python module that contains the function";
    input String functionName=moduleName "Name of the python function";
    input String inputFileName=moduleName "Name of the input file";
    input Real    dblInpVal[max(1, nDblInp)] "Input variables values to be sent to CYMDIST";
    input Real    dblParVal[max(1, nDblPar)] "Parameter variables values to send to CYMDIST";
    input String  dblOutNam[max(1, nDblOut)] "Output variables names to be read from CYMDIST";
    input String  dblInpNam[max(1, nDblInp)] "Input variables names to be sent to CYMDIST";
    input String  dblParNam[max(1, nDblPar)] "Parameter variables names to send to CYMDIST";
    input Integer nDblInp(min=0) "Number of double inputs to send to CYMDIST";
    input Integer nDblOut(min=0) "Number of double outputs to read from CYMDIST";
    input Integer nDblPar(min=0) "Number of double parameters to send to CYMDIST";

    //   input Integer strLenRea(min=0)
    //     "Maximum length of each string that is read. If exceeded, the simulation stops with an error";
    output Real dblOutVal[max(1, nDblOut)] "Double output values read from CYMDIST";
protected
    String pytPat "Value of PYTHONPATH environment variable";
    String pytPatBuildings "PYTHONPATH of Buildings library";
    Boolean havePytPat "true if PYTHONPATH is already set by the user";
    //--  String filNam = "file://Utilities/IO/Python27/UsersGuide/package.mo"
    //--    "Name to a file of the Buildings library";
  algorithm
    // Get the directory to Buildings/Resources/Python-Sources
    //-- The lines below do not work in Dymola 2014 due to an issue with the loadResource
    //-- (ticket #15168). This will be fixed in future versions.
    //-- pytPatBuildings := Buildings.BoundaryConditions.WeatherData.BaseClasses.getAbsolutePath(uri=filNam);
    //-- pytPatBuildings := Modelica.Utilities.Strings.replace(
    //--   string=pytPatBuildings,
    //--   searchString=filNam,
    //--   replaceString="Resources/Python-Sources");
    // The next line is a temporary fix for the above problem
    pytPatBuildings := "Resources/Python-Sources";
    // Update the PYTHONPATH variable
    (
  pytPat,havePytPat) := Modelica.Utilities.System.getEnvironmentVariable("PYTHONPATH");
    if havePytPat then
   Modelica.Utilities.System.setEnvironmentVariable(name="PYTHONPATH",
      content=pytPat + ":" + pytPatBuildings);
    else
   Modelica.Utilities.System.setEnvironmentVariable(name="PYTHONPATH",
      content=pytPatBuildings);
    end if;
    // Call the exchange function
  dblOutVal := BaseClasses.cymdist(
        moduleName=moduleName,
        functionName=functionName,
        inputFileName=inputFileName,
        nDblInp=nDblInp,
        dblInpNam=dblInpNam,
        dblInpVal=dblInpVal,
        nDblOut=nDblOut,
        dblOutNam=dblOutNam,
        nDblPar=nDblPar,
        dblParNam=dblParNam,
        dblParVal=dblParVal);
    // Change the PYTHONPATH back to what it was so that the function has no
    // side effects.
    if havePytPat then
   Modelica.Utilities.System.setEnvironmentVariable(name="PYTHONPATH",
      content=pytPat);
    else
   Modelica.Utilities.System.setEnvironmentVariable(name="PYTHONPATH",
      content="");
    end if;
  annotation (Documentation(info="<html>
<p>
This function is a wrapper for 
<a href=\"modelica://Buildings.Utilities.IO.Python27.Functions.BaseClasses.cymdist\">
Buildings.Utilities.IO.Python27.Functions.BaseClasses.cymdist</a>.
It adds the directory <code>modelica://Buildings/Resources/Python-Sources</code>
to the environment variable <code>PYTHONPATH</code>
prior to calling the function that exchanges data with Python.
After the function call, the <code>PYTHONPATH</code> is set back to what
it used to be when entering this function.
See 
<a href=\"modelica://Buildings.Utilities.IO.Python27.UsersGuide\">
Buildings.Utilities.IO.Python27.UsersGuide</a>
for instructions, and 
<a href=\"modelica://Buildings.Utilities.IO.Python27.Functions.Examples\">
Buildings.Utilities.IO.Python27.Functions.Examples</a>
for examples.
</p>
</html>", revisions="<html>
<ul>
<li>
October 17, 2016, by Thierry S. Nouidui:<br/>
First implementation.
</li>
</ul>
</html>"));
  end cymdist;



annotation (preferredView="info", Documentation(info="<html>
<p>
This package contains functions that call Python.
</p>
</html>"));
end Functions;
