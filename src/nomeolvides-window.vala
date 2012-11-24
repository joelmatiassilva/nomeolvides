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

public class Nomeolvides.Window : Gtk.ApplicationWindow
{
	public Box box { get; private set; }
	private Main_toolbar toolbar;
	private TextViewHecho hechos_text_view;
	
	public Window (Gtk.Application app )
	{   
		Object (application: app);
		this.set_application (app);
		this.set_title ("No me olvides - ");
		this.set_position (WindowPosition.CENTER);
		this.set_default_size (500,250);
		this.hide_titlebar_when_maximized = true;

		box = new Box (Orientation.VERTICAL,0);
		this.add (box);
		
		this.toolbar = new Nomeolvides.Main_toolbar ();
		botones_toolbar ();
		this.hechos_text_view = new TextViewHecho ();

		this.box.pack_start (toolbar, false, true, 0);
		this.box.pack_start (this.hechos_text_view, true, true, 0);
	}

	private void botones_toolbar()
	{
		var add_button = new ToolButton.from_stock (Stock.ADD);
		add_button.is_important = true;
		add_button.clicked.connect (this.add_hecho);

		this.toolbar.add (add_button);
	}

	public void add_hecho ()
	{
		var add_dialog = new Add_dialog();
		add_dialog.show();

		if (add_dialog.run() == ResponseType.APPLY)
		{
			this.hechos_text_view.agregarHecho (add_dialog.respuesta);
			add_dialog.destroy();
		}		
	}
}