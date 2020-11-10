#!/bin/bash
#$ -M nvincen2@nd.edu
#$ -m abe
#$ -N BIOS60132_Practical_Four

module load bio/2.0
module load julia

julia ./distmat.jl --input "sequences.txt" --output "distMat.csv" --Jac 3

