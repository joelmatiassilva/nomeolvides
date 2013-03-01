/* -*- Mode: vala; indent-tabs-mode: t; c-basic-offset: 4; tab-width: 4 -*-  */
/* nomeolvides
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

using Gtk;
using Gee;
using Nomeolvides;

public class Nomeolvides.DialogoHecho : Dialog
{
	protected Entry nombre_entry;
	protected TextView descripcion_textview;
	protected ListStoreFuentes lista_fuentes;
	protected ComboBox combo_fuentes;
	protected SelectorFecha fecha;
	protected Entry fuente_entry;
	public Hecho respuesta { get; protected set; }
	
	public DialogoHecho (Nomeolvides.Window ventana, ListStoreFuentes fuentes_liststore )
	{
		this.resizable = true;
		this.modal = true;
		this.set_default_size (600,400);
		this.set_size_request (400,250);
		this.set_transient_for ( ventana as Window );
		
		var nombre_label = new Label.with_mnemonic ("Nombre: ");
		var fecha_label = new Label.with_mnemonic ("Fecha: ");
		var archivo_label = new Label.with_mnemonic ("Guardar en: ");
		var fuente_label = new Label.with_mnemonic ("Fuente: ");
		this.add_button (Stock.CANCEL , ResponseType.CLOSE);
		
		this.nombre_entry = new Entry ();
		this.fuente_entry = new Entry ();
		
		this.combo_fuentes = new ComboBox ();
		this.fecha = new SelectorFecha ();

		this.lista_fuentes = fuentes_liststore;

		var descripcion_frame = new Frame( "Descripcion" );
		descripcion_frame.set_shadow_type(ShadowType.ETCHED_IN);
	
		this.descripcion_textview = new TextView ();
		this.descripcion_textview.set_wrap_mode (WrapMode.WORD);

		descripcion_frame.add (this.descripcion_textview);

		this.set_combo_box ();
		
		Box box_hecho = new Box (Orientation.HORIZONTAL, 0);
		Box box_labels = new Box (Orientation.VERTICAL, 0);
		Box box_widgets = new Box (Orientation.VERTICAL, 0);

		box_labels.pack_start (nombre_label, false, false, 5);		
		box_labels.pack_start (fecha_label, false, false, 5);
		box_labels.pack_start (archivo_label, false, false, 5);
		box_labels.pack_start (fuente_label, false, false, 5);
		box_widgets.pack_start (nombre_entry, false, false, 0);
		box_widgets.pack_start (fecha, false, false, 0);
		box_widgets.pack_start (combo_fuentes, false, false, 0);
		box_widgets.pack_start (fuente_entry, false, false, 0);
		
		box_hecho.pack_start (box_labels, true, false, 0);
		box_hecho.pack_start (box_widgets, true, true, 0);
	
		
		var contenido = this.get_content_area() as Box;

		contenido.pack_start(box_hecho, false, false, 0);
		contenido.pack_start(descripcion_frame, true, true, 0);
		
		this.show_all ();
	}

	protected void crear_respuesta() {
		if(this.nombre_entry.get_text_length () > 0)
		{
			this.respuesta  = new Hecho (this.nombre_entry.get_text (), 
			            				 this.descripcion_textview.buffer.text,
										 this.fecha.get_anio (),
			                             this.fecha.get_mes (),
			                             this.fecha.get_dia (),
		  								 this.get_archivo_elegido (),
			                             this.fuente_entry.get_text ());
		}
	}

	protected void set_combo_box () {
		CellRendererText renderer = new CellRendererText ();
		this.combo_fuentes.pack_start (renderer, true);
		this.combo_fuentes.add_attribute (renderer, "text", 0);
		this.combo_fuentes.active = 0;
		this.combo_fuentes.set_model ( this.lista_fuentes );
	}

	protected string get_archivo_elegido () {		
		TreeIter iter;
		Value archivo;
		Value direccion;
		
		this.combo_fuentes.get_active_iter( out iter );
		this.lista_fuentes.get_value (iter, 1, out archivo);
		this.lista_fuentes.get_value (iter, 2, out direccion);

		return (string) direccion + (string) archivo ;
	}

}
