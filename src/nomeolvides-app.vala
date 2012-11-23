/* -*- Mode: C; indent-tabs-mode: t; c-basic-offset: 4; tab-width: 4 -*-  */
/*
 * main.c
 * Copyright (C) 2012 Lonko Soft <lonko@softwareperonista.com.ar>
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

public class Nomeolvides.App : Gtk.Application 
{

	/* 
	 * Uncomment this line when you are done testing and building a tarball
	 * or installing
	 */
	//const string UI_FILE = Config.PACKAGE_DATA_DIR + "/" + "nomeolvides.ui";
	const string UI_FILE = "src/nomeolvides.ui";

	/* ANJUTA: Widgets declaration for nomeolvides.ui - DO NOT REMOVE */

	public static App app;
	public Nomeolvides.Window window;
	private TextView hechos_text_view;

	private void create_window ()
	{
		var action = new GLib.SimpleAction ("quit",null);
		action.activate.connect (() => { window.destroy(); });
		this.add_action (action);

		window = new Nomeolvides.Window (this);
		window.set_application (this);
		window.set_title ("No me olvides - ");
		window.set_default_size (500,250);
		window.hide_titlebar_when_maximized = true;

		var toolbar = new Toolbar ();
		toolbar.get_style_context().add_class (STYLE_CLASS_PRIMARY_TOOLBAR);

		var add_button = new ToolButton.from_stock (Stock.ADD);
		add_button.is_important = true;
		add_button.clicked.connect (add_hecho);

		toolbar.add (add_button);

		this.hechos_text_view = new TextView ();
		this.hechos_text_view.editable = false;
		this.hechos_text_view.cursor_visible = false;

		var vbox = new Box (Orientation.VERTICAL,0);
		vbox.pack_start (toolbar, false, true, 0);
		vbox.pack_start (this.hechos_text_view, true, true, 0);

		window.add (vbox);

		window.show_all();
	}

	public override void activate ()
	{
		create_window ();

		app.window.show();
	}

	[CCode (instance_pos = -1)]
	public void on_destroy (Widget window) 
	{
		Gtk.main_quit();
	}

	public void add_hecho ()
	{
		var add_dialog = new Add_dialog();
		add_dialog.show();

		if (add_dialog.run() == ResponseType.APPLY)
		{
			this.hechos_text_view.buffer.text += add_dialog.respuesta.nombre + ": " + add_dialog.respuesta.descripcion + "\n";
			add_dialog.destroy();
		}		
	}

	public App ()
	{
		app = this;
	}
}
