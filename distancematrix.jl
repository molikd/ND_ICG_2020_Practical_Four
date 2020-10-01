#! usr/bin/env julia

using ArgParse
using StringDistances
using DataFrames
using CSV

s = ArgParseSettings()
@add_arg_table! s begin
       "--input"
       required=true
	help = "file with sequences to compare"
       "--sub"
       arg_type=Int
       default=3
	help = "string length in sequence window"
       "--out"
       required=true
	help = "name of distance matrix outfile"
      end

parsed_args=parse_args(ARGS, s)
input=parsed_args["input"]
sub=parsed_args["sub"]
out=parsed_args["out"]


       seqCSV=CSV.read(input, header=false)
       seqmat=convert(Matrix, seqCSV)
       numseq=length(seqmat)
       distmat=zeros(numseq, numseq)
       for i in 1:numseq
       	for j in 1:numseq
       		overlapcoefficient=evaluate(Overlap(sub), seqmat[i], seqmat[j])
       		global distmat[i,j]=overlapcoefficient
end
end
       dist_df=DataFrame(distmat)
       CSV.write(out, dist_df)
