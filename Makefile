.ONESHELL:
SHELL = bash
.SHELLFLAGS = -ec

LATEX = lualatex
BUILD = _build
UPLOAD = _upload
EXTRA = _extra

SHAREPOINT_REAL = /Users/will/Library/CloudStorage/OneDrive-SharedLibraries-AdelaideUniversity/Applied Control Systems - Applied Control Systems
ifeq ($(shell test -d "$(SHAREPOINT_REAL)" && echo yes),yes)
SHAREPOINT = $(SHAREPOINT_REAL)
else
SHAREPOINT = ./Sharepoint
endif

texsty   = $(wildcard *.cls) $(wildcard *.sty) $(wildcard *.bib) applied-control-systems.tex $(wildcard *.lua)

notesrc  = applied-control-systems.tex
topcsrc  = $(wildcard acs-0-*.tex) $(wildcard acs-1-*.tex) $(wildcard acs-2-*.tex) $(wildcard acs-3-*.tex)
pracsrc  = $(wildcard acs-prac*.tex)
worksrc  = $(wildcard acs-workshop*.tex)
revsrc   = acs-revision.tex
examplesrc = $(wildcard worked-examples/we-*.tex)
extrafiles = $(notdir $(wildcard extra/*.*))

notepdf = $(notesrc:.tex=.pdf)
topcpdf = $(topcsrc:.tex=.pdf)
workpdf = $(worksrc:.tex=.pdf)
pracpdf = $(pracsrc:.tex=.pdf)
revpdf  = $(revsrc:.tex=.pdf)
examplepdf = $(examplesrc:.tex=.pdf)

buildnotepdf  = $(addprefix $(BUILD)/,$(notepdf))
buildtopcpdf  = $(addprefix $(BUILD)/,$(topcpdf))
buildworkpdf  = $(addprefix $(BUILD)/,$(workpdf))
buildpracpdf  = $(addprefix $(BUILD)/,$(pracpdf))
buildrevpdf   = $(addprefix $(BUILD)/,$(revpdf))
buildexamplepdf = $(addprefix $(BUILD)/,$(examplepdf))

pdfuploadnote = $(addprefix $(UPLOAD)/,$(notepdf))
pdfuploadtopc = $(addprefix $(UPLOAD)/,$(topcpdf))
pdfuploadwork = $(addprefix $(UPLOAD)/,$(workpdf))
pdfuploadprac = $(addprefix $(UPLOAD)/,$(pracpdf))
pdfuploadrev  = $(addprefix $(UPLOAD)/,$(revpdf))

uploadextra   = $(addprefix $(EXTRA)/,$(extrafiles))


.PHONY: help edit topics pracs workshops notes examples revision all upload uploadnotes clean figures

help:
	@echo 'APPL CONTROL SLIDES MAKEFILE:'
	@echo ''
	@echo '      topics - PDFs for each topic'
	@echo '       pracs - PDFs for each prac'
	@echo '   workshops - PDFs for each workshops'
	@echo '       notes - Combined lecture notes'
	@echo '    examples - PDFs for worked examples'
	@echo '    revision - Week 10 revision slides'
	@echo '         all - All of the above'
	@echo '   upload[*] - Make [*] as above (e.g. "uploadpracs" reqs "pracs") and upload the results'
	@echo '       extra - Upload all files in extra/ to Canvas'
	@echo '       clean - Remove cruft in working directly and all _build/ files'
	@echo '        edit - Edit this Makefile'

test:
	echo $(extrafiles)

edit:
	edit Makefile || bbedit Makefile

topics:    $(buildtopcpdf)
pracs:     $(buildpracpdf)
workshops: $(buildworkpdf)
notes:     $(buildnotepdf)
examples:  $(buildexamplepdf)
revision:  $(buildrevpdf)
extra:     $(uploadextra)
all: topics pracs workshops notes examples revision

uploadtopics:    $(pdfuploadtopc)
uploadpracs:     $(pdfuploadprac)
uploadworkshops: $(pdfuploadwork)
uploadnotes:     $(pdfuploadnote)
uploadrevision:  $(pdfuploadrev)
uploadall: uploadtopics uploadpracs uploadworkshops uploadnotes

clean:
	rm -fv *.log *.aux *.nav *.snm *.gz *.toc *.vrb *-blx.bib *.run.xml
	mkdir -p $(BUILD)
	rm -fv $(BUILD)/*.*
	echo "The contents of this folder are auto-generated and can be safely deleted." > $(BUILD)/README.md

$(UPLOAD)/%.pdf: $(BUILD)/%.pdf
	mkdir -p "$(SHAREPOINT)/PDF"
	mkdir -p $(UPLOAD)
	@echo '\n\nUPLOAD\n\n'
	lua canvas-acs-upload-file.lua $<  &&  cp -f $< $@  &&  cp -f $< "$(SHAREPOINT)/PDF/$*.pdf" && echo ' ' && echo 'PDF copied to:' && echo '    $(SHAREPOINT)/PDF/$*.pdf'

$(EXTRA)/%: extra/%
	mkdir -p $(EXTRA)
	@echo '\n\nEXTRA\n\n'
	lua canvas-acs-upload-file.lua $<  &&  cp -f $< $@

$(BUILD)/%.pdf: %.tex
	mkdir -p $(BUILD)
	cp -f $< $(BUILD)/
	cp -f $(texsty) $(BUILD)/
	cp -f $(topcsrc) $(pracsrc) $(BUILD)/
	@echo "\n\nCOMPILE\n\n"
	cd "$(CURDIR)/$(BUILD)"; $(LATEX) $*
	cd "$(CURDIR)/$(BUILD)"; bibtex  $* || echo "BibTeX may have failed."
	cd "$(CURDIR)/$(BUILD)"; $(LATEX) $*
	echo "\n\nDone!\n\n"

%-myrio.tex: %.tex

$(BUILD)/worked-examples/%.pdf: worked-examples/%.tex worked-examples-template.sty
	mkdir -p $(BUILD)/worked-examples
	cp -f $< $(BUILD)/worked-examples/
	cp -f worked-examples-template.sty beamer-control-maths.sty $(BUILD)/worked-examples/
	@echo "\n\nCOMPILE WORKED EXAMPLE\n\n"
	cd "$(CURDIR)/$(BUILD)/worked-examples"; $(LATEX) $(notdir $<)
	cd "$(CURDIR)/$(BUILD)/worked-examples"; $(LATEX) $(notdir $<)
	echo "\n\nDone!\n\n"

$(BUILD)/applied-control-systems.pdf: applied-control-systems.tex $(topcsrc)
	mkdir -p $(BUILD)
	cp -f $^ $(BUILD)/
	cp -f $(texsty) $(BUILD)/
	cp -f $(topcsrc) $(BUILD)/
	@echo "\n\nCOMPILE\n\n"
	cd "$(CURDIR)/$(BUILD)"; $(LATEX) applied-control-systems
	cd "$(CURDIR)/$(BUILD)"; bibtex  applied-control-systems || echo "BibTeX may have failed."
	cd "$(CURDIR)/$(BUILD)"; $(LATEX) -interaction=batchmode applied-control-systems
	echo "\n\nDone!\n\n"
