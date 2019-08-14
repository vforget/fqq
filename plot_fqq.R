#!/usr/bin/Rscript

source("fqq.R")

args <- commandArgs(trailingOnly = TRUE)

p.f = args[1]
p.m = as.numeric(args[2])
p.e = as.numeric(args[3])

if (is.na(p.m)){
   p.m = 0.001
}
if (is.na(p.e)){
   p.e = 0.001
}

message(paste0("p.m = ",p.m,"\np.e = ",p.e)) 
qq.f = paste0(p.f, ".qq.png")
message(paste0("output file name = ", qq.f))

message("Loading data >> ", appendLF=FALSE)
DT <- fread(p.f, header=TRUE)

png(file=qq.f, res=300, height = 2000, width = 2000)
fqq(DT$P, p.m=p.m, p.e=p.e, type="subsample")
invisible(dev.off())

message("Done.")
