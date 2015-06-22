


Tyding Data
========================================================
author: Hector Corrada Bravo
date: CADi 2015

Tidy Data
========================================================

[H. Wickham (2014). Tidy Data. *Journal of Statistical Software*.](http://www.jstatsoft.org/v59/i10/paper)

Principles of preparing and organizing data in a way that is amenable to analysis, modeling and visualization.

- **Structure**: Data organized in rectangular tables (rows and columns)
- **Semantics**: Values, variables, observations

Tidy Data
========================================================

Let's look at example tidy data

```r
library(nycflights13)
head(flights)
```

Tidy Data
========================================================

1. Each variable forms a column
2. Each observation forms a row
3. Each type of observational unit forms a table

Tidy Data
====================================

Common problems

- Column headers are values, not variable names (gather)
- Multiple variables stored in one column (split)
- Variables stored in both rows and column (rotate)
- Multiple types of observational units are stored in the same table (normalize)
- Single observational unit stored in multiple tables (join)

