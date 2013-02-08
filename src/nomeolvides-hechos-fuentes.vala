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
using Nomeolvides;

public class Nomeolvides.HechosFuentes : Gtk.Dialog {
	public TreeViewFuentes fuentes_view { get; private set; }
		
	public HechosFuentes (Nomeolvides.Window ventana) {
		this.set_title ("Fuentes predeterminadas de hechos históricos");
		this.set_modal ( true );
		this.set_transient_for ( ventana as Gtk.Window );
		
		this.add_button (Stock.CLOSE , ResponseType.CLOSE);
		this.response.connect(on_response);
		
		this.fuentes_view = new TreeViewFuentes ();		

		Gtk.Container contenido =  this.get_content_area () as Box;
		contenido.add ( this.fuentes_view );
	}

	private void on_response (Dialog source, int response_id)
	{
		this.hide ();
    }
}
