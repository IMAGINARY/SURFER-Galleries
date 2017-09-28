## GNUmakefile -- GNU Makefile -- GIT
-include Makefile
ifeq ($(RELEASEDIR),)
	RELEASEDIR = /forge/surfer/galleries/releases/
endif
####include $(HOME)/etc/gitmaint.mk
## eos

## *** simple sample of (HOME)/etc/gitmaint.mk *** ##
## IMPORTANT: NEUTRALIZED VERSION
## to activte: uncomment
##~/etc/gitmaint.mk

GITSMITHEMAIL := 'smith@imaginary.org'
GITSMITHNAME := 'Smith Le Forgeron'
GITSMITH_KEYID := 'NNNNNNNN'
GITSMITH_KEYCOMMENT := 'key registered at pgp.mit.edu'

gm__release_date := $(shell date -u -u +%Y-%m-%d)

gitmaintainer-release-tag:
	#git tag v$(PACKAGE_VERSION)

gitmaintainer-release-changelog:
	#sed -i -e 's/^## \[Unreleased\]\[unreleased\]/## [Unreleased][unreleased]\n\n## [$(PACKAGE_VERSION)][$(gm__release_date)]/' CHANGELOG.md

gitmaintainer-release: gitmaintainer-release-changelog gitmaintainer-release-tag
	@

ifeq ($(PACKAGE_NAME),surfer-alggeo-galleries)
JSURF ?= /usr/bin/jsurf-alggeo
JARDIR ?= $(TMPDIR)/mk/$(PACKAGE_NAME)
endif

##
## eos
