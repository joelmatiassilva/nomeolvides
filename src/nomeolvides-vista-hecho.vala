/* -*- Mode: C; indent-tabs-mode: t; c-basic-offset: 4; tab-width: 4 -*-  */
/* Nomeolvides
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
 * 
 * You should have received a copy of the GNU General Public License along
 * with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

using Gtk;
using Nomeolvides;

public class Nomeolvides.VistaHecho : Box {
	private Label label_nombre;
	private Label label_fecha;
	private TextView text_descripcion;
	
	public VistaHecho () {
		this.set_orientation ( Orientation.VERTICAL );
		this.set_spacing ( 10 );
		this.set_homogeneous ( false );
		
		this.label_nombre = new Label.with_mnemonic ("");
		this.label_fecha = new Label.with_mnemonic ("");
		this.text_descripcion = new TextView ();

		this.label_nombre.set_width_chars ( 30 );
		this.text_descripcion.set_wrap_mode (WrapMode.WORD);
		this.label_fecha.set_width_chars ( 30 );
		
		this.label_fecha.set_alignment ( 0, 0 );

		this.pack_start ( this.label_nombre, false, false, 0 );
		this.pack_start ( this.label_fecha, false, false, 0 );
		this.pack_start ( this.text_descripcion, false, false, 0 );
	}

	public bool set_datos_hecho ( Hecho a_mostrar ) {
		bool retorno = false;

		if ( a_mostrar != null ) {
			this.label_nombre.set_markup ("<span font_size=\"x-large\" font_weight=\"heavy\">"+ a_mostrar.nombre +"</span>");
			this.label_fecha.set_markup ("<span font_style=\"italic\">"+ a_mostrar.fecha_to_string () +"</span>");
			this.text_descripcion.buffer.text = a_mostrar.descripcion;

			retorno = true;
		}

		return retorno;
	}
}