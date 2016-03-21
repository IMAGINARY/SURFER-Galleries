PACKAGE_NAME ?= surfer-alggeo-galleries
-include maint.mk

prefix = /usr
datarootdir = $(prefix)/share
datadir = $(datarootdir)
pkgdatadir = $(datadir)/$(PACKAGE_NAME)

JARDIR ?= ..

LISTOF_GALLERY = \
	fantasy \
	record \
	tutorial

LISTOF_METADATAFILE =

LISTOF_LTXJSSFILE = \
	$(wildcard common/images/*.jsurf)

LISTOF_LTXMFILE = \
	$(foreach _gal, $(LISTOF_GALLERY), \
		$(foreach _glf, $(wildcard $(_gal)/??) $(wildcard $(_gal)/??_??), $(_glf)/$(_gal)_$(notdir $(_glf)).tex ) \
		)

LISTOF_FXPFILE = \
	$(foreach _fxp, $(wildcard fxgui/??), $(_fxp)/MessagesBundle_$(notdir $(_fxp)).properties )

LISTOF_JSURFSCRIPT = \
	$(foreach _gal, $(LISTOF_GALLERY), \
		$(wildcard $(_gal)/icon/$(_gal)_*.jsurf) \
		)


LISTOF_TLLC = \
	$(sort $(foreach _f, $(LISTOF_LTXMFILE) $(LISTOF_FXPFILE) , $(lastword $(subst /, ,$(dir $(_f)))) ))

LISTOF_LTXPNG = $(patsubst %.jsurf,%.png,$(LISTOF_LTXJSSFILE))
LISTOF_PDFFILE = $(patsubst %.tex,%.pdf,$(LISTOF_LTXMFILE))
LISTOF_PNGICON = $(patsubst %.jsurf,%_icon.png,$(LISTOF_JSURFSCRIPT))


GALLERY_DATA_COMMON = \
	$(LISTOF_METADATAFILE) \
	$(LISTOF_JSURFSCRIPT) \
	$(LISTOF_PNGICON)

LATEXMK_OPTIONS = -silent -pv- -pvc-

default:

build-png: $(LISTOF_PNGICON)

build-pdf-images: $(LISTOF_LTXPNG)

$(LISTOF_PDFFILE): build-pdf-images

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
		#$(INSTALL_DATA) $(GALLERY_DATA_COMMON) $(_folder)/gallery
		$(JAR) cf $(JARDIR)/$(_jarbn).jar -C $(_wkd) de
	$(foreach _tllc,$(LISTOF_TLLC), \
		$(eval _jarbn:=SurferLocalization_$(_tllc)) \
		$(eval _wkd:=_SurferLocalization/$(_jarbn)) \
		$(eval _folder:=$(_wkd)/$(JARCHIVEHIERARCHY)) \
		$(MKDIR_P) $(_folder) $(NEWLINE) \
		$(MKDIR_P) $(_folder)/fxgui $(NEWLINE) \
		$(MKDIR_P) $(_folder)/gallery $(NEWLINE) \
		$(eval _lfxp:=$(filter %_$(_tllc).properties ,$(LISTOF_FXPFILE))) \
			$(if $(_lfxp), $(INSTALL_DATA) $(_lfxp) $(_folder)/fxgui $(NEWLINE),) \
		$(eval _lpdf:=$(filter %_$(_tllc).pdf ,$(LISTOF_PDFFILE))) \
			$(if $(_lpdf), $(INSTALL_DATA) $(_lpdf) $(_folder)/gallery $(NEWLINE),) \
		$(JAR) cf $(JARDIR)/$(_jarbn).jar -C $(_wkd) de $(NEWLINE) \
		)

install: build
	$(MKDIR_P) $(DESTDIR)$(pkgdatadir)
	$(MKDIR_P) $(DESTDIR)$(pkgdatadir)/fxgui
	$(MKDIR_P) $(DESTDIR)$(pkgdatadir)/gallery
	$(INSTALL_DATA) $(GALLERY_DATA_COMMON) $(DESTDIR)$(pkgdatadir)/gallery
	$(INSTALL_DATA) $(LISTOF_FXPFILE)      $(DESTDIR)$(pkgdatadir)/fxgui
	$(INSTALL_DATA) $(LISTOF_PDFFILE)      $(DESTDIR)$(pkgdatadir)/gallery

uninstall:
	cd $(DESTDIR)$(pkgdatadir)/gallery && $(RM) $(notdir $(LISTOF_PDFFILE))
	cd $(DESTDIR)$(pkgdatadir)/fxgui   && $(RM) $(notdir $(LISTOF_FXPFILE))
	cd $(DESTDIR)$(pkgdatadir)/gallery && $(RM) $(notdir $(GALLERY_DATA_COMMON))
	@test ! -d $(DESTDIR)$(pkgdatadir)/gallery || $(RMDIR) $(DESTDIR)$(pkgdatadir)/gallery
	@test ! -d $(DESTDIR)$(pkgdatadir)/fxgui || $(RMDIR) $(DESTDIR)$(pkgdatadir)/fxgui
	@test ! -d $(DESTDIR)$(pkgdatadir) || $(RMDIR) $(DESTDIR)$(pkgdatadir)

clean:
	$(foreach _lmf,$(LISTOF_LTXMFILE), $(shell cd $(dir $(_lmf)) && $(LATEXMK) $(LATEXMK_OPTIONS) -c > /dev/null ;) )

distclean:
	$(foreach _lmf,$(LISTOF_LTXMFILE), $(shell cd $(dir $(_lmf)) && $(LATEXMK) $(LATEXMK_OPTIONS) -C > /dev/null ;) )
	$(RM_R) _SurferLocalization

maintainer-clean: distclean
	$(RM) $(LISTOF_LTXPNG)
	$(RM) $(LISTOF_PNGICON)

jarclean:
	cd $(JARDIR) && $(RM) $(addsuffix .jar, SurferData $(addprefix SurferLocalization_,$(LISTOF_TLLC)))

%.pdf: %.tex
	$(LATEXMK) $(LATEXMK_OPTIONS) -cd -pdflatex="xelatex --shell-escape" -pdf $<

%.png: %.jsurf
	$(JSURF) --quality 3 --size 600 --output $@ $<

%_icon.png: %.jsurf
	$(JSURF) --quality 3 --size 120 --output $@ $<

JSURF ?= /usr/bin/jsurf-alggeo

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

default-info:
	@echo LISTOF_TLLC: $(LISTOF_TLLC)

# eos
