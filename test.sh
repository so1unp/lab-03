#!/bin/bash

if [ -f "bin/exec" ]; then
    printf "Testing: bin/exec\n"

    printf "\tProbando que verifique argumentos: "
    bin/exec > /dev/null 2>&1
    if [ $(echo $?) != 0 ]; then
        printf "Ok\n"
        exec1=true
    else
        printf "Fallo\n"
        exec1=false
    fi

    printf "\tProbando ejecutar comando correcto: "
    bin/exec file exec.c > /dev/null 2>&1
    if [ $(echo $?) == 0 ]; then
        printf "Ok\n"
        exec2=true
    else
        printf "Fallo\n"
        exec2=false
    fi

    printf "\tProbando ejecutar comando que falla: "
    bin/exec file > /dev/null 2>&1
    if [ $(echo $?) != 0 ]; then
        printf "Ok\n"
        exec3=true
    else
        printf "Fallo\n"
        exec3=false
    fi

    printf "\tProbando ejecutar comando que no existe: "
    bin/exec este-comando-no-existe > /dev/null 2>&1
    if [ $(echo $?) != 0 ]; then
        printf "Ok\n"
        exec4=true
    else
        printf "Fallo\n"
        exec4=false
    fi

    if $exec1 && $exec2 && $exec3 && $exec4 ; then
        exec_result=true
    else
        exec_result=false
    fi
fi

if [ -f "bin/fork" ]; then
    printf "Testing: bin/fork test.txt hola mundo\n"

    bin/fork test.txt hola mundo > /dev/null
    bin/fork test.txt hola mundo > /dev/null

    printf "\tVerificando permisos del archivo test.txt: "
    perms=$(ls -lh test.txt | awk '{print $1}')
    if [ "$perms" = "-rw-r--r--" ]; then
        printf "Ok\n"
        result1=true
    else
        printf "Fallo\n"
        result1=false
    fi

    printf "\tVerificando contenido del archivo test.txt: "
    linea1="$(tail -n 1 test.txt)"
    linea2="$(head -n 1 test.txt)"
    if [ "$linea2" = "Hijo: mundo" ] && 
        [ "$linea1" = "Padre: hola" ]; then
        printf "Ok\n"
        result2=true
    else
        printf "Fallo\n"
        result2=false
    fi

    printf "\tVerificando el modo O_APPEND: "
    line_count=$(wc -l test.txt | awk '{print $1}')
    if [ "$line_count" = "4" ]; then
        printf "Ok\n"
        result3=true
    else
        printf "Fallo\n"
        result3=false
    fi

    rm test.txt

    if $result1 && $result2 && $result3 ; then
        fork_result=true
    else
        fork_result=false
    fi
fi

if $exec_result && $for_result; then
    exit 0
else
    exit 1
fi

