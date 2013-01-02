/* -*- Mode: vala; indent-tabs-mode: t; c-basic-offset: 4; tab-width: 4 -*-  */
/* nomeolvides
 *
 * Copyright (C) 2012 Lonko Soft <fernando@softwareperonista.com.ar>
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

public class Nomeolvides.ListStoreHechos : ListStore {
	private string[] hechosCache;
	private TreeIter iterador;
	
	public ListStoreHechos () {
		Type[] tipos= { typeof (string), typeof (string), typeof (string) };
		this.hechosCache = {};
		this.set_column_types(tipos);
	}

	public bool agregar (Hecho nuevo) {	
		bool retorno = false;
		if (this.unico(nuevo)) {
			this.append(out iterador);
			this.set(iterador, 0, nuevo.nombre, 1, nuevo.descripcion, 2, nuevo.fecha_to_string());
			this.hechosCache += nuevo.hash;
			retorno = true;
		}
		return retorno;
	}

	private bool unico (Hecho nuevo) {
		int i;																									
		bool retorno = true;

		if (this.hechosCache.length > 0) {
			for (i=0; (i < this.hechosCache.length) && (retorno != false); i++) {
				if (nuevo.esIgual(this.hechosCache[i])) {
				retorno = false;
				}
			}
		}
		
		return retorno;	
	}
}
