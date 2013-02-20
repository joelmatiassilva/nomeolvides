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
	public Hecho respuesta { get; protected set; }
	
	public DialogoHecho (Nomeolvides.Window ventana, HechosFuentes fuentes )
	{
		resizable = false;
		modal = true;
		this.set_transient_for ( ventana as Window );
		
		var nombre_label = new Label.with_mnemonic ("Nombre: ");
		var descripcion_label = new Label.with_mnemonic ("Descripcion: ");
		var fecha_label = new Label.with_mnemonic ("Fecha: ");
		var archivo_label = new Label.with_mnemonic ("Guardar en: ");
		this.add_button (Stock.CANCEL , ResponseType.CLOSE);
		
		this.nombre_entry = new Entry ();
		
		this.combo_fuentes = new ComboBox ();
		this.fecha = new SelectorFecha ();

		this.lista_fuentes = fuentes.fuentes_liststore;

		var descripcion_frame = new Frame(null);
		descripcion_frame.set_shadow_type(ShadowType.ETCHED_IN);
	
		this.descripcion_textview = new TextView ();
		this.descripcion_textview.set_wrap_mode (WrapMode.WORD);

		descripcion_frame.add(this.descripcion_textview);

		this.set_combo_box ();

		var grid = new Grid ();
		
		grid.attach (nombre_label, 0, 0, 1, 1);
	    grid.attach (nombre_entry, 1, 0, 1, 1);
		grid.attach (fecha_label, 0, 1, 1, 1);
		grid.attach (fecha, 1, 1, 1, 1);
		grid.attach (archivo_label, 0 , 2 , 1 ,1);
		grid.attach (combo_fuentes, 1 , 2 , 1 ,1);
		grid.attach (descripcion_label, 0, 3, 1, 1);
		grid.attach (descripcion_frame, 1 , 3 , 1 ,1);
		
		
		var contenido = this.get_content_area() as Box;

		contenido.pack_start(grid, false, false, 0);
		
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
		  								 this.get_archivo_elegido());
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
