TARGET = $(shell basename `pwd`.pdf)
BIBTEX = bibtex
LATEX = pdflatex

EDITAVEIS_SOURCES =
EDITAVEIS_DIR = .
EDITAVEIS_FILES = $(addprefix $(EDITAVEIS_DIR)/, $(EDITAVEIS_SOURCES))

MAIN_FILE = main.tex
DVI_FILE  = $(addsuffix .dvi, $(basename $(MAIN_FILE)))
AUX_FILE  = $(addsuffix .aux, $(basename $(MAIN_FILE)))
PS_FILE   = $(addsuffix .ps, $(basename $(MAIN_FILE)))
PDF_FILE  = $(addsuffix .pdf, $(basename $(MAIN_FILE)))

SOURCES = $(EDITAVEIS_FILES)

.PHONY: all clean

all:
	@make $(TARGET)

$(TARGET): $(MAIN_FILE) $(SOURCES)
	$(LATEX) $(MAIN_FILE) $(SOURCES)
	# $(BIBTEX) $(AUX_FILE)
	$(LATEX) $(MAIN_FILE) $(SOURCES)
	$(LATEX) $(MAIN_FILE) $(SOURCES)
	@cp $(PDF_FILE) $(TARGET)

clean:
	rm -f *~ *.dvi *.ps *.backup *.aux *.log *.synctex*
	rm -f *.lof *.lot *.bbl *.blg *.brf *.toc *.idx *.fdb* *.fls
	rm -f $(PDF_FILE) $(TARGET)
