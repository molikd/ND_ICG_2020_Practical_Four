#! usr/bin/env julia

using ArgParse
using StringDistances
using DataFrames
using CSV

#set up command line arguments
s = ArgParseSettings()
@add_arg_table! s begin
"--Input"
	required = true
	help = ":("
"--Number"
	arg_type = Int
	default = 3
	help = ":("
"--Mat"
	required = true
	help = ":("
end

parsed_args = parse_args(ARGS, s)

Input = parsed_args["Input"]
Number = parsed_args["Number"]
Mat = parsed_args["Mat"]

df = CSV.read(Input, header = false)

M = convert(Matrix, df)

n = length(M)

#empty matrix
D = zeros(n,n)

# Overlap coeffient measure
for i in 1:n
	for j in 1:n
		OverlapCoeff = evaluate(Overlap(Number), M[i], M[j])
		global D[i,j] = OverlapCoeff
	end
end

D_df = DataFrame(D)

CSV.write(Mat, D_df)
