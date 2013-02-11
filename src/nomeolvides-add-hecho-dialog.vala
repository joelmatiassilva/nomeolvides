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
using Gee;
using Nomeolvides;

public class Nomeolvides.AddHechoDialog : Nomeolvides.DialogoHecho {
	
	public AddHechoDialog ( Nomeolvides.Window ventana, HechosFuentes fuentes ) {
		base (ventana, fuentes);

		this.set_title ("Añadir un Hecho Histórico");
		
		this.response.connect(on_response);
		this.nombre_entry.activate.connect(on_activate);
		this.anio_entry.activate.connect(on_activate);
		this.mes_entry.activate.connect(on_activate);
		this.dia_entry.activate.connect(on_activate);
		this.add_button (Stock.ADD , ResponseType.APPLY);		
	}


	private void on_response (Dialog source, int response_id)
	{
        switch (response_id)
		{
    		case ResponseType.APPLY:
        		aplicar();
       			break;
    		case ResponseType.CLOSE:
        		destroy();
        		break;
        }
    }

	private void on_activate () {
		if (this.nombre_entry.text_length > 0 && 
		    this.descripcion_textview.buffer.text.length > 0 && 
		    this.anio_entry.text_length > 0 && 
		    this.mes_entry.text_length > 0 && 
		    this.dia_entry.text_length > 0) {
			this.response (ResponseType.APPLY);
		}
	}
		
	private void aplicar ()
	{
		this.crear_respuesta ();
	}
}
