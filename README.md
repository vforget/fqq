# fqq: Fast and Arbitrary Precision QQ plot

Depends: `data.table` and `Rmpfr`.

Features:

 * Over 10x faster that plotting all the points.
 * Support p-values less than default floating point limit of ~1e-323.

**IMPORTANT**: Used properly, this code will result in a QQ plot that is identical to one using all the data points. However, choosing too small a subsample will produce a QQ plot that is an approximation to that of using all data points, although likely a very close approximation.

Usage:

    fqq.R <txt> <p.m> <p.e>

Where arguments are:

 1. `<txt>`: Text file containing a column labeled P with p-values. For fast loading have the file contain only this column.
 2. `<p.m>`: The proportion of points to subsample from the QQ plot. Default to sub-sample 0.1% of p-value distribution, excluding the tails (see next point).
 3. `<p.e>`: Cutoff to select points as being in the tails to plot. Default to include the top and bottom 1% of the p-value distribution into the plot.

Example command:

    fqq.R p.txt 0.001 0.01

Example data:

    > write.table(data.frame(P=runif(2000000,0,1)), file="p.txt", row.names=FALSE, quote=FALSE)
