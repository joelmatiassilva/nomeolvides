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


public class Nomeolvides.ViewHechos : Gtk.TreeView {

	private ListStoreHechos[] hechos_anios;
	private string[] cache_hechos_anios;

	public ViewHechos () {
		this.cache_hechos_anios = {};
		this.hechos_anios = {};
		this.insert_column_with_attributes (-1, "Nombre", new CellRendererText (), "text", 0);
		this.insert_column_with_attributes (-1, "Descripción", new CellRendererText (), "text", 1);
		this.insert_column_with_attributes (-1, "Fecha", new CellRendererText (), "text", 2);
	}

	public void agregarHecho (Hecho nuevo) {
		if ( anio_en_cache ( nuevo.fecha.get_year().to_string() )) {
			this.hechos_anios[en_liststore (nuevo.fecha.get_year().to_string())].agregar (nuevo);
			
		} else {
			agregar_liststore ( nuevo.fecha.get_year().to_string() );
			this.hechos_anios[en_liststore (nuevo.fecha.get_year().to_string())].agregar (nuevo);
		}
		this.mostrar_anio ("1828");
	}

	public void mostrar_anio ( string anio ) {
		if ( anio_en_cache ( anio ) ){
			this.set_model( this.hechos_anios[en_liststore (anio)] );
		}
	}

	private bool anio_en_cache (string anio) {
		int i;
		
		for (i=0; i < this.cache_hechos_anios.length; i++) {
			if (this.cache_hechos_anios[i] == anio) {
				return true;
			}	
		}	
		return false;
	}

	private void agregar_liststore (string nuevo_anio) {
		this.hechos_anios += new ListStoreHechos();
		this.cache_hechos_anios += nuevo_anio;
	}

	private int en_liststore (string anio) {
		int i;
		
		for (i=0; i < this.cache_hechos_anios.length; i++) {
			if (this.cache_hechos_anios[i] == anio) {
				return i;
			}	
		}
		return 0;
	}
}