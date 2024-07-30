#!/bin/bash

swww img -t any $(find $1 -type f | shuf -n 1)

