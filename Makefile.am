## Process this file with automake to produce Makefile.in
## Created by Anjuta

SUBDIRS = src 
PREFIX=/usr

nomeolvidesdocdir = ${PREFIX}/doc/nomeolvides
nomeolvidesdoc_DATA = \
	README\
	COPYING\
	AUTHORS\
	ChangeLog\
	INSTALL\
	NEWS


EXTRA_DIST = $(nomeolvidesdoc_DATA)


# Remove doc directory on uninstall
uninstall-local:
	-rm -r $(nomeolvidesdocdir)


AM_VALAFLAGS = --pkg \
	gee-1.0 

nomeolvidesdesktofiledir = ${PREFIX}/share/applications
nomeolvidesdesktofile_DATA = data/nomeolvides.desktop

nomeolvidesicondir = ${PREFIX}/share/pixmaps/
nomeolvidesicon_DATA = data/nomeolvides.svg
