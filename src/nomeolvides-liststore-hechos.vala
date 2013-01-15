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

public class Nomeolvides.ListStoreHechos : ListStore {
	private ArrayList<string> hechos_cache;
	private TreeIter iterador;
	
	public ListStoreHechos () {
		Type[] tipos= { typeof (string), typeof (string), typeof (string), typeof (Hecho) };
		this.hechos_cache = new ArrayList<string> ();
		this.set_column_types(tipos);
	}

	public bool agregar (Hecho nuevo) {	
		bool retorno = false;
		if (this.unico(nuevo)) {
			this.append(out iterador);
			this.set(iterador, 0, nuevo.nombre, 1, nuevo.descripcion, 2, nuevo.fecha_to_string(), 3, nuevo);
			this.hechos_cache.add(nuevo.hash);
			retorno = true;
		}
		return retorno;
	}

	public void eliminar (TreeIter iter, Hecho a_eliminar ) {
		this.hechos_cache.remove(a_eliminar.hash);
		this.remove (iter);
	}

	private bool unico (Hecho nuevo) {
		int i;																									
		bool retorno = true;

		if (this.hechos_cache.size > 0) {
			for (i=0; (i < this.hechos_cache.size) && (retorno != false); i++) {
				if (nuevo.esIgual(this.hechos_cache[i])) {
				retorno = false;
				}
			}
		}
		
		return retorno;	
	}

	public int length () {
		return this.hechos_cache.size;
	}
	
}
