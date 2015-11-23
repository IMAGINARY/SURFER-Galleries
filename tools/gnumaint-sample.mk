-include $(HOME)/etc/gnumaint.mk
ifneq (,$(wildcard /etc/debian_version))
JSURF = /usr/bin/jsurf-alggeo
else ifneq (,$(wildcard /etc/redhat_version))
JSURF = /usr/bin/jsurf-alggeo
else
JSURF ?= /usr/local/bin/jsurf
endif
JARDIR ?= $(TMPDIR)/mk/$(PACKAGE_NAME)
