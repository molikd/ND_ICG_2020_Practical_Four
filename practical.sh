#!/bin/bash
#$ -M bcoggins@nd.edu
#$ -m abe
#$ -pe smp 8
#$ -N BIOS60132_Practical_Four

module load julia

julia ./DistanceMatrix.jl --Input sequences.txt --Substring 3 --Output OverlapCoeff.csv
