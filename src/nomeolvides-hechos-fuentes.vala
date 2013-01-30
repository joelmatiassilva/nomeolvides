/* -*- Mode: vala; indent-tabs-mode: t; c-basic-offset: 4; tab-width: 4 -*-  */
/* nomeolvides
 *
 * Copyright (C) 2013 Andres Fernandez <andres@softwareperonista.com.ar>
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
using Gee;
using Nomeolvides;

public class Nomeolvides.HechosFuentes : Gtk.Dialog {
	private ListStore fuentes_store;
	private TreeView fuentes_view;
	private TreeIter fuentes_iter;
	public ArrayList<string> archivos { get; private set; }
		
	public HechosFuentes () {
		this.set_title ("Fuentes predeterminadas de hechos históricos");

		this.add_button (Stock.CLOSE , ResponseType.CLOSE);
		this.response.connect(on_response);
		this.archivos = new ArrayList<string> ();
		
		this.fuentes_view = new TreeView ();
		this.fuentes_store = new ListStore ( 3, typeof(string), typeof(string), typeof(string) );

		this.agregar_fuente ("Inicial","hechos.json","src/");
		
		this.fuentes_view.insert_column_with_attributes ( -1, "Nombre", new CellRendererText(), "text", 0 );
		this.fuentes_view.insert_column_with_attributes ( -1, "Nombre de Archivo", new CellRendererText(), "text", 1 );
		this.fuentes_view.insert_column_with_attributes ( -1, "Dirección", new CellRendererText(), "text", 2 );

		this.fuentes_view.set_model ( fuentes_store );

		Gtk.Container contenido =  this.get_content_area ();
		contenido.add ( this.fuentes_view );
	}

	private void on_response (Dialog source, int response_id)
	{
		this.hide ();
    }

	public void agregar_fuente ( string nombre, string archivo, string path ) {
		this.fuentes_store.append ( out this.fuentes_iter );
		this.fuentes_store.set ( this.fuentes_iter, 0,nombre, 1,archivo, 2,path );
		this.archivos.add ((string) path + (string) archivo);
	}
}
