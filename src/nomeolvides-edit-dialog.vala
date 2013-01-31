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

public class Nomeolvides.EditDialog : Nomeolvides.DialogoHecho {
	
	public EditDialog () {
		this.set_title ("Añadir un Hecho Histórico");

		this.add_button (Stock.EDIT , ResponseType.APPLY);
		this.response.connect(on_response);
	}

	public void set_datos ( Hecho hecho_a_editar ) {
		this.nombre_entry.set_text(hecho_a_editar.nombre);
		this.descripcion_entry.set_text(hecho_a_editar.descripcion);
		this.anio_entry.set_text(hecho_a_editar.fecha.get_year().to_string ());
		this.mes_entry.set_text(hecho_a_editar.fecha.get_month().to_string ());
		this.dia_entry.set_text(hecho_a_editar.fecha.get_day_of_month().to_string ());
	}	
	private void on_response (Dialog source, int response_id)
	{
        switch (response_id)
		{
    		case ResponseType.APPLY:
        		modificar();
       			break;
    		case ResponseType.CLOSE:
        		destroy();
        		break;
        }
    }
		
	private void modificar ()
	{
		if(this.nombre_entry.get_text_length () > 0)
		{
			this.respuesta  = new Hecho (this.nombre_entry.get_text (), 
			            				 this.descripcion_entry.get_text (),
			                             int.parse (this.anio_entry.get_text()),
			                             int.parse (this.mes_entry.get_text()),
			                             int.parse (this.dia_entry.get_text()),
			                             "src/hechos.json");
		}
	}
}
