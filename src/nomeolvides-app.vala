/* -*- Mode: C; indent-tabs-mode: t; c-basic-offset: 4; tab-width: 4 -*-  */
/* Nomeolvides
 * 
 * Copyright (C) 2012 Andres Fernandez <andres@softwareperonista.com.ar>
 * 
 * nomeolvides is free software: you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * nomeolvides is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 * See the GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License along
 * with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

using GLib;
using Gtk;
using Nomeolvides;

public class Nomeolvides.App : Gtk.Application 
{
	public static App app;
	public Nomeolvides.Window window;
	public HechosFuentes fuentes;
	public GLib.Menu application_menu;

	private const GLib.ActionEntry[] actions_app_menu = {
		{ "create-about-dialog", create_about_dialog },
		{ "exportar", exportar },
		{ "window-destroy", salir_app },
		{ "config-fuentes-dialog", config_fuentes_dialog }
	};

	private void create_window ()
	{
		this.window = new Nomeolvides.Window(this);

		this.create_app_menu ( );

		window.show_visible();
	}

	public override void activate ()
	{
		create_window();
		this.fuentes = new HechosFuentes ( );
		this.window.cargar_fuentes_predefinidas ( this.fuentes );
		app.window.show();
	}

	public void create_app_menu () {
		this.application_menu = new GLib.Menu ();
		
		this.application_menu.append ( "Configurar Fuentes", "app.config-fuentes-dialog" );
		this.application_menu.append ( "Exportar", "app.exportar" );
		this.application_menu.append ( "Acerca de Nomeolvides", "app.create-about-dialog" );
		this.application_menu.append ( "Salir", "app.window-destroy" );
		
		this.set_app_menu ( application_menu );		
		this.add_action_entries (actions_app_menu, this);
	}

	private void create_about_dialog () {
		string[] authors = {
  			"Andres Fernandez <andres@softwareperonista.com.ar>",
  			"Fernando Fernandez <fernando@softwareperonista.com.ar>"
		};
		Gtk.show_about_dialog (this.window,
			   "authors", authors,
			   "program-name", "Nomeolvides",
			   "title", "Acerca de Nomeolvides",
			   "comments", "Gestor de efemérides históricas",
			   "copyright", "Copyright 2012 Fernando Fernandez y Andres Fernandez",
			   "license-type", Gtk.License.GPL_3_0,
			   "logo-icon-name", "nomeolvides",
			   "version", Config.VERSION,
			   "website", "https://github.com/softwareperonista/nomeolvides",
			   "wrap-license", true);	
	}

	private void salir_app () {
		this.window.destroy ();
	}

	private void config_fuentes_dialog () {
		
		var fuente_dialogo = new FuentesDialog ( this.window, this.fuentes.fuentes_liststore );
		fuente_dialogo.show_all ();

		if ( fuente_dialogo.run () == ResponseType.OK ) {
			if (fuente_dialogo.nuevas_fuentes == true) {
				this.fuentes.actualizar_fuentes_liststore ( fuente_dialogo.fuentes_view.get_model () as ListStoreFuentes);
				this.window.cargar_fuentes_predefinidas ( this.fuentes );
			}
		}
		fuente_dialogo.destroy ();
	}

	private void exportar () {
		this.window.save_as_file_dialog ();
	}

	public App ()
	{
		app = this;

		var directorio_configuracion = File.new_for_path(GLib.Environment.get_user_config_dir () + "/nomeolvides/");

		if (!directorio_configuracion.query_exists ()) {
			directorio_configuracion.make_directory ();
		}
		
	}
}
