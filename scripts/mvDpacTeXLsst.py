#!/usr/bin/env python
#Take gaia tex file and put in lsst ..
import os
import sys
import shutil
import fileinput




def doFile(inFile ):
	"This strips the dpac  tex an makes an lsst one "
	count =0
	f=inFile 
	of = str(inFile) + ".old"
	shutil.copy(f,of)
	print "Processing " + of  +" "+ f 
	fin = open (of,'r')  	
	fout = open (f,'w')  	
	for line in fin :
		count= count + 1
		line=line.replace("DpacDU","LSSTDU");
		line=line.replace("dpacDU","LSSTDU");
		line=line.replace("DpacD","D");
		line=line.replace("dpacD","d");
		line=line.replace("dpac","lsst");
		line=line.replace("\\vspace*{-1cm}","");
		line=line.replace("myInitials","WOM");
		line=line.replace("GAIA-C?-??-???-???-???-\\dpacDocIssue","LDX-XXXXX");
		fout.write(line);
	fout.close()
	fin.close()

	print str(inFile) + " ...." + str(count) + " lines \n"
	return;
 # End DoDir




### MAIN 
doFile(sys.argv[1])
