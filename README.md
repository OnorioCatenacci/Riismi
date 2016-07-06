# Riismi

A tool to help keep track of RIIS' machine inventory.

To build a release package:

1.) Start a powershell prompt and change to the riismi directory

2.) Type _./initvars_ at the prompt

3.) Type _./make_rel_ at the prmopt

To reset the database (for development and testing)

1.) Start a powershell prompt and change to the riismi directory

2.) Type _psql_ to insure that Postgresql is in your path

3.) To reset dev type _./dbinit_dev_.  To reset test type _./dbinit_test_.