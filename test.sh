#!/bin/bash

if [ ! -f "bin/fork" ]; then
    printf "bin/fork no esta compilado.\n"
    exit 1
fi

printf "Testing: bin/fork test.txt hola mundo\n"

bin/fork test.txt hola mundo > /dev/null
bin/fork test.txt hola mundo > /dev/null

perms=$(ls -lh test.txt | awk '{print $1}')
if [ "$perms" = "-rw-r--r--" ]; then
    printf "\tpermisos de archivo test.txt: ok.\n"
    result1=true
else
    printf "\tpermisos de archivo test.txt: incorrectos.\n"
    result1=false
fi

linea1="$(tail -n 1 test.txt)"
linea2="$(head -n 1 test.txt)"
if [ "$linea2" = "Hijo: mundo" ] && 
    [ "$linea1" = "Padre: hola" ]; then
    printf "\tcontenidos del archivo: ok.\n"
    result2=true
else
    printf "\tcontenidos del archivo: incorrectos.\n"
    result2=false
fi

line_count=$(wc -l test.txt | awk '{print $1}')
if [ "$line_count" = "4" ]; then
    printf "\tmodo append: ok.\n"
    result3=true
else
    printf "\tmodo append: falló.\n"
    result3=false
fi

rm test.txt

if $result1 && $result2 && $result3 ; then
    exit 0
else
    exit 1
fi

