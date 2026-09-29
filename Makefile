.DEFAULT_GOAL := help

PACKAGE_NAME := chdiss
PACKAGE_VERSION := 0.1.0
LOCAL_PKG_DIR := $(HOME)/.local/share/typst/packages/local/$(PACKAGE_NAME)/$(PACKAGE_VERSION)
LOCAL_FONTS_DIR := $(HOME)/.local/share/fonts/chdiss
CUSTOMFONT := --font-path fonts/

.PHONY: install-local
## install/link this repository to Typst local packages (@local/chdiss:0.1.0)
install-local:
	@mkdir -p $(HOME)/.local/share/typst/packages/local/$(PACKAGE_NAME)
	@ln -sfn $(CURDIR) $(LOCAL_PKG_DIR)
	@echo "Linked $(CURDIR) to $(LOCAL_PKG_DIR)"

.PHONY: uninstall-local
## remove the local package symlink
uninstall-local:
	@rm -f $(LOCAL_PKG_DIR)
	@echo "Removed $(LOCAL_PKG_DIR)"

.PHONY: install-fonts
## copy bundled fonts to ~/.local/share/fonts/chdiss and refresh font cache
install-fonts:
	@mkdir -p $(LOCAL_FONTS_DIR)
	@cp -rf fonts/* $(LOCAL_FONTS_DIR)/
	@fc-cache -f $(LOCAL_FONTS_DIR) 2>/dev/null || true
	@echo "Installed bundled fonts to $(LOCAL_FONTS_DIR)"

.PHONY: test-init
## test creating and compiling a new dissertation using typst init
test-init: install-local
	@TEST_DIR=/tmp/test-chdiss-$$$$; \
	echo "Testing typst init in $$TEST_DIR..."; \
	typst init @local/$(PACKAGE_NAME):$(PACKAGE_VERSION) "$$TEST_DIR" || exit 1; \
	cd "$$TEST_DIR" && typst compile main.typ || exit 1; \
	echo "✅ typst init test succeeded!"; \
	rm -rf "$$TEST_DIR"

.PHONY: generate
## generate the example document template/main.pdf
generate:
	typst compile template/main.typ template/main.pdf $(CUSTOMFONT)

.PHONY: thumbnail
## generate the template preview thumbnail (thumbnail.png)
thumbnail:
	typst compile template/main.typ --pages 1 $(CUSTOMFONT) thumbnail.png

.PHONY: watch
## watch and recompile template/main.pdf on change (dev mode)
watch:
	typst watch template/main.typ template/main.pdf $(CUSTOMFONT) --input dev="true"

.PHONY: watchnodev
## watch and recompile template/main.pdf on change (production mode)
watchnodev:
	typst watch template/main.typ template/main.pdf $(CUSTOMFONT) --input dev="false"

.PHONY: populate
## populate the example document with filler text
populate:
	typst compile template/main.typ template/main.pdf --input dev="true" --input populate=1000 $(CUSTOMFONT)

.PHONY: html
## compile experimental HTML version
html:
	typst compile template/main.typ template/main.html --input htmlmode="true" --features html $(CUSTOMFONT) --diagnostic-format short

.PHONY: queryrefs
## check the example document for broken/missing citations natively
queryrefs:
	@echo "Checking Typst document for missing citations..."
	@RESULT=$$(typst query template/main.typ "<missing-cite>" --input dev="true" $(CUSTOMFONT)); \
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
	typst query template/main.typ --input dev="true" $(CUSTOMFONT) "<chapter-lengths>" --field value | \
	jq '.[0] | map(select(.title != "Testing" and .title != "Appendix")) | { chapters: ., total_sum: (map(.total_pages) | add) }'

.PHONY: check-typ-files
## run Python glossary term checking script
check-typ-files:
	python3 scripts/check_typ_files.py

.PHONY: clean
## delete generated example artifacts
clean:
	rm -f template/main.pdf template/main.html

.PHONY: help
# See <https://gist.github.com/klmr/575726c7e05d8780505a> for explanation.
## show this help message
help:
	@echo "$$(tput bold)Available rules:$$(tput sgr0)";echo;sed -ne"/^## /{h;s/.*//;:d" -e"H;n;s/^## //;td" -e"s/:.*//;G;s/\\n## /---/;s/\\n/ /g;p;}" ${MAKEFILE_LIST}|LC_ALL='C' sort -f|awk -F --- -v n=$$(tput cols) -v i=29 -v a="$$(tput setaf 6)" -v z="$$(tput sgr0)" '{printf"%s%*s%s ",a,-i,$$1,z;m=split($$2,w," ");l=n-i;for(j=1;j<=m;j++){l-=length(w[j])+1;if(l<= 0){l=n-i-length(w[j])-1;printf"\n%*s ",-i," ";}printf"%s ",w[j];}printf"\n";}'
