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
using Nomeolvides;

public class Nomeolvides.DialogoHecho : Dialog
{
	protected Entry nombre_entry;
	protected Entry descripcion_entry;
	protected Entry anio_entry;
	protected Entry mes_entry;
	protected Entry dia_entry;
	public Hecho respuesta { get; protected set; }
	
	public DialogoHecho ()
	{
		this.resizable = false;
		this.modal = true;		
		
		var nombre_label = new Label.with_mnemonic ("Nombre: ");
		var descripcion_label = new Label.with_mnemonic ("Descripcion: ");
		var separador_fecha_label_1 = new Label.with_mnemonic (" de ");
		var separador_fecha_label_2 = new Label.with_mnemonic (" de ");
		var fecha_label = new Label.with_mnemonic ("Fecha: ");
		this.add_button (Stock.CANCEL , ResponseType.CLOSE);
		
		this.nombre_entry = new Entry ();
		this.descripcion_entry = new Entry ();
		this.anio_entry = new Entry ();
		this.mes_entry = new Entry ();
		this.dia_entry = new Entry ();

		var box = new Box(Orientation.HORIZONTAL,0);

		dia_entry.set_max_length (2);
		dia_entry.set_width_chars (2);
		mes_entry.set_max_length (2);
		mes_entry.set_width_chars (2);
		anio_entry.set_max_length (4);
		anio_entry.set_width_chars (4);

		box.pack_start (this.dia_entry,false,false,1);
		box.pack_start (separador_fecha_label_1,false,false,1);
		box.pack_start (this.mes_entry,false,false,1);
		box.pack_start (separador_fecha_label_2,false,false,1);
		box.pack_start (this.anio_entry,false,false,1);

		var grid = new Grid ();
		grid.attach (nombre_label, 0, 0, 1, 1);
	    grid.attach (nombre_entry, 1, 0, 1, 1);
		grid.attach (descripcion_label, 0, 1, 1, 1);
		grid.attach (descripcion_entry, 1, 1, 1, 1);
		grid.attach (fecha_label, 0, 2, 1, 1);
		grid.attach (box, 1 , 2 , 1 ,1);
		
		var contenido = this.get_content_area() as Box;
		contenido.pack_start(grid, false, false, 0);
		
		this.show_all ();
	}
}
