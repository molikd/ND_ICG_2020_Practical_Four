#! /bin/bash
#$ -M svandext@nd.edu
#$ -m abe
#$ -pe smp 8
#$ ICG2020_practicalfour_SFV

julia  ./distancematrix.jl --input sequences.txt --sub 3 --out comat.csv
