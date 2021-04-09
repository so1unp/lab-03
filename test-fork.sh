#!/bin/bash

if [ -f "./fork" ]; then
    printf "Testing: bin/fork test.txt hola mundo\n"

    printf "\tProbando que verifique argumentos: "
    ./fork > /dev/null 2>&1
    if [ $(echo $?) != 0 ]; then
        printf "Ok\n"
        fork1=true
    else
        printf "Fallo\n"
        fork1=false
    fi

    ./fork test.txt hola mundo > /dev/null 2>&1
    ./fork test.txt hola mundo > /dev/null 2>&1

    printf "\tVerificando permisos del archivo test.txt: "
    perms=$(ls -lh test.txt | awk '{print $1}')
    if [ "$perms" = "-rw-r--r--" ]; then
        printf "Ok\n"
        fork2=true
    else
        printf "Fallo\n"
        fork2=false
    fi

    printf "\tVerificando contenido del archivo test.txt: "
    linea1="$(tail -n 1 test.txt)"
    linea2="$(head -n 1 test.txt)"
    if [ "$linea2" = "Hijo: mundo" ] && 
        [ "$linea1" = "Padre: hola" ]; then
        printf "Ok\n"
        fork3=true
    else
        printf "Fallo\n"
        fork3=false
    fi

    printf "\tVerificando el modo O_APPEND: "
    line_count=$(wc -l test.txt | awk '{print $1}')
    if [ "$line_count" = "4" ]; then
        printf "Ok\n"
        fork4=true
    else
        printf "Fallo\n"
        fork4=false
    fi

    rm test.txt

    if $fork1 && $fork2 && $fork3 && $fork4 ; then
        printf "Todos los tests pasaron exitosamente.\n"
        exit 0
    else
        printf "Algunos tests fallaron.\n"
        exit 1
    fi
else
    printf "fork.c no esta compilado.\n"
    exit 1
fi
