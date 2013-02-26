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
	private ToolButton aniadir_fuente_button;
	private ToolButton editar_fuente_button;
	private ToolButton borrar_fuente_button;
	public bool cambios { get; private set; }
	public Button boton_aniadir;
		
	public FuentesDialog (Nomeolvides.Window ventana, ListStoreFuentes liststore_fuente) {
		this.set_title ("Fuentes predeterminadas de hechos históricos");
		this.set_modal ( true );
		this.set_transient_for ( ventana as Gtk.Window );

		Toolbar toolbar = new Toolbar ();
		this.aniadir_fuente_button = new ToolButton.from_stock ( Stock.ADD );
		this.editar_fuente_button = new ToolButton.from_stock ( Stock.EDIT );
		this.borrar_fuente_button = new ToolButton.from_stock ( Stock.DELETE );
		aniadir_fuente_button.is_important = true;
		editar_fuente_button.is_important = true;
		borrar_fuente_button.is_important = true;
		editar_fuente_button.set_visible_horizontal ( false );
		borrar_fuente_button.set_visible_horizontal ( false );
		SeparatorToolItem separador = new SeparatorToolItem ();
		separador.set_expand ( true );
		separador.draw = false;

		borrar_fuente_button.clicked.connect ( borrar_fuente_dialog );
		aniadir_fuente_button.clicked.connect ( add_fuente_dialog );

		toolbar.add ( aniadir_fuente_button );
		toolbar.add ( separador );
		toolbar.add ( editar_fuente_button );
		toolbar.add ( borrar_fuente_button );
		
		this.add_button ( Stock.CANCEL , ResponseType.CANCEL );
		this.add_button ( Stock.OK , ResponseType.OK );
		this.response.connect(on_response);

		this.boton_aniadir = new Button.with_label ( "Añadir" );

		this.cambios = false;
		this.fuentes_view = new TreeViewFuentes ();
		this.fuentes_view.set_model ( liststore_fuente );
		this.fuentes_view.cursor_changed.connect ( elegir_fuente );
 
		Gtk.Container contenido =  this.get_content_area () as Box;
		contenido.add ( toolbar );
		contenido.add ( this.fuentes_view );
	}

	private void on_response (Dialog source, int response_id)
	{
		 switch (response_id)
		{
    		case ResponseType.OK:
        		this.hide ();
       			break;
    		case ResponseType.CANCEL:
        		this.destroy ();
        		break; 
        }
    }

	private void add_fuente_dialog () {
		ListStoreFuentes liststore;
		
		var add_dialog = new AddFuenteDialog ( );
		add_dialog.show_all ();

		if (add_dialog.run() == ResponseType.APPLY) {
			liststore = this.fuentes_view.get_model () as ListStoreFuentes;
			liststore.agregar_fuente (add_dialog.respuesta);
			this.cambios = true;
		}
		
		add_dialog.destroy ();
	}

	private void borrar_fuente_dialog () {	
		var borrar_dialog = new BorrarFuenteDialogo ( this.fuentes_view.get_fuente_cursor () );
		borrar_dialog.show_all ();

		if (borrar_dialog.run() == ResponseType.APPLY) {
			this.fuentes_view.eliminar_fuente ( this.fuentes_view.get_fuente_cursor () );
		}
		borrar_dialog.destroy ();

		this.cambios = true;
	}

	private void set_buttons_visible ( bool cambiar ) {
		this.editar_fuente_button.set_visible_horizontal ( cambiar );
		this.borrar_fuente_button.set_visible_horizontal ( cambiar );
	}

	private void elegir_fuente () {
		if(this.fuentes_view.get_fuente_cursor () != null) {
			this.set_buttons_visible ( true );
		} else {
			this.set_buttons_visible ( false );		
		}
	}
}
