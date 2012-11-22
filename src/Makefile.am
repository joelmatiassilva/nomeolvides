## Process this file with automake to produce Makefile.in

## Created by Anjuta


uidir = $(pkgdatadir)/ui
ui_DATA = nomeolvides.ui


AM_CPPFLAGS = \
	-DPACKAGE_LOCALE_DIR=\""$(localedir)"\" \
	-DPACKAGE_SRC_DIR=\""$(srcdir)"\" \
	-DPACKAGE_DATA_DIR=\""$(pkgdatadir)"\" \
	$(NOMEOLVIDES_CFLAGS)

AM_CFLAGS =\
	 -Wall\
	 -g

bin_PROGRAMS = nomeolvides

nomeolvides_SOURCES = \
	config.vapi hecho.vala main.vala nomeolvides-app.vala nomeolvides-window.vala panel.vala nomeolvides-add-dialog.vala

nomeolvides_VALAFLAGS =  \
	--pkg gtk+-3.0

nomeolvides_LDFLAGS = \
	-Wl,--export-dynamic

nomeolvides_LDADD = $(NOMEOLVIDES_LIBS)


EXTRA_DIST = $(ui_DATA)

# Remove ui directory on uninstall
uninstall-local:
	-rm -r $(uidir)
	-rm -r $(pkgdatadir)

