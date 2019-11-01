#!/usr/bin/env bash

figlet -w 160 -f standard "Push Images"

docker login

figlet -w 160 -f small "Push Zipster Image"

docker push howarddeiner/zipster-spark