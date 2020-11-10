#! usr/bin/env julia

using StringDistances
using ArgParse
using CSV
using DataFrames

s = ArgParseSettings()
@add_arg_table! s begin
	"--input"
		required = true
	"--Jac"
		arg_type = Int
		default = 3
	"--output"
		required = true
end

parsed_args = parse_args(ARGS, s)

input = parsed_args["input"]
jac_len = parsed_args["Jac"]
output = parsed_args["output"]

df = CSV.read(input)
df1 = convert(Matrix, df)
seqnum = length(df1)
zeromat = zeros(seqnum,seqnum)

for i in 1:seqnum
	for j in 1:seqnum
		pair_dist = compare(df1[i], df1[j], Jaccard(jac_len))
		global zeromat[i,j] = pair_dist
	end
end

dfOut = DataFrame(zeromat)
CSV.write(output, dfOut)
