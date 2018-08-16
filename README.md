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
 2. `<p.m>`: The proportion of points to subsample from the QQ plot (excluding tails).
 3. `<p.e>`: The proportion of points to include from tails into the plot.

Example data:

    > write.table(data.frame(P=runif(2000000,0,1)), file="p.txt", row.names=FALSE, quote=FALSE)

Example command:

    fqq.R p.txt 0.001 0.01
