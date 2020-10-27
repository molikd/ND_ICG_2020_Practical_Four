#!/bin/bash
#$ -M ebrooks5@nd.edu
#$ -m abe
#$ -pe smp 8
#$ -N BIOS60132_Practical_Four

#Load julia module
module load julia

#Run julia script to generate distance matrix
julia ./generateDistanceMatrix.jl sequences.txt 3 sequenceDistances.csv