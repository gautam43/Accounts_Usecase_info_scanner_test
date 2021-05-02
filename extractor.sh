#!/usr/bin/bash

name=$@

invarr=()
taxamtarr=()
placearr=()

for i in $name
do
  two=$(cat $i | awk '$2=="No" {print $2}')

  if [ -z $two ]
  then
        invoice=$(cat $i | awk '$1=="Invoice" && $2=="Number:" { print $3 }' | tail -c 6)
  else
        invoice=$(cat $i | awk '$1=="Invoice" && $2=="No" { print $5 }' | cut -d "[" -f 1 | tail -c 6)
  fi
 

  invarr+=("$invoice")
  
  #Line_no=$(cat $i | awk '$1=="Total"{ print NR }')


  #f=$(cat $i | awk '$2=="Free"{print NR }')
  #if [ -z $f ]
  #then
   #     fno=`expr $Line_no + 12`
  #else
   #     fno=`expr $Line_no + 11`
  #fi
  cr=$(cat $i | grep Credit | tail -1 | cut -d " " -f 1  )
  

  #taxamt=$(cat $i | awk -v no=$fno -F. ' NR == no { print $2 "." $3 }')
  #echo "$taxamt"
  taxamt=$(cat $i | grep Rs | awk -F. 'NR==2{ print $2 "." $3 }')
  if [ -z $cr ]
  then

	  taxamt=$(cat $i | grep Rs | awk -F. 'NR==2{ print $2 "." $3 }')
  else
	  taxamt=$(cat $i | grep Rs | awk -F. 'NR==2{ print "-" $2 "." $3 }')
  fi
	

  taxamtarr+=("$taxamt")

  place=$(cat $i | awk '$1=="Place" && $2=="of" && $3=="Supply" { print $5  $6  $7 }')
  placearr+=("$place")
done

unique_place=($(echo "${placearr[@]}" | tr ' ' '\n' | sort -u | tr '\n' ' '))

declare -A arr

for p in "${unique_place[@]}"
do
	k=0
	for value in "${placearr[@]}"
	do
		if [ "$p" = "$value" ]
		then
			amt=$(echo "${taxamtarr[$k]}")
			inv=$(echo "${invarr[$k]}")
			arr+=(["$p"]=$amt ["$p"]=$inv)
			echo "$p,$inv,$amt"
		fi
		k=`expr $k + 1`
	done
done


#for key in ${!arr[@]}; do
 #   echo ${key} ${arr[${key}]}
#done



#echo "namaste this is main output before this "




#for value in "${invarr[@]}"
#do
 # echo $value
#done

#echo "${invarr[2]}"



