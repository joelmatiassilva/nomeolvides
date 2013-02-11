## Process this file with automake to produce Makefile.in

## Created by Anjuta


uidir = $(pkgdatadir)/ui


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
	config.vapi \
	nomeolvides-window.vala \
	nomeolvides-main-toolbar.vala \
	nomeolvides-text-view-hecho.vala \
	nomeolvides-hecho.vala \
	nomeolvides-main.vala \
	nomeolvides-panel.vala \
	nomeolvides-lista-hechos.vala \
	nomeolvides-view-hechos.vala \
	nomeolvides-liststore-hechos.vala \
	nomeolvides-dialogo-hecho.vala \
	nomeolvides-view-anios.vala \
	nomeolvides-openfile-dialog.vala \
	nomeolvides-vista-hecho.vala \
	nomeolvides-savefile-dialog.vala \
	nomeolvides-borrar-hecho-dialogo.vala \
	nomeolvides-hechos-fuentes.vala \
	nomeolvides-fuente.vala \
	nomeolvides-liststore-fuentes.vala \
	nomeolvides-treeview-fuentes.vala \
	nomeolvides-fuentes-dialog.vala \
	nomeolvides-add-hecho-dialog.vala \
	nomeolvides-app.vala \
	nomeolvides-edit-hecho-dialog.vala

nomeolvides_VALAFLAGS = \
	--pkg gee-1.0 \
	--pkg gtk+-3.0

nomeolvides_LDFLAGS = \
	-Wl,--export-dynamic

nomeolvides_LDADD = $(NOMEOLVIDES_LIBS)


EXTRA_DIST = $(ui_DATA)

# Remove ui directory on uninstall
uninstall-local:
	-rm -r $(uidir)
	-rm -r $(pkgdatadir)


data_DATA =
