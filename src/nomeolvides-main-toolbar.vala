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
using Nomeolvides;

public class Nomeolvides.MainToolbar : Toolbar
{
	public ToolButton open_button { get; private set; }
	public ToolButton save_button { get; private set; }
	public ToolButton add_button { get; private set; }
	public ToolButton edit_button { get; private set; }
	public ToolButton delete_button { get; private set; }
	
	public MainToolbar ()
	{
		this.get_style_context().add_class (STYLE_CLASS_PRIMARY_TOOLBAR);

		this.open_button = new ToolButton.from_stock ( Stock.OPEN );
		this.save_button = new ToolButton.from_stock ( Stock.SAVE );
		this.add_button = new ToolButton.from_stock ( Stock.ADD );
		this.edit_button = new ToolButton.from_stock ( Stock.EDIT );
		this.delete_button = new ToolButton.from_stock ( Stock.DELETE );
		
		this.open_button.is_important = true;
		this.save_button.is_important = true;		
		this.add_button.is_important = true;		
		this.edit_button.is_important = true;
		this.edit_button.set_visible_horizontal ( false );
		this.delete_button.is_important = true;
		this.delete_button.set_visible_horizontal ( false );

		this.add ( this.open_button );
		this.add ( this.save_button );
		this.add ( this.add_button );
		this.add ( this.edit_button );
		this.add ( this.delete_button );
	}

	public void set_buttons_visible (bool cambiar) {
		if(this.edit_button.get_visible_horizontal() != cambiar) {
			this.edit_button.set_visible_horizontal (cambiar);
			this.delete_button.set_visible_horizontal (cambiar);
		}
	}
}
