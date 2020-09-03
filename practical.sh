#!/bin/bash
#$ -M sweaver4@nd.edu
#$ -m abe
#$ -N BIOS60132_Practical_Four

module load bio/2.0
module load julia


#input is a text file of sequences (one per line), output is csv file of the distance matrix
#word_len is the wordlength in the Jaccard distance calculation
#Each row and column in the matrix corresponds to one of the sequences in the input file

julia juliascript.jl --input "sequences.txt" \
	--output "distance_matrix_df.csv" \
	--word_len 3
