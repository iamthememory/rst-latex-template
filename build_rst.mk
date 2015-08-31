# Get the path of the LaTeX template.
# Partially from <http://stackoverflow.com/a/23324703/4535462>
RST_LATEX_TEMPLATE_DIR := $(shell dirname "$(realpath $(lastword $(MAKEFILE_LIST)))")/texmf/

RST2LATEX = rst2latex.py
RST2LATEXFLAGS = $(RST2LATEXDOCFLAGS) $(RST2LATEXCLASS) --smart-quotes=yes

RST2LATEXDOCFLAGS = --documentoptions=12pt,letterpaper,twoside
RST2LATEXCLASS = --documentclass=iatm_school

# The number of digits in the commit abbreviation.
GIT_COMMIT_LEN = 12

pdfs := $(patsubst %.rst,%.pdf,$(wildcard *.rst))

all: pdf

pdf: $(pdfs)

# Build the LaTeX from ReST.
%.tex: %.rst
	TEXMFHOME="$(RST_LATEX_TEMPLATE_DIR):$$TEXMFHOME" $(RST2LATEX) \
		$(RST2LATEXFLAGS) \
		--latex-preamble="\input{$(patsubst %.rst,%.ghead,$<)}" $< $@

%.ghead: %.rst
	# The basic header stuff.
	echo "\usepackage[usenames]{color}" > $@
	# The commit hash colors
	echo "\definecolor{pageonecommithashcolor}{gray}{0.5}" >> $@
	echo "\definecolor{commithashcolor}{gray}{0.8}" >> $@
	# BEGIN: The headers for "plain" pages (e.g. the first page).
	echo "\fancypagestyle{plain}{%" >> $@
	echo "\fancyhf{} % Clear headers and footers" >> $@
	echo "\fancyfoot[C]{\thepage} % Keep the page number" >> $@
	# Get the author of the last modification, and put their name 
	# FIXME: This assumes that the last commit author is the author of the
	# entire thing.
	# This is not necessarily valid or reasonable.
	authcommit="$$(git log -n 1 --abbrev=20 --pretty=format:%h -- $<)" && \
	       modauthor="$$(git log -n 1 --pretty=format:%aN $$authcommit)" && \
	       echo "\fancyhead[L]{$${modauthor}}%" >> $@
	# Put the current commit and commit date on the first page.
	commit="$$(git describe --dirty --long --abbrev="$(GIT_COMMIT_LEN)" --always)" && \
		commitdate="$$(git log -n 1 --pretty=format:%cD $$(git describe --always))" && \
		echo "\fancyhead[R]{$${commitdate}}%" >> $@ && \
		echo "\fancyfoot[R]{\small\color{pageonecommithashcolor} Commit: $$commit}}" >> $@
	# END: The headers for "plain pages (e.g. the first page).
	# Put the current commit on all pages.
	commit="$$(git describe --dirty --long --abbrev="$(GIT_COMMIT_LEN)" --always)" && \
		echo "\fancyfoot[R]{\small\color{commithashcolor} Commit: $$commit}" >> $@

%.pdf: %.tex %.ghead
	latexmk -pdf -pdflatex="pdflatex -interaction=nonstopmode" -use-make $<
	rm -f *.aux *.bcf *.fls *.idx *.ind *.lof *.lot *.out *.toc *.log
	rm -f *.fdb_latexmk

%.png: %.gp
	gnuplot $<

%.png: %.svg
	inkscape -d 90 -f $< -e $@

clean:
	rm -f *.tex *.aux *.bcf *.fls *.idx *.ind *.lof *.lot *.out *.toc *.log
	rm -f *.fdb_latexmk *.ghead *.png

reallyclean: clean
	rm -f *.pdf

.PHONY: clean reallyclean all pdf
