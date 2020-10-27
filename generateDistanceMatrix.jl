#! usr/bin/env julia

#Script to generate distance matrix for
# input sequences and length
#Usage: julia ./generateDistanceMatrix.jl sequencesFile length outputFile
#Usage Ex: julia ./generateDistanceMatrix.jl sequences.txt 3 sequenceDistances.csv

#Add packages
#import pkg
#Pkg.add("StringDistances")
#Pkg.add("DataFrames")
#Pkg.add("CSV")

#Load packages
using StringDistances
using DataFrames
using CSV

#Retrieve inputs
inputSeqs=ARGS[1]
inputLength=parse(Int, ARGS[2])
outputDist=ARGS[3]

#Read input sequences and convert to a matrix
seqsCSV=CSV.read(inputSeqs, header=false)
seqsMat=convert(Matrix, seqsCSV)

#Determine number of sequences
numSeqs=length(seqsMat)

#Initialize distance matrix
distMat=zeros(numSeqs,numSeqs)

#Loop over input sequences and compare each with all sequences
for i in 1:numSeqs
	for j in 1:numSeqs
		#Determine distance
		dist=evaluate(Overlap(inputLength), seqsMat[i], seqsMat[j])
		#Update distance matrix
		global distMat[i,j]=dist
	end
end

#Convert to dataframe and wite to csv
distDF=DataFrame(distMat)
CSV.write(outputDist, distDF)