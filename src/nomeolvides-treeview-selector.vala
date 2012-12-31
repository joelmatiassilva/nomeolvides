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

public class Nomeolvides.TreeViewSelector : TreeView {

	public TreeViewSelector () {
		var liststore = new ListStore(1,typeof(string));
		TreeIter iter;
		liststore.append (out iter);
		liststore.set(iter,0,"LA VIDA POR CRISTINA");
		liststore.append (out iter);
		liststore.set(iter,0,"LA VIDA POR CRISTINA");
		liststore.append (out iter);
		liststore.set(iter,0,"LA VIDA POR CRISTINA");
		liststore.append (out iter);
		liststore.set(iter,0,"LA VIDA POR CRISTINA");
		this.set_model (liststore);
		var celda = new CellRendererText();
//		celda.set("background_set", true);
//		celda.background = "grey";
		this.insert_column_with_attributes (-1,"TreeView Provisorio", celda, "text",0);
	}	
}
