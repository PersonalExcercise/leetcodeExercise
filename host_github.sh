#!/bin/sh

make html
mkdir -p docs
cp -r build/html/* docs