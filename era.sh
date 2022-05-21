#!/bin/bash

#ゴミ箱の絶対パス
absoluteTrashPath=''
#ゴミ箱に保存する際の区切り文字
devideCharacter='~'

initiate(){
    for objectiveDir in $@; do
        actualNameDir=`echo $objectiveDir | sed 's/^.*\///g'`
        while true; do
            if [ `matchCheck $actualNameDir` -eq 1 ]; then
                actualNameDir=`changeName $actualNameDir`
            else
                echo saved as '"'$actualNameDir'"'
                break
            fi
        done
        mv $objectiveDir $absoluteTrashPath/$actualNameDir
    done
}

matchCheck(){
    trashDirs=`ls -a $absoluteTrashPath`
    for trashDir in $trashDirs; do
        if [ "$trashDir" = "$1" ]; then
            echo 1
            return
        fi
    done
    echo 0
}

changeName() {
    if [ ! -z `echo $1 | grep "$devideCharacter[0-9]*$"` ]; then
        withoutNumDir=`echo $1 | sed "s/$devideCharacter[0-9]*$//g"`
        tailNumDir=`echo $1 | awk -F "$devideCharacter" '{print $NF}'`   
        echo ${withoutNumDir}${devideCharacter}$((tailNumDir + 1))
    else
        echo ${1}${devideCharacter}1 
    fi
}

initiate $@
