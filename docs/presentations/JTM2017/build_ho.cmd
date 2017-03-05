export FN=ESA_OD_WOM_2016_ho
pdflatex $FN.tex
bibtex $FN
pdflatex $FN.tex
pdflatex $FN.tex

