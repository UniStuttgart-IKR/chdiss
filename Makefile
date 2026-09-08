.DEFAULT_GOAL := help

CUSTOMFONT = "--font-path=diss_template_Ch/fonts/ --ignore-system-fonts "

.PHONY: generate
## generate the report main.pdf
generate:
	typst compile diss_template_Ch/main.typ $(CUSTOMFONT)

.PHONY: populate
## populate the document with lorems
populate:
	typst compile diss_template_Ch/main.typ --input dev="true" --input populate=1000 $(CUSTOMFONT)

.PHONY: plaintext
## generate the report as a plaintext "report.txt" (broken)
plaintext:
	typst compile diss_template_Ch/main.typ $(CUSTOMFONT)

.PHONY: html
## generate the report as an html
html:
	typst compile diss_template_Ch/main.typ diss_template_Ch/main.html --input htmlmode="true" --features html $(CUSTOMFONT) --diagnostic-format short

.PHONY: watchhtml
watchhtml:
## generate the report as an html and watch
	typst watch diss_template_Ch/main.typ diss_template_Ch/main.html --input htmlmode="true" --features html $(CUSTOMFONT) --diagnostic-format short

.PHONY: release
## make a release (broken)
release:
	typst compile diss_template_Ch/main.typ report-releases/main.pdf $(CUSTOMFONT)

.PHONY: watchnodev
## continue generating the report main.pdf in dev mode and track for changes
watchnodev:
	typst watch diss_template_Ch/main.typ --input dev="false" $(CUSTOMFONT)

.PHONY: watch
## continue generating the report main.pdf in dev mode and track for changes
watch:
	typst watch diss_template_Ch/main.typ --input dev="true" $(CUSTOMFONT)

.PHONY: queryrefs
## check the document for broken/missing citations natively
queryrefs:
	@echo "Checking Typst document for missing citations..."
	@# We run the query with DEV=true so the show rule is active
	@RESULT=$$(typst query diss_template_Ch/main.typ "<missing-cite>" --input dev="true" $(CUSTOMFONT)); \
	if [ "$$RESULT" = "[]" ]; then \
		echo "✅ All citations resolved!"; \
	else \
		echo "❌ ERROR: Missing citations found in the document!"; \
		echo "$$RESULT"; \
		exit 1; \
	fi

.PHONY: querychaplen
## query how many pages per chapter and get the total sum
querychaplen:
	typst query diss_template_Ch/main.typ --input dev="true" $(CUSTOMFONT) "<chapter-lengths>" --field value | \
	jq '.[0] | map(select(.title != "Testing" and .title != "Appendix")) | { chapters: ., total_sum: (map(.total_pages) | add) }'

.PHONY: clean
## delete the report main.pdf
clean:
	rm -f diss_template_Ch/main.pdf

.PHONY: help
# See <https://gist.github.com/klmr/575726c7e05d8780505a> for explanation.
## show this help message
help:
	@echo "$$(tput bold)Available rules:$$(tput sgr0)";echo;sed -ne"/^## /{h;s/.*//;:d" -e"H;n;s/^## //;td" -e"s/:.*//;G;s/\\n## /---/;s/\\n/ /g;p;}" ${MAKEFILE_LIST}|LC_ALL='C' sort -f|awk -F --- -v n=$$(tput cols) -v i=29 -v a="$$(tput setaf 6)" -v z="$$(tput sgr0)" '{printf"%s%*s%s ",a,-i,$$1,z;m=split($$2,w," ");l=n-i;for(j=1;j<=m;j++){l-=length(w[j])+1;if(l<= 0){l=n-i-length(w[j])-1;printf"\n%*s ",-i," ";}printf"%s ",w[j];}printf"\n";}'

