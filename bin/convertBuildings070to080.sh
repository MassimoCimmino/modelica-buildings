#!/bin/bash
#####################################################################
# This script replaces the strings defined in the array ORI with
# the string defined in NEW.
# The replacement will be done in all *.mo and *.mos files in 
# the current directory and in its subdirectories.
#
# Use this file with caution. 
# You may want to backup the current directory before running this
# script.
#
# Michael Wetter, LBNL                                     2009-09-29
#####################################################################
ORI=( Modelica\.Fluid\.Machines\.PrescribedPump \
Modelica\.Media\.Water\.ConstantPropertyLiquidWater \
Modelica\.Fluid\.Machines\.BaseClasses\.PumpCharacteristics \
MoistAirNonsaturated \
MoistAirNoLiquid \
)
NEW=( Buildings\.Fluid\.Movers\.FlowMachine_Nrpm \
Buildings\.Media\.ConstantPropertyLiquidWater \
Buildings\.Fluid\.Movers\.BaseClasses\.Characteristics \
MoistAirUnsaturated \
MoistAirUnsaturated \
)

# Number of strings to replace
iMax=${#NEW[@]}
echo $iMax

# Find all *.mo and *.mos files, then replace the strings
for ff in `find . \( -name '*.mo' -or -name '*.mos' \)`; do
    iVar=0
    while [ $iVar -lt $iMax ]; do
        # Count how many times the original string is in the file
	co=`grep -c ${ORI[$iVar]} $ff`;
	if [ $co -ge 1 ]; then
            # Found a string. Replace it.
	    echo $co $ff
	    sed -e "s/${ORI[$iVar]}/${NEW[$iVar]}/g" $ff > tmp.txt
	    mv tmp.txt $ff
	fi;
	iVar=$[ iVar + 1 ]
    done; 
done
