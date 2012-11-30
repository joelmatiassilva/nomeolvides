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
 * 
 * You should have received a copy of the GNU General Public License along
 * with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

using Gtk;
using Nomeolvides;

public class Window : Gtk.ApplicationWindow
{
	public Box box { get; private set; }
	private Main_toolbar toolbar;
	private TextViewHecho hechos_text_view;
	
	public Window (Gtk.Application app)
	{   

		Object (application: app);
		this.set_application (app);
		this.set_title ("Nomeolvides - ");
		this.set_position (WindowPosition.CENTER);
		this.set_default_size (500,250);

		this.hide_titlebar_when_maximized = true;

		box = new Box(Orientation.VERTICAL,0);
		this.add(box);
		
		this.toolbar = new Main_toolbar();
		botones_toolbar();
		this.hechos_text_view = new TextViewHecho();

		var scroll = new ScrolledWindow (null, null);
        scroll.set_policy (PolicyType.AUTOMATIC, PolicyType.AUTOMATIC);
        scroll.add (this.hechos_text_view);

		this.box.pack_start(toolbar, false, true, 0);
		this.box.pack_start(scroll, true, true, 0);
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
			this.hechos_text_view.agregarHecho(add_dialog.respuesta);
			add_dialog.destroy();
		}		
	}

	public void open_file ()
	{
		string todo;
		string[] lineas;
		Hecho nuevoHecho;
		int i;
		
		FileUtils.get_contents ("src/hechos.json", out todo);
		lineas = todo.split_set ("\n");
		for (i=0; i < (lineas.length - 1); i++) {
        	nuevoHecho = new Hecho.json(lineas[i]);
			this.hechos_text_view.agregarHecho(nuevoHecho);
		}
	}
}
