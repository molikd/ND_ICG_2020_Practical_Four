#!/bin/bash
#$ -M msievert@nd.edu
#$ -m abe
#$ -pe smp 8
#$ -N pac4

module load julia

julia ./DistMat.jl --Input sequences.txt --Number 3 --Mat pac4_distance_matrix2.csv
