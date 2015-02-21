#! /bin/bash

PORT=8787
docker run -v $PWD:/home/rstudio -d -p ${PORT}:${PORT} rocker/ropensci
open http://$(boot2docker ip):${PORT}

