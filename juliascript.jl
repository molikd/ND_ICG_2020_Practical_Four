#! usr/bin/env julia

using StringDistances
using CSV
using DataFrames
using ArgParse


#Parse arguments
s = ArgParseSettings()
@add_arg_table! s begin
	"--input"
		help = "an input text file of sequences to compare"
		required = true
	"--word_len"
		help = "length of work in Jaccard calculation"
		arg_type = Int
		default = 3
	"--output"
		help = "filename for output distance matrix, a .csv file"
		required = true
end

parsed_args = parse_args(ARGS, s)


#set arguments as variables
input_file = parsed_args["input"]
output_file = parsed_args["output"]
word_length = parsed_args["word_len"]

#import data text file
df = CSV.read(input_file)
matx = convert(Matrix, df)

#get the number of sequences 
n = length(matx)

#create a distance matrix of zeros to be filled
dist_matx = zeros(n,n)


#loop through each sequence and compare it to each other sequence, store results in matrix
for i in 1:n
	for j in 1:n
		Jac_dist = compare(matx[i], matx[j], Jaccard(word_length))
		global dist_matx[i,j] = Jac_dist
	end
end

#convert to dataframe and print top left corner for verification
dist_DF = DataFrame(dist_matx)
println("First five rows and columns of distance matrix:")
println(dist_DF[1:5, 1:5])

#write data frame to csv file
CSV.write(output_file, dist_DF)

println("Full Distance matrix saved as csv file")

