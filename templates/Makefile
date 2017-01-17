#
#

SRCS=$(wildcard *template.tex)

OBJS=$(SRCS:.tex=.pdf)

all: $(OBJS) 


all: *
%.pdf: %.tex 
	latexmk -bibtex -pdf -f  $<

clean :
	latexmk -c 
	rm *.pdf
