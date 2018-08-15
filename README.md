# fqq: Fast and Arbitrary Precision QQ plot

Depends: `data.table` and `Rmpfr`.

Usage:

    fqq.R p.txt 20000 "some title"

Where arguments are:

 1. Text file containing a column labeled P with p-values. For fast loading have the file contain only this column.
 2. The number of p-values to sub-sample. Empirical analysis has shown that 20,000 is adequate.
 3. Title for the plot. Enclose in double-quotes if title has spaces.

Example data:

    > write.table(data.frame(P=runif(2000000,0,1)), file="p.txt", row.names=FALSE, quote=FALSE)

Example command:

    fqq.R p.txt 20000 "Example QQ Plot"

