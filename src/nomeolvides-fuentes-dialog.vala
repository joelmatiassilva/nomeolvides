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

public class Nomeolvides.FuentesDialog : Gtk.Dialog {
	public TreeViewFuentes fuentes_view { get; private set; }
	public bool nuevas_fuentes { get; private set; }
		
	public FuentesDialog (Nomeolvides.Window ventana, ListStoreFuentes liststore_fuente) {
		this.set_title ("Fuentes predeterminadas de hechos históricos");
		this.set_modal ( true );
		this.set_transient_for ( ventana as Gtk.Window );
		
		this.add_button ( Stock.CLOSE , ResponseType.CLOSE );
		this.add_button ( Stock.ADD , ResponseType.APPLY );
		this.response.connect(on_response);

		this.nuevas_fuentes = false;
		this.fuentes_view = new TreeViewFuentes ();
		this.fuentes_view.set_model ( liststore_fuente );

		Gtk.Container contenido =  this.get_content_area () as Box;
		contenido.add ( this.fuentes_view );
	}

	private void on_response (Dialog source, int response_id)
	{
		 switch (response_id)
		{
    		case ResponseType.APPLY:
        		add_fuente_dialog();
       			break;
    		case ResponseType.CLOSE:
        		this.hide ();
        		break; 
        }
    }

	private void add_fuente_dialog() {
		ListStoreFuentes liststore;
		
		var add_dialog = new AddFuenteDialog (this);
		add_dialog.show_all ();

		if (add_dialog.run() == ResponseType.APPLY) {
			liststore = this.fuentes_view.get_model () as ListStoreFuentes;
			liststore.agregar_fuente (add_dialog.respuesta);
			this.nuevas_fuentes = true;
			add_dialog.destroy ();
		} else if (add_dialog.run() == ResponseType.APPLY) { 
			liststore = this.fuentes_view.get_model () as ListStoreFuentes;
			liststore.agregar_fuente (add_dialog.respuesta);
			this.nuevas_fuentes = true;
			add_dialog.destroy ();
		}
	}
}