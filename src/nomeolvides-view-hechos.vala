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


public class Nomeolvides.ViewHechos : Gtk.TreeView {

	public string anio_actual { get; private set; }
	private ArrayList<ListStoreHechos> hechos_anios;
	private ListStoreHechos anio_mostrado_ahora; 
	private ArrayList<string> cache_hechos_anios;

	public ViewHechos () {
		this.cache_hechos_anios = new ArrayList<string> ();
		this.hechos_anios = new ArrayList<ListStoreHechos> ();
		this.insert_column_with_attributes (-1, "Nombre", new CellRendererText (), "text", 0);
		this.insert_column_with_attributes (-1, "Fecha", new CellRendererText (), "text", 2);
	}

	public void agregar_hecho (Hecho nuevo) {
		if ( this.cache_hechos_anios.contains ( nuevo.fecha.get_year().to_string() )) {
			this.hechos_anios[en_liststore (nuevo.fecha.get_year().to_string())].agregar (nuevo);
		} else {
			agregar_liststore ( nuevo.fecha.get_year().to_string() );
			this.hechos_anios[en_liststore (nuevo.fecha.get_year().to_string())].agregar (nuevo);
		}
		this.mostrar_anio ( nuevo.fecha.get_year().to_string() );		
	}

	public void mostrar_anio ( string anio ) {
		if ( this.cache_hechos_anios.contains ( anio ) ){
			this.anio_mostrado_ahora = this.hechos_anios[en_liststore (anio)];
			this.set_model( this.anio_mostrado_ahora );
			this.anio_mostrado_ahora.set_sort_column_id(3, SortType.ASCENDING);
			this.anio_mostrado_ahora.set_sort_func(3, ordenar_hechos);
			this.anio_actual = anio;
			cambia_anio_signal ();
		}
	}

	public void eliminar_hecho ( Hecho a_eliminar ) {
		TreePath path;
		TreeViewColumn columna;
		TreeIter iterador;
		int anio = en_liststore (a_eliminar.fecha.get_year().to_string());

		
		this.get_cursor(out path, out columna);
		this.anio_mostrado_ahora.get_iter(out iterador, path);
		this.hechos_anios[anio].eliminar ( iterador, a_eliminar );

		if (this.hechos_anios[anio].length () == 0) {
			this.eliminar_liststore (anio);
		}		
	}
	
	private void agregar_liststore (string nuevo_anio) {
		this.hechos_anios.add ( new ListStoreHechos() );
		this.cache_hechos_anios.add (nuevo_anio);
	}

	private void eliminar_liststore (int a_eliminar) {
		
		this.hechos_anios.remove (this.hechos_anios[a_eliminar]);
		this.cache_hechos_anios.remove(this.cache_hechos_anios[a_eliminar]);
	}

	private int en_liststore (string anio) {

		int retorno;

		retorno = this.cache_hechos_anios.index_of( anio ); 

		return retorno;
	}

	public void borrar_datos () {
		this.hechos_anios.clear ();
		this.cache_hechos_anios.clear ();
	}

	public Hecho get_hecho_cursor () {
		TreePath path;
		TreeViewColumn columna;
		TreeIter iterador;
		Value hecho;
		
		this.get_cursor(out path, out columna);
		if (path != null ) {
			this.anio_mostrado_ahora.get_iter(out iterador, path);
			this.anio_mostrado_ahora.get_value (iterador, 3, out hecho);
			return (Hecho) hecho;
		} else { 
			return (Hecho) null;
		}		
	}

    public ArrayList<Hecho> lista_de_hechos () { 
        ArrayList<Hecho> hechos = new ArrayList<Hecho>();
		Value hecho;
		TreeIter iter;
		int i;


		for (i=0; i < this.cache_hechos_anios.size; i++ ) {
			this.hechos_anios[i].get_iter_first(out iter);
			do {
				this.hechos_anios[i].get_value(iter, 3, out hecho);
				hechos.add ((Hecho) hecho);
			}while (this.hechos_anios[i].iter_next(ref iter));
		}
		
		return hechos;
    }


	public string[] lista_de_anios ()
	{
		string[] retorno = {};
		int i;

		for (i=0; i < this.cache_hechos_anios.size; i++ ) {
			retorno += this.cache_hechos_anios[i];
		}		
		
		return retorno;
	}

	private int comparar_hechos (Hecho hecho1, Hecho hecho2) {

		int anio1, mes1, dia1;
		int anio2, mes2, dia2;
		
		anio1 = hecho1.fecha.get_year();
		anio2 = hecho2.fecha.get_year();
		
		mes1 = hecho1.fecha.get_month();
		mes2 = hecho2.fecha.get_month();

		dia1 = hecho1.fecha.get_day_of_month();
		dia2 = hecho2.fecha.get_day_of_month();

		if (anio1 < anio2) {
			return -1;
		} else {
			if (anio1 > anio2) {
				return 1;
			} else {
				if (mes1 < mes2) {
					return -1;
				} else {
					if (mes1 > mes2) {
						return 1;
					} else {
						if (dia1 < dia2) {
							return -1;
						} else {
							if (dia1 > dia2) {
								return 1;
							} else {
								return 0;
							}
						}
					}
				}			
			}
		}
	}
	
	
	private int ordenar_hechos (TreeModel model2, TreeIter iter1, TreeIter iter2) {
		GLib.Value val1;
		GLib.Value val2;

		this.anio_mostrado_ahora.get_value(iter1, 3, out val1);
        this.anio_mostrado_ahora.get_value(iter2, 3, out val2);

		return this.comparar_hechos((Hecho) val1, (Hecho) val2);
	}

	public signal void cambia_anio_signal ();
}
