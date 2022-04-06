#!/bin/bash

if [ -f "./mfork" ]; then
    printf "Testing: ./mfork\n"

    printf "\tProbando que verifique argumentos: "
    ./mfork > /dev/null 2>&1
    if [ $(echo $?) != 0 ]; then
        printf "Ok!\n"
        mfork1=true
    else
        printf "Error!\n"
        mfork1=false
    fi

    printf "\tVerificando número de procesos creados: "
    result=$(./mfork 1 2 3 > mfork.test.txt 2>/dev/null)
    line_count=$(wc -l mfork.test.txt | awk '{print $1}')
    if [ "$line_count" = "4" ]; then
        printf "Ok!\n"
        mfork2=true
    else
        printf "Error!\n"
        mfork2=false
    fi

    rm -f mfork.test.txt > /dev/null 2>&1

    if $mfork1 && $mfork2 ; then
        printf "Todos las pruebas pasaron exitosamente.\n"
        exit 0
    else
        printf "Algunas pruebas fallaron.\n"
        exit 1
    fi
else
    printf "Error! El programa mfork.c parece no estar compilado.\n"
    exit 1
fi


