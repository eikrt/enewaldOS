#!/bin/sh

mkdir -p output
tar -czf output/nothung.tar.gz nothung/
tar -czf output/rhine.tar.gz rhine/
echo "Directories compressed successfully into output/nothung.tar.gz and output/rhine.tar.gz"
