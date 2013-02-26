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

public class Nomeolvides.EditFuenteDialog : Dialog
{
	private Entry nombre_fuente_entry;
	private Entry nombre_archivo_entry;
	private Entry direccion_entry;
//	private ListStore lista_tipos_fuentes;
//	private ComboBox combo_tipos_fuentes;
	private Button elegir_archivo;
	public Fuente respuesta { get; protected set; }
	
	public EditFuenteDialog ( )
	{
		this.resizable = false;
		this.modal = true;
		this.title = "Editar parámetro de la Base de Datos";
		this.add_button (Stock.CANCEL , ResponseType.CLOSE);
		this.add_button (Stock.ADD , ResponseType.APPLY);
		this.response.connect(on_response);
		
		var nombre_fuente_label = new Label.with_mnemonic ("Nombre de la Fuente: ");
		var nombre_archivo_label = new Label.with_mnemonic ("Nombre del Archivo: ");
		var direccion_label = new Label.with_mnemonic ("Dirección del Archivo: ");
	//	var tipo_fuente_label = new Label.with_mnemonic ("Tipo de Fuente: ");
		
		this.nombre_fuente_entry = new Entry ();
		this.nombre_archivo_entry = new Entry ();
		this.direccion_entry = new Entry ();
//		this.lista_tipos_fuentes = new ListStore (2,typeof(string),typeof(FuentesTipo));		
//		this.combo_tipos_fuentes = new ComboBox ();
		this.elegir_archivo = new Button.from_stock (Stock.FILE);
		this.elegir_archivo.clicked.connect ( elegir_fuente );

//		this.set_liststore_tipos_fuente ();
//		this.set_combo_box ();


		var grid = new Grid ();
		
		grid.attach (nombre_fuente_label, 0, 0, 1, 1);
	    grid.attach (this.nombre_fuente_entry, 1, 0, 1, 1);
		grid.attach (nombre_archivo_label, 0, 1, 1, 1);
		grid.attach (this.nombre_archivo_entry, 1, 1, 1, 1);
		grid.attach (direccion_label, 0 , 2 , 1 ,1);
		grid.attach (this.direccion_entry, 1 , 2 , 1 ,1);
		grid.attach (this.elegir_archivo, 2, 2, 1, 1);
/*		grid.attach (tipo_fuente_label, 0, 3, 1, 1);
		grid.attach (this.combo_tipos_fuentes, 1 , 3 , 1 ,1);*/
		
		
		var contenido = this.get_content_area() as Box;

		contenido.pack_start(grid, true, true, 0);
		
		this.show_all ();
	}

	private void on_response (Dialog source, int response_id)
	{
        switch (response_id)
		{
    		case ResponseType.APPLY:
        		this.crear_respuesta ();
				break;
    		case ResponseType.CLOSE:
        		this.destroy();
        		break;
        }
    }

	private void crear_respuesta() {
		if(this.nombre_fuente_entry.get_text_length () > 0)
		{
			this.respuesta  = new Fuente (this.nombre_fuente_entry.get_text (), 
			            				  this.nombre_archivo_entry.get_text(),
										  this.direccion_entry.get_text (),
			                              FuentesTipo.LOCAL);
		}
	}

	/*private void set_combo_box () {
		CellRendererText renderer = new CellRendererText ();
		this.combo_tipos_fuentes.pack_start (renderer, true);
		this.combo_tipos_fuentes.add_attribute (renderer, "text", 0);
		this.combo_tipos_fuentes.active = 0;
		this.combo_tipos_fuentes.set_model ( this.lista_tipos_fuentes );
	}*/

	/*private FuentesTipo get_tipo_elegido () {		
		TreeIter iter;
		Value tipo_fuente;
		
		this.combo_tipos_fuentes.get_active_iter( out iter );
		this.lista_tipos_fuentes.get_value (iter, 1, out tipo_fuente);

		return (FuentesTipo) tipo_fuente;
	}*/

/*	private void set_liststore_tipos_fuente () {
		TreeIter iter;		

		this.lista_tipos_fuentes.append ( out iter );
		this.lista_tipos_fuentes.set ( iter, 0, "Archivo Local" );
		this.lista_tipos_fuentes.set ( iter, 1, FuentesTipo.LOCAL );
	}*/

	private void elegir_fuente () {
		OpenFileDialog elegir_archivo = new OpenFileDialog(GLib.Environment.get_current_dir ());
		elegir_archivo.set_transient_for ( this as Window );

		string path_provisorio;

		if (elegir_archivo.run () == ResponseType.ACCEPT) {
    		path_provisorio = elegir_archivo.get_filename ();
			this.direccion_entry.set_text (path_provisorio.slice(0,path_provisorio.last_index_of_char ('/') +1));
			this.nombre_archivo_entry.set_text (path_provisorio.slice(path_provisorio.last_index_of_char ('/') +1, path_provisorio.char_count ()));
		}

		elegir_archivo.destroy ();
	}

	public void set_datos (Fuente fuente) {
		this.nombre_fuente_entry.set_text ( fuente.nombre_fuente );
		this.nombre_archivo_entry.set_text ( fuente.nombre_archivo );
		this.direccion_entry.set_text ( fuente.direccion_fuente );
	}
}
