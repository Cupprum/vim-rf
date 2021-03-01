#!/bin/bash
docker build -f ./docker/Dockerfile-vim-ale -t vim-ale .
docker run -it --rm vim-ale bash
