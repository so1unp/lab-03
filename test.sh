#!/bin/bash

exec_result=false
fork_result=false
mfork_result=false

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
    fi
else
    printf "exec.c no esta compilado.\n"
fi

if [ -f "bin/fork" ]; then
    printf "Testing: bin/fork test.txt hola mundo\n"

    printf "\tProbando que verifique argumentos: "
    bin/fork > /dev/null 2>&1
    if [ $(echo $?) != 0 ]; then
        printf "Ok\n"
        fork1=true
    else
        printf "Fallo\n"
        fork1=false
    fi

    bin/fork test.txt hola mundo > /dev/null 2>&1
    bin/fork test.txt hola mundo > /dev/null 2>&1

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
        fork_result=true
    fi
else
    printf "fork.c no esta compilado.\n"
fi

if [ -f "bin/mfork" ]; then
    printf "...\n"
else
    printf "mfork.c no esta compilado.\n"
fi

if $exec_result && $fork_result && $mfork_result; then
    exit 0
else
    exit 1
fi

