PACKAGE_NAME ?= surfer-galleries
-include gnumaint.mk

prefix = /usr/local
datarootdir = $(prefix)/share
datadir = $(datarootdir)
pkgdatadir = $(datadir)/$(PACKAGE_NAME)

JARDIR ?= ..

LISTOF_GALLERY = \
	fantasy \
	record \
	tutorial

LISTOF_METADATAFILE = \
	Gallery.properties

LISTOF_LTXMFILE = \
	$(foreach _gal, $(LISTOF_GALLERY), \
		$(foreach _glf, $(wildcard $(_gal)/??), $(_glf)/$(_gal)_$(notdir $(_glf)).tex ) \
		)

LISTOF_FXPFILE = \
	$(foreach _fxp, $(wildcard fxgui/??), $(_fxp)/MessagesBundle_$(notdir $(_fxp)).properties )

LISTOF_JSURFSCRIPT = \
	$(foreach _gal, $(LISTOF_GALLERY), \
		$(wildcard $(_gal)/icon/$(_gal)_*.jsurf) \
		)


LISTOF_TLC = \
	$(sort $(foreach _f, $(LISTOF_LTXMFILE) $(LISTOF_FXPFILE) , $(lastword $(subst /, ,$(dir $(_f)))) ))

LISTOF_PDFFILE = $(patsubst %.tex,%.pdf,$(LISTOF_LTXMFILE))
LISTOF_PNGICON = $(patsubst %.jsurf,%_icon.png,$(LISTOF_JSURFSCRIPT))

LATEXMK_OPTIONS = -silent

default:

build-png: $(LISTOF_PNGICON)

build-pdf: $(LISTOF_PDFFILE)

build: build-png build-pdf

JARCHIVEHIERARCHY:=de/mfo/jsurfer
jarbuild: build
	$(MKDIR_P) $(JARDIR)
	$(MKDIR_P) _SurferLocalization
		$(eval _jarbn:=SurferData)
		$(eval _wkd:=_SurferLocalization/$(jarbn))
		$(eval _folder:=$(_wkd)/$(JARCHIVEHIERARCHY))
		$(MKDIR_P) $(_folder)
		$(MKDIR_P) $(_folder)/gallery
		$(INSTALL_DATA) $(LISTOF_METADATAFILE) $(LISTOF_JSURFSCRIPT) $(LISTOF_PNGICON) $(_folder)/gallery
		$(JAR) cf $(JARDIR)/$(_jarbn).jar -C $(_wkd) de
	$(foreach _tlc,$(LISTOF_TLC), \
		$(eval _jarbn:=SurferLocalization_$(_tlc)) \
		$(eval _wkd:=_SurferLocalization/$(_jarbn)) \
		$(eval _folder:=$(_wkd)/$(JARCHIVEHIERARCHY)) \
		$(MKDIR_P) $(_folder) $(NEWLINE) \
		$(MKDIR_P) $(_folder)/fxgui $(NEWLINE) \
		$(MKDIR_P) $(_folder)/gallery $(NEWLINE) \
		$(eval _lfxp:=$(filter %_$(_tlc).properties ,$(LISTOF_FXPFILE))) \
			$(if $(_lfxp), $(INSTALL_DATA) $(_lfxp) $(_folder)/fxgui $(NEWLINE),) \
		$(eval _lpdf:=$(filter %_$(_tlc).pdf ,$(LISTOF_PDFFILE))) \
			$(if $(_lpdf), $(INSTALL_DATA) $(_lpdf) $(_folder)/gallery $(NEWLINE),) \
		$(JAR) cf $(JARDIR)/$(_jarbn).jar -C $(_wkd) de $(NEWLINE) \
		)

install: build
	$(MKDIR_P) $(DESTDIR)$(pkgdatadir)
	$(MKDIR_P) $(DESTDIR)$(pkgdatadir)/fxgui
	$(MKDIR_P) $(DESTDIR)$(pkgdatadir)/gallery
	$(foreach _pdf,$(LISTOF_PDFFILE), \
		$(INSTALL_DATA) $(_pdf) $(DESTDIR)$(pkgdatadir)/gallery/$(notdir $(_pdf)) \
		$(NEWLINE) \
		)
	$(foreach _fxp,$(LISTOF_FXPFILE), \
		$(INSTALL_DATA) $(_fxp) $(DESTDIR)$(pkgdatadir)/fxgui/$(notdir $(_fxp)) \
		$(NEWLINE) \
		)

uninstall:
	$(foreach _fxp,$(LISTOF_FXPFILE), \
		$(RM) $(DESTDIR)$(pkgdatadir)/fxgui/$(notdir $(_fxp)) \
		$(NEWLINE) \
		)
	$(foreach _pdf,$(LISTOF_PDFFILE), \
		$(RM) $(DESTDIR)$(pkgdatadir)/gallery/$(notdir $(_pdf)) \
		$(NEWLINE) \
		)
	@test ! -d $(DESTDIR)$(pkgdatadir)/gallery || $(RMDIR) $(DESTDIR)$(pkgdatadir)/gallery
	@test ! -d $(DESTDIR)$(pkgdatadir)/fxgui || $(RMDIR) $(DESTDIR)$(pkgdatadir)/fxgui
	@test ! -d $(DESTDIR)$(pkgdatadir) || $(RMDIR) $(DESTDIR)$(pkgdatadir)

clean:
	$(foreach _lmf,$(LISTOF_LTXMFILE), $(shell cd $(dir $(_lmf)) && $(LATEXMK) $(LATEXMK_OPTIONS) -c ;) )

distclean:
	$(foreach _lmf,$(LISTOF_LTXMFILE), $(shell cd $(dir $(_lmf)) && $(LATEXMK) $(LATEXMK_OPTIONS) -C ;) )
	$(RM_R) _SurferLocalization

maintainer-clean: distclean
	$(RM) $(LISTOF_PNGICON)

jarclean:
	$(RM) $(JARDIR)/SurferData.jar
	$(foreach _tlc,$(LISTOF_TLC), \
		$(RM) $(JARDIR)/SurferLocalization_$(_tlc).jar $(NEWLINE) \
		)

%.pdf: %.tex
	$(LATEXMK) $(LATEXMK_OPTIONS) -cd -pdflatex="xelatex --shell-escape" -pdf $<

%_icon.png: %.jsurf
	$(JSURF) --quality 3 --size 120 --output $@ $<

JSURF ?= /usr/bin/jsurf

LATEXMK ?= /usr/bin/latexmk
JAR ?= /usr/bin/jar
INSTALL ?= /usr/bin/install
INSTALL_DATA ?= $(INSTALL) -m 644
MKDIR_P ?= /bin/mkdir -p
RMDIR ?= /bin/rmdir --i
RM ?= /bin/rm -f
RM_R ?= $(RM) -r

define NEWLINE


endef

# eos
