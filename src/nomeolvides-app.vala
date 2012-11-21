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

/*	public Main ()
	{

		try 
		{
			var builder = new Builder ();
			builder.add_from_file (UI_FILE);
			builder.connect_signals (this);

			var window = builder.get_object ("window") as Window;
			/* ANJUTA: Widgets initialization for nomeolvides.ui - DO NOT REMOVE *//*
			window.show_all ();
		} 
		catch (Error e) {
			stderr.printf ("Could not load UI: %s\n", e.message);
		} 

	}

	*/

	private void create_window ()
	{
		var action = new GLib.SimpleAction ("quit",null);
		action.activate.connect (() => { window.destroy(); });
		this.add_action (action);

		window = new Nomeolvides.Window (this);
		window.set_application (this);
		window.set_title ("Nomeolvides");
		window.set_default_size (500,250);
		window.hide_titlebar_when_maximized = true;

		var toolbar = new Toolbar();
		toolbar.get_style_context().add_class(STYLE_CLASS_PRIMARY_TOOLBAR);

		var add_button = new ToolButton.from_stock (Stock.ADD);
		add_button.is_important = true;
		//add_button.clicked.connect (on_add_clicked);

		toolbar.add (add_button);
		

		var button = new Button.with_label ("Clickeame gil!");
		button.clicked.connect( () => { button.label = "Maximizame!"; });

		Box grid = new Box (Orientation.VERTICAL, 0);
		grid.pack_start (toolbar, false, true, 0);
		grid.pack_start (button, false, false, 0);
			
		window.add (grid);

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

	public App ()
	{
		app = this;
	}
}

