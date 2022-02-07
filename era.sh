#!/bin/bash

#下の""の中にゴミ箱のパスを入力する
export sot=""

matchchecker() {
	searched=`ls $sot`
	for count in $searched; do
		#matched=`echo $1 | grep ^$count$`
		if [ "$1" = "$count" ]; then
			#echo broken changing the name
			namechanger $1
			return 0		
		fi
	done

	#echo check is completed : $1
	if [ "$ofn" = "" ]; then
		eraser $1
	else
		eraser $ofn $1
	fi
}
eraser() {
	if [ "$2" = "" ]; then
		mv $1 $sot
	else
		mv $1 $sot$2	
	fi
}
executor() {
	#mv $@ ~/.Trash_tmp/
	for count in $@; do
		export ofn=""
		matchchecker $count
		#echo executed
	done
}
namechanger() {
	tailname=`echo $1 | grep '[0-9][0-9]*$'`
	if [ "$tailname" != "" ]; then	#if included number tail of file name
		tailnumber=`echo $tailname | awk -F'~' '{print $NF}'`
		tailnumber=`echo $((tailnumber + 1))`
		name=`echo $tailname | awk -F'~' '{$NF="";print$0}'`
		name=`echo $name | head -c $((${#name} - 1))`
		#echo mv $1 ${name}~${tailnumber}
		#change into mv later
		checklater=${name}~${tailnumber}
	else
		#echo mv $1 $1~2	
		#also change into mv later
		checklater=$1~1
	fi
	#echo $checklater once check the name
	if [ "$ofn" == "" ]; then
		export ofn=$1
	fi
	matchchecker $checklater
}

executor $@

