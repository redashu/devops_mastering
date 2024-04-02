#!/bin/bash

if [ "$myenv" == "dev" ]
then
    python3 ok.py 
elif [ "$myenv" == "prod" ]
then
     python3 hello.py 
else 
    echo "you need to pass correct env "
    echo "shuting down the container"
fi 