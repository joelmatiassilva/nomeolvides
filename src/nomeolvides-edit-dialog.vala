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

public class Nomeolvides.EditDialog : Nomeolvides.DialogoHecho {
	private ArrayList<string> archivos_fuente;
	public EditDialog ( ArrayList<string> archivos_fuentes, Nomeolvides.Window ventana ) {
		base (archivos_fuentes, ventana);
		this.set_title ("Añadir un Hecho Histórico");				

		this.add_button (Stock.EDIT , ResponseType.APPLY);
		this.response.connect(on_response);

		this.archivos_fuente = archivos_fuentes;		
	}

	public void set_datos ( Hecho hecho_a_editar ) {
		this.nombre_entry.set_text(hecho_a_editar.nombre);
		this.descripcion_textview.buffer.text= hecho_a_editar.descripcion;
		this.anio_entry.set_text(hecho_a_editar.fecha.get_year().to_string ());
		this.mes_entry.set_text(hecho_a_editar.fecha.get_month().to_string ());
		this.dia_entry.set_text(hecho_a_editar.fecha.get_day_of_month().to_string ());
		set_fuente_de_hecho ( hecho_a_editar.archivo_fuente );
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
		this.crear_respuesta ();
	}

	protected void set_fuente_de_hecho (string archivo_fuente ) {
		int indice;
		
		for (indice = 0; indice < this.archivos_fuente.size; indice++ ) {
			if ( this.archivos_fuente[indice] == archivo_fuente ) {
				this.combo_fuentes.set_active (indice);
			} 
		}
	}
}
