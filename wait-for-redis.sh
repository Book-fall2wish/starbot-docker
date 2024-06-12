#!/bin/sh
 
while ! nc -z redis 6379; do
    echo "Redis is unavailable - sleeping"
    sleep 1
done
 
echo "Redis is up and running - starting python script"
