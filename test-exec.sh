#!/bin/bash

if [ -f "exec" ]; then
    printf "Testing: bin/exec\n"

    printf "\tProbando que verifique argumentos: "
    ./exec > /dev/null 2>&1
    if [ $(echo $?) != 0 ]; then
        printf "Ok\n"
        exec1=true
    else
        printf "Fallo\n"
        exec1=false
    fi

    printf "\tProbando ejecutar comando correcto: "
    ./exec file exec.c > /dev/null 2>&1
    if [ $(echo $?) == 0 ]; then
        printf "Ok!\n"
        exec2=true
    else
        printf "Error!\n"
        exec2=false
    fi

    printf "\tProbando ejecutar comando que falla: "
    ./exec file > /dev/null 2>&1
    if [ $(echo $?) != 0 ]; then
        printf "Ok!\n"
        exec3=true
    else
        printf "Error!\n"
        exec3=false
    fi

    printf "\tProbando ejecutar comando que no existe: "
    ./exec este-comando-no-existe > /dev/null 2>&1
    if [ $(echo $?) != 0 ]; then
        printf "Ok!\n"
        exec4=true
    else
        printf "Error!\n"
        exec4=false
    fi

    if $exec1 && $exec2 && $exec3 && $exec4 ; then
        printf "Todos las pruebas pasaron exitosamente.\n"
        exit 0
    else
        printf "Algunas pruebas fallaron.\n"
        exit 1
    fi
else
    printf "Error! El programa exec.c parece no estar compilado.\n"
    exit 1
fi


