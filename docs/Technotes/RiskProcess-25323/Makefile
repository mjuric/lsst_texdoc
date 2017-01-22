#
#

SRCS=$(wildcard *.tex)

IMGS=$(wildcard images/*.pdf images/*.png)

FN=$(wildcard Doc*.tex)
OBJ=$(FN:.tex=.pdf)

all: $(OBJ) 

$(OBJ) : $(SRCS) $(IMGS) 
	latexmk -bibtex -pdf -f  $(FN)

clean :
	latexmk -c 

acronyms :
	acronyms.csh Document-25323.tex process.tex jira.tex 
