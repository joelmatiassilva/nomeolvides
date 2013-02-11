/* -*- Mode: vala; indent-tabs-mode: t; c-basic-offset: 4; tab-width: 4 -*-  */
/* nomeolvides
 *
 * Copyright (C) 2013 Andres Fernandez <andres@softwareperonista.com.ar>
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
 *   bullit - 39 escalones - silent love (japonesa) 
 * You should have received a copy of the GNU General Public License along
 * with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

using Gtk;
using Nomeolvides;

public class Nomeolvides.HechosFuentes : GLib.Object{
	public ListStoreFuentes fuentes_liststore { get; private set; }
		
	public HechosFuentes () {
		this.fuentes_liststore = new ListStoreFuentes ();
		Fuente inicial = new Fuente ( "Inicial","hechos.json","src/", FuentesTipo.LOCAL );
		
		this.fuentes_liststore.agregar_fuente ( inicial );
	}

	public void actualizar_fuentes_liststore ( ListStoreFuentes nueva_fuente_liststore) {
		this.fuentes_liststore = nueva_fuente_liststore;
	} 
}
