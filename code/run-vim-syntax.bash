#!/bin/bash
docker build -f ./docker/Dockerfile-vim-syntax -t vim-syntax .
docker run -it --rm vim-syntax bash
