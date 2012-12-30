/* -*- Mode: vala; indent-tabs-mode: t; c-basic-offset: 4; tab-width: 4 -*-  */
/* nomeolvides
 *
 * Copyright (C) 2012 Fernando Fernandez <fernando@softwareperonista.com.ar>
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
 *   bullit - 39 escalones - silent love (japonesa) 
 * You should have received a copy of the GNU General Public License along
 * with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

using Gtk;
using Nomeolvides;

public class Nomeolvides.Window : Gtk.ApplicationWindow
{
	public Box main_box { get; private set; }
	public Box list_view_box { get; private set; }
	private Main_toolbar toolbar;
	private ViewHechos hechos_view;
	
	public Window (Gtk.Application app)
	{   
		Object (application: app);
		this.set_application (app);
		this.set_title ("Nomeolvides - ");
		this.set_position (WindowPosition.CENTER);
		this.set_default_size (800,500);
		this.set_size_request (500,350);
		this.hide_titlebar_when_maximized = true;

		main_box = new Box (Orientation.VERTICAL,0);
		list_view_box = new Box (Orientation.HORIZONTAL,0);
		this.add (main_box);
		
		this.toolbar = new Nomeolvides.Main_toolbar ();
		this.botones_toolbar ();

		TreeViewSelector treeview_provisorio = new TreeViewSelector ();
		this.hechos_view = new ViewHechos ();

		Separator separador = new Separator(Orientation.VERTICAL);

		list_view_box.pack_start (treeview_provisorio, false, false, 0);
		list_view_box.pack_start (separador, false, false, 0);
		list_view_box.pack_start (this.hechos_view, true, true, 0);

		this.main_box.pack_start (toolbar, false, true, 0);		
		this.main_box.pack_start (list_view_box, true, true, 0);
	}

	private void botones_toolbar ()
	{
		var add_button = new ToolButton.from_stock(Stock.ADD);
		add_button.is_important = true;
		add_button.clicked.connect(this.add_hecho);

		this.toolbar.add(add_button);

		var open_button = new ToolButton.from_stock(Stock.OPEN);
		open_button.is_important = true;
		open_button.clicked.connect(this.open_file);

		this.toolbar.add(open_button);
	}

	public void add_hecho ()
	{
		var add_dialog = new Add_dialog();
		add_dialog.show();

		if (add_dialog.run() == ResponseType.APPLY)
		{
			this.hechos_view.agregarHecho(add_dialog.respuesta);
			add_dialog.destroy();
		}		
	}

	public void open_file ()
	{
		string todo;
		string[] lineas;
		Hecho nuevoHecho;
		int i;

		try {
			FileUtils.get_contents ("src/hechos.json", out todo);
		}  catch (Error e) {
			error (e.message);
		}
		lineas = todo.split_set ("\n");
		for (i=0; i < (lineas.length - 1); i++) {
        	nuevoHecho = new Hecho.json(lineas[i]);
			this.hechos_view.agregarHecho(nuevoHecho);
		}
	}
}
