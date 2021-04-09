#!/bin/bash

if [ -f "exec" ]; then
    printf "Testing: exec\n"

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
        printf "Ok\n"
        exec2=true
    else
        printf "Fallo\n"
        exec2=false
    fi

    printf "\tProbando ejecutar comando que falla: "
    ./exec file > /dev/null 2>&1
    if [ $(echo $?) != 0 ]; then
        printf "Ok\n"
        exec3=true
    else
        printf "Fallo\n"
        exec3=false
    fi

    printf "\tProbando ejecutar comando que no existe: "
    ./exec este-comando-no-existe > /dev/null 2>&1
    if [ $(echo $?) != 0 ]; then
        printf "Ok\n"
        exec4=true
    else
        printf "Fallo\n"
        exec4=false
    fi

    if $exec1 && $exec2 && $exec3 && $exec4 ; then
        printf "Todos los tests pasaron exitosamente.\n"
        exit 0
    else
        printf "Algunos tests fallaron.\n"
        exit 1
    fi
else
    printf "exec.c no esta compilado.\n"
    exit 1
fi


