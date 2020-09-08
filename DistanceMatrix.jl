#! usr/bin/env julia

#load packages
using ArgParse
using StringDistances
using DataFrames
using CSV

#set up command line arguments
s = ArgParseSettings()
@add_arg_table! s begin
"--Input"
	required = true
	help = "specify single file with multiple sequences"
"--Substring"
	arg_type = Int
	default = 3
	help = "length of substrings being compared per sequence, default is 3"
"--Output"
	required = true
	help = "filename to store distance matrix as a csv"
end

parsed_args = parse_args(ARGS, s)

Input = parsed_args["Input"]
Substring = parsed_args["Substring"]
Output = parsed_args["Output"]
#load input file
df = CSV.read(Input, header = false)
#create 1xn matrix
M = convert(Matrix, df)
#count number of rows
n = length(M)
#make matrix nxn
DM = zeros(n,n)
#pairwise comparison of each string using Overlap coeffient
for i in 1:n
	for j in 1:n
		OverlapCoeff = evaluate(Overlap(Substring), M[i], M[j])
		global DM[i,j] = OverlapCoeff
	end
end
#convert back to dataframe
DM_df = DataFrame(DM)
#create output csv
CSV.write(Output, DM_df)
