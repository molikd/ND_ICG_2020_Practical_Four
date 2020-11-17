#!/bin/bash 


module load julia

julia distance.jl "--opt1" sequences.txt "--opt2" sequences.txt

julia distance.jl "--opt1" practical_four.fasta "--opt2" prac_four.txt
