#!/bin/bash

if [ -f "./fork" ]; then
    printf "Testing: bin/fork test.txt hola mundo\n"

    printf "\tProbando que verifique argumentos: "
    ./fork > /dev/null 2>&1
    if [ $(echo $?) != 0 ]; then
        printf "Ok!\n"
        fork1=true
    else
        printf "Error!\n"
        fork1=false
    fi

    ./fork test.txt hola mundo > /dev/null 2>&1
    ./fork test.txt hola mundo > /dev/null 2>&1

    if [ -e test.txt ]; then
        fork0=true

        printf "\tVerificando permisos del archivo test.txt: "
        perms=$(ls -lh test.txt | awk '{print $1}')
        if [ "$perms" = "-rw-r--r--" ]; then
            printf "Ok!\n"
            fork2=true
        else
            printf "Error! Los permisos no son los pedidos en el ejercicio.\n"
            fork2=false
        fi

        printf "\tVerificando contenido del archivo test.txt: "
        linea1="$(tail -n 1 test.txt)"
        linea2="$(head -n 1 test.txt)"
        if [ "$linea2" = "Hijo: mundo" ] && 
            [ "$linea1" = "Padre: hola" ]; then
            printf "Ok!\n"
            fork3=true
        else
            printf "Error! El proceso hijo debe escribir primero en el archivo.\n"
            fork3=false
        fi

        printf "\tVerificando el modo O_APPEND: "
        line_count=$(wc -l test.txt | awk '{print $1}')
        if [ "$line_count" = "4" ]; then
            printf "Ok!\n"
            fork4=true
        else
            printf "Error! No se esta agregando el contenio a continuación del anterior.\n"
            fork4=false
        fi

        rm test.txt
    else
        fork0=false
        printf "\tError! No se genero el archivo test.txt\n"
    fi

    if $fork0 && $fork1 && $fork2 && $fork3 && $fork4 ; then
        printf "Todos las pruebas pasaron exitosamente.\n"
    else
        printf "Algunas pruebas fallaron.\n"
    fi
else
    printf "Error! El programa fork.c parece no estar compilado.\n"
fi
