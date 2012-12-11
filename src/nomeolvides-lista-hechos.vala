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

public class Nomeolvides.ListaHechos : GLib.Object {

	private Array<Hecho> hechos;
	private int indice;
	
	public ListaHechos () {
		this.hechos = new Array<Hecho>();
		indice = 0;
	}

	public bool agregar (Hecho nuevo) {
		bool retorno = false;
		if (this.unico(nuevo)) {
			this.hechos.append_val(nuevo);
			retorno = true;
		}
		return retorno;
	}

	private bool unico (Hecho nuevo) {
		int i;
		bool retorno = true;

		for (i=0; (i < (int) this.hechos.length) && (retorno != false); i++) {
			if (this.hechos.index(i).esIgual(nuevo)) {
				retorno = false;
			}
		}
		return retorno;	
	}

	public int dameIndice() {
		return this.indice;
	}

	public Hecho dameSiguiente() {
		Hecho retorno;
		
		retorno = this.hechos.index(this.indice);
		
		if (this.indice < (int) this.hechos.length) {
			this.indice++;
		} else {
			this.indice = 0;
		}		
		
		return retorno;
	}
}

