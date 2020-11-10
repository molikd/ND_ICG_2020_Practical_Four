#! usr/bin/env julia

using StringDistances
using ArgParse
using CSV
using Dataframes

s = ArgParseSettings()
@add_arg_table! s begin
	"--input"
	"--Jac"
		arg_type = Int
		default = 3
	"--output"
		required = true
end

parsed_args = parse_args(ARGS, s)

input_file = parsed_args["input"]
jac_len = parsed_args["Jac"]
output = parsed_args["output"]

df = CSV.read(input_file)
df1 = convert(Matrix, df)
seqnum = length(df1)
zeromat = zeros(seqnum,seqnum)

for i in 1:seqnum
	for j in 1:seqnum
		Jac_dist = compare(df1[i], df1[j], Jaccard(jac_len))
		global zeromat[i,j] = Jac_dist
	end
end

dfOut = DataFrame(zeromat)
CSV.write(output, dfOut)
