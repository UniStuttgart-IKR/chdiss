.DEFAULT_GOAL := help

FONTPATH := $(shell [ -d fonts ] && echo "--font-path fonts" || ([ -d ../fonts ] && echo "--font-path ../fonts" || echo ""))

.PHONY: generate
## generate main.pdf
generate:
	typst compile main.typ main.pdf $(FONTPATH)

.PHONY: watch
## watch and recompile main.pdf on change (dev mode)
watch:
	typst watch main.typ main.pdf $(FONTPATH) --input dev="true"

.PHONY: watchnodev
## watch and recompile main.pdf on change (production mode)
watchnodev:
	typst watch main.typ main.pdf $(FONTPATH) --input dev="false"

.PHONY: populate
## populate the document with filler text
populate:
	typst compile main.typ main.pdf --input dev="true" --input populate=1000 $(FONTPATH)

.PHONY: html
## compile experimental HTML version
html:
	typst compile main.typ main.html --input htmlmode="true" --features html $(FONTPATH) --diagnostic-format short

.PHONY: queryrefs
## check for missing citations or unresolved refs
queryrefs:
	@echo "Checking Typst document for missing citations..."
	@RESULT=$$(typst query main.typ "<missing-cite>" --input dev="true" $(FONTPATH)); \
	if [ "$$RESULT" = "[]" ]; then \
		echo "✅ All citations resolved!"; \
	else \
		echo "❌ ERROR: Missing citations found in the document!"; \
		echo "$$RESULT"; \
		exit 1; \
	fi

.PHONY: querychaplen
## query page counts per chapter
querychaplen:
	typst query main.typ --input dev="true" $(FONTPATH) "<chapter-lengths>" --field value | \
	jq '.[0] | map(select(.title != "Testing" and .title != "Appendix")) | { chapters: ., total_sum: (map(.total_pages) | add) }'

.PHONY: clean
## delete generated outputs
clean:
	rm -f main.pdf main.html

.PHONY: help
## show this help message
help:
	@echo "$$(tput bold)Available rules:$$(tput sgr0)";echo;sed -ne"/^## /{h;s/.*//;:d" -e"H;n;s/^## //;td" -e"s/:.*//;G;s/\\n## /---/;s/\\n/ /g;p;}" ${MAKEFILE_LIST}|LC_ALL='C' sort -f|awk -F --- -v n=$$(tput cols) -v i=29 -v a="$$(tput setaf 6)" -v z="$$(tput sgr0)" '{printf"%s%*s%s ",a,-i,$$1,z;m=split($$2,w," ");l=n-i;for(j=1;j<=m;j++){l-=length(w[j])+1;if(l<= 0){l=n-i-length(w[j])-1;printf"\n%*s ",-i," ";}printf"%s ",w[j];}printf"\n";}'
