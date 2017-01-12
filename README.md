LaTeX Templates for LSST Documents
==================================

Usage
-----

Follow the instructions in the [Setting Up](#setting-up) section to make the
contents of this package known to LaTeX.  Once you do so, two new document
classes should become available:

    \documentclass{lsstbeamer}
    \documentclass{lsstdoc}

Note that you'll most likely have to use `pdflatex`:

    pdflatex lsst-ms.tex

, as some (older?) versions of `latex` do not recognize PNG images included
with these templates.


Available templates
-------------------
In the templates folder are some example files. Just copy it to your directory to use as a starting point for a new document. 
*	tn_template.tex    - basic technical note
*	plan_template.tex  - detailed plan with all suggested sections
* 	sdd_template.tex 	- SOftware Design Documnent
*	presentation.tex   - using lsstbeamer.cls for LSST themed presentation


Setting Up
----------

If you're using EUPS, simply `setup` this product. For example:

    setup -r .

Otherwise, manually prepend `$PWD/texmf` to your TEXMFLOCAL; e.g.:

    export TEXMFLOCAL="$PWD/texmf:$TEXMFLOCAL"

assuming you're in the top-level directory of the product (the same
directory this file is in). You can also add this to your `.bashrc` or
equivalent.


Modifying
---------

First, follow the instructions in the Setting Up section to make the contents of
this package known to LaTeX.

If you add new files to texmf, make sure to refresh the `ls-R` databases by
running:

    mktexlsr

before attempting to use.

Documents
---------
For now some documents and presentations are also in this repo under docs. 

