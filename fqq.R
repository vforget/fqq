#!/usr/bin/Rscript

fqq <- function(pv, title="QQ plot", NSS=20000){

    quant.subsample <- function(y, m=100, e=1){
        ## Adapted from https://stats.stackexchange.com/a/35264/53539
        ## m: size of a systematic sample
        ## e: number of extreme values at either end to use
        x <- sort(y)
        n <- length(x)
        quants <- (1 + sin(1:m / (m+1) * pi - pi/2))/2
        sort(c(x[1:e], quantile(x, probs=quants), x[(n+1-e):n]))
        ## Returns m + 2*e sorted values from the EDF of y
    }

    
    message("Cleaning data [", appendLF=FALSE)
    message(length(pv), " > ", appendLF=FALSE)
    pvo <- pv
    pv <- as.numeric(pv)
    message(length(pv), " > ", appendLF=FALSE)
    pv <- pv[!is.na(pv)]
    message(length(pv), " > ", appendLF=FALSE)
    y <- -log10(pv)
    message(length(y), "] >> ", appendLF=FALSE)
    y[which(pv==0)] <- as.numeric(-log10(.N(pvo[which(pv==0)])))
    y = y[order(y,decreasing=F)]
    x <- -log10(ppoints(length(y)))
    lp <- list(x=x, y=y)

    message("Computing lambda >> ", appendLF=FALSE)
    chisq <- qchisq(1-pv,1)
    lambda <- round(median(chisq)/qchisq(0.5,1),2)
    
    message("Subsampling >> ", appendLF=FALSE)
    ## Adapted from https://stats.stackexchange.com/q/357952/53539
    mr <- NSS / length(lp$x)
    m <- mr * length(lp$x)
    er <- NSS / length(lp$x)
    e <- floor(er * length(lp$x))

    xy <- list(x=quant.subsample(lp$x, m, e), y=quant.subsample(lp$y, m, e))
    
    message("Confidence intervals >> ", appendLF=FALSE)
    ## Adapted from https://raw.githubusercontent.com/YinLiLin/R-MVP/master/R/MVP.Report.r
    N <- length(y)
    N1 <- length(lp$x)
    R <- 10^-seq(0, max(lp$x), by=0.0001)
    LR <- length(R)
    c95 <- rep(NA,LR)
    c05 <- rep(NA,LR)
    for(j in 1:LR){
        xi=R[j]*N
        if(xi==0)xi=1
        c95[j] <- qbeta(0.95,xi,N-xi+1)
        c05[j] <- qbeta(0.05,xi,N-xi+1)
    }
    index=length(c95):1
    
    message("Drawring plot >> ", appendLF=FALSE)
  
    par(mar=c(5,5,5,2))
    plot(-1,-1,
         xlim=range(xy$x),
         ylim=range(xy$y),
         xlab=expression(Expected~~-log[10](italic(p))),
         ylab=expression(Observed~~-log[10](italic(p))),
         main=title)
    polygon(c(-log10(R[index]),-log10(R)),c(-log10(c05[index]),-log10(c95)),col="#73737333",border="#73737333")
    abline(0,1,col=2)
    points(xy$x,xy$y, cex=1, pch=21, bg="#0000ff33", col="#0000ff")
    legend("topleft", c(as.expression(bquote(lambda == .(lambda))),
                        as.expression(bquote(N == .(length(y))))),
           bty='n')
}

library(data.table)
library(Rmpfr)

.N <- function(.) mpfr(., precBits = 10)

args <- commandArgs(trailingOnly = TRUE)
p.f = args[1]
NSS = as.numeric(args[2])
title = args[3]
qq.f = paste(p.f, ".qq.png", sep="")

message("Loading data >> ", appendLF=FALSE)
DT <- fread(p.f, header=TRUE)

png(file=qq.f, res=300, height = 2000, width = 2000)
fqq(DT$P, title=title, NSS=NSS)
invisible(dev.off())

message("Done.")

