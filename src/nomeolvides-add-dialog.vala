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
using Nomeolvides;

public class Nomeolvides.Add_dialog : Dialog
{
	private Entry nombre_entry;
	private Entry descripcion_entry;
	private Entry anio_entry;
	private Entry mes_entry;
	private Entry dia_entry;
	public Hecho respuesta { get; private set; }
	
	public Add_dialog ()
	{
		this.set_title ("Añadir un Heho Histórico");
		this.resizable = false;
		this.modal = true;		
		
		var nombre_label = new Label.with_mnemonic ("Nombre: ");
		var descripcion_label = new Label.with_mnemonic ("Descripcion: ");
		var anio_label = new Label.with_mnemonic ("Año: ");
		var mes_label = new Label.with_mnemonic ("Mes: ");
		var dia_label = new Label.with_mnemonic ("Día: ");
		this.add_button (Stock.CANCEL , ResponseType.CLOSE);
		this.add_button (Stock.ADD , ResponseType.APPLY);
		var calendar_button = new ToolButton.from_stock(Stock.ADD);
		
		this.nombre_entry = new Entry ();
		this.descripcion_entry = new Entry ();
		this.anio_entry = new Entry ();
		this.mes_entry = new Entry ();
		this.dia_entry = new Entry ();

		var grid = new Grid ();
		grid.attach (nombre_label, 0, 0, 1, 1);
	    grid.attach (nombre_entry, 1, 0, 1, 1);
		grid.attach (descripcion_label, 0, 1, 1, 1);
		grid.attach (descripcion_entry, 1, 1, 1, 1);
		grid.attach (anio_label, 0, 2, 1, 1);
		grid.attach (anio_entry, 1 , 2 , 1 ,1);
		grid.attach (mes_label, 0, 3, 1, 1);
		grid.attach (mes_entry, 1 , 3 , 1 ,1);
		grid.attach (dia_label, 0, 4, 1, 1);
		grid.attach (dia_entry, 1 , 4 , 1 ,1);
		
		var contenido = this.get_content_area() as Box;
		contenido.pack_start(grid, false, true, 0);

		this.response.connect(on_response);
		this.nombre_entry.activate.connect(on_activate);
		this.descripcion_entry.activate.connect(on_activate);
		this.anio_entry.activate.connect(on_activate);
		this.mes_entry.activate.connect(on_activate);
		this.dia_entry.activate.connect(on_activate);


		this.show_all ();
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
		    this.descripcion_entry.text_length > 0 && 
		    this.anio_entry.text_length > 0 && 
		    this.mes_entry.text_length > 0 && 
		    this.dia_entry.text_length > 0) {
				this.response (ResponseType.APPLY);
		}
	}
		
	private void aplicar ()
	{
		if(this.nombre_entry.get_text_length () > 0)
		{
			this.respuesta  = new Hecho (this.nombre_entry.get_text (), 
			            				 this.descripcion_entry.get_text (),
			                             this.anio_entry.get_text().to_int (),
			                             this.mes_entry.get_text().to_int (),
			                             this.dia_entry.get_text().to_int ());
		}
	}
}
