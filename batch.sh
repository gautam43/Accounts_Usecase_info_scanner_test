#!/usr/bin/bash

FILES=/var/lib/jenkins/workspace/Extractor-Runquery/*.pdf
j=1
for i in $FILES
do
	pdftotext $i a$j.txt
	j=`expr $j + 1`
done
