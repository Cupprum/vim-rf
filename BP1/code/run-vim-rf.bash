#!/bin/bash
docker build -f ./docker/Dockerfile-vim-rf -t vim-rf .
docker run -it --rm vim-rf bash
