#!/bin/bash

docker run --rm -it --name binwalk -v "${PWD}":/home/appuser/cwd binwalk -e -M -C cwd/workdir cwd/
