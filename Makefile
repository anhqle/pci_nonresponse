R_OPTS=--no-save --no-restore --no-init-file --no-site-file

TEXDIR = writeup
WRITEUPS = $(TEXDIR)/prelim_result.pdf

TEXEXTRAFILES := $(wildcard $(TEXDIR)/*.aux $(TEXDIR)/*.log $(TEXDIR)/*.toc $(TEXDIR)/*.blg $(TEXDIR)/*.bbl $(TEXDIR)/*.synctex.gz)


all: $(WRITEUPS)

writeup/prelim_result.pdf: writeup/prelim_result.tex fig/ttest_result.pdf
	cd writeup;latexmk -pdf prelim_result.tex

data/PCI2012_DDI.RData: R/0_clean.R data/PCI2012_DDI_cleanH_final.dta
	cd R;Rscript 0_clean.R $(R_OPTS)

fig/ttest_result.pdf: R/1_1_ttest_result.R data/PCI2012_DDI.RData
	cd R;Rscript 1_1_ttest_result.R $(R_OPTS)

print-%:
	@echo '$*=$($*)'
 
# Clean up stray files
clean:
	rm -fv $(TEXEXTRAFILES)
	rm -fv *.out *.bcf *blx.bib *.run.xml
	rm -fv $(TEXDIR)/*.fdb_latexmk $(TEXDIR)/*.fls
 
.PHONY: all clean


