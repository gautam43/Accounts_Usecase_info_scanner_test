#!/usr/bin/bash

FILES=/pdf-scan-extract-info/*.pdf
j=1
for i in $FILES
do
	pdftotext $i a$j.txt
	j=`expr $j + 1`
done
