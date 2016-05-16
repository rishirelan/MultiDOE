Toolbox MultiDOE
=======

This Matlab toolbox regroups many existing tools for generating sample points using many specific DOE techniques:

* Full factorial sampling
* Latin Hypercube Sampling 
* Optimal Latin Hypercube sampling
* Improved Hypercube Sampling
* Random Sampling

Many techniques propose in this toolbox are based on 

* the [R software](https://cran.r-project.org/). More precisely, the library [lhs](https://cran.r-project.org/web/packages/lhs/index.html) is used. 
* the [IHS](https://people.sc.fsu.edu/~jburkardt/m_src/ihs/ihs.html) matlab's softwares proposed by [John Burkardt](http://people.sc.fsu.edu/~jburkardt/)
* the [LHS](http://www.mathworks.com/matlabcentral/fileexchange/4352-latin-hypercube-sampling/content/lhsu.m) proposed by Budiman Minasny

Features
------
The MultiDOE toolbox are able to 

* generate sampling
* sort the sample points using many techniques
* add points to an existing sampling (based on the LHS and IHS procedures of the R software)
* normalize/renormalize the sample points to be weel defined in the specified design space
* call automatically the R software (on Unix/Linux/OSX systems only)
* compute scores (minimal distances, discrepancy...), see for instance the [Franco's PhD thesis (2008)](https://tel.archives-ouvertes.fr/tel-00803107/)



Requirements
------
The toolbox requires:

* the [Statistics and Machine Learning Toolbox](http://fr.mathworks.com/products/statistics/) of the Matlab's software
* the R software installed on an UNIX/Linux/OSX system and the `R` command available on the command line
* the [lhs](https://cran.r-project.org/web/packages/lhs/index.html) and [R.matlab](https://cran.r-project.org/web/packages/R.matlab/index.html) installed on R (see for instance [How to Install an R Package](http://math.usask.ca/~longhai/software/installrpkg.html))
* the [graphviz software](www.graphviz.org) (the `dot` command must be available on the command line) for building the documentation (optional).

Documentation
------
The automatic building of the documentation is based on the [m2html](http://www.artefact.tk/software/matlab/m2html/) software.

License
----
