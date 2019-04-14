# Simulation Code for Beamline 1U at TRIUMF
Corresponding simulation code for work done on beamline 1U (BL1U) optimization at TRIUMF. Completed in part of an undergraduate thesis for the Combined Honours in Physics &amp; Astronomy program. A Monte Carlo simulation was performed on a G4beamline rendering of BL1U at TRIUMF in an effort to increase ultracold neutron production while avoiding target end window failure reuslting from excessive heat load. Simulation code for this project includes a .in file for G4beamline, FORTRAN code, and Python code. The results of this thesis can be found in the UBC library.

*A few notes:*
- For the G4beamline code: the input file into the simulation software must have a name of the form "MyG4InputFile.in"
- The FORTRAN file may be run from the command line as such (using iFort):
```
    ifort Opera2BLFieldMap.f  # in the location of the .f file 
    ./a.out  # returns output file called "fort.2"
```
  - **Note: the input file must be named as "fort.1"**
  - The fort.2 file must be in the same directory as the .in file
- Provided Python code is for data extraction only
