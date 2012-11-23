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



public class Nomeolvides.Add_dialog : Dialog
{
	public Add_dialog ()
	{
		this.set_title ("Añadir un Heho Histórico");
		
		var nombre_entry = new Entry ();
		var nombre_label = new Label.with_mnemonic ("Nombre: ");
		var descripcion_entry = new Entry ();
		var descripcion_label = new Label.with_mnemonic ("Descripcion: ");
/*		var boton_agregar = new Button.with_label ("Agregar");
		var boton_cancelar = new Button.with_label ("Cancelar");
*/
		var boton_cancelar = add_button (Stock.CANCEL , ResponseType.CLOSE);
		var boton_agregar = add_button (Stock.ADD , ResponseType.APPLY);
		
		var grid = new Grid ();

		grid.attach (nombre_label, 0, 0, 1, 1);
	    grid.attach (nombre_entry, 1, 0, 1, 1);
		grid.attach (descripcion_label, 0, 1, 1, 1);
		grid.attach (descripcion_entry, 1, 1, 1, 1);
		//grid.attach (boton_cancelar, 0, 2, 1, 1);
		//grid.attach (boton_agregar, 1, 2, 1, 1);		

		var contenido = this.get_content_area () as Box;
		contenido.pack_start (grid, false, true, 0);

		this.response.connect (on_response);
		this.show_all ();
	}


	private void on_response (Dialog source, int response_id) {
        switch (response_id) {
        case ResponseType.APPLY:
            //on_find_clicked ();
            break;
        case ResponseType.CLOSE:
            destroy ();
            break;
        }
    }
}