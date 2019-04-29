#!/usr/bin/Rscript

source("fqq.R")

args <- commandArgs(trailingOnly = TRUE)

p.f = args[1]
p.m = as.numeric(args[2])
p.e = as.numeric(args[3])

qq.f = paste(p.f, ".qq.png", sep="")

message("Loading data >> ", appendLF=FALSE)
DT <- fread(p.f, header=TRUE)

png(file=qq.f, res=300, height = 2000, width = 2000)
fqq(DT$P, p.m=p.m, p.e=p.e, type="subsample")
invisible(dev.off())

message("Done.")
