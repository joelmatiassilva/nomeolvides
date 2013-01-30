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

	private void create_window ()
	{
		window = new Nomeolvides.Window(this);

		this.create_app_menu ();

		this.window.cargar_fuentes_predefinidas ( this.fuentes );

		window.show_visible();
	}

	public override void activate ()
	{
		create_window();

		app.window.show();
	}

	public void create_app_menu () {
		var salir = new GLib.SimpleAction ("salir", null);
		salir.activate.connect (() => { window.destroy (); });
		this.add_action (salir);

		var acerca_de = new GLib.SimpleAction ("acerca_de", null);
		acerca_de.activate.connect (() => { create_about_dialog (); });
		this.add_action (acerca_de);

		var config_fuentes = new GLib.SimpleAction ("config_fuentes_hechos", null);
		config_fuentes.activate.connect (() => { config_fuentes_hechos (); });
		this.add_action (config_fuentes);

		var builder = new Builder ();
		try {
  			builder.add_from_file ("src/nomeolvides-app-menu.ui");
  			set_app_menu ((MenuModel)builder.get_object ("app-menu"));
		} catch {
  			warning ("Error al cargar el archivo del Aplication Menu");
		}
	}

	public void create_about_dialog () {
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

	private void config_fuentes_hechos () {
		this.fuentes.show_all ();		
	}

	public App ()
	{
		app = this;
		this.fuentes = new HechosFuentes ();
	}
}
