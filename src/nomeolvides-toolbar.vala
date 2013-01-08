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

public class Nomeolvides.mainToolbar : Toolbar
{
	public ToolButton add_button {get; private set;}
	public ToolButton open_button {get; private set;}
	
	public mainToolbar ()
	{
		this.get_style_context().add_class(STYLE_CLASS_PRIMARY_TOOLBAR);

		this.add_button = new ToolButton.from_stock(Stock.ADD);
		this.open_button = new ToolButton.from_stock(Stock.OPEN);
		
		this.add_button.is_important = true;		
		this.open_button.is_important = true;

		this.add(add_button);
		this.add(open_button);
	}
}
