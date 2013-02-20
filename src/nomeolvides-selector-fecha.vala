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

public class Nomeolvides.SelectorFecha : Box {
	public SpinButton dia_spin { get; private set; }
	public ComboBox mes_combo { get; private set; }
	public ListStore mes_lista { get; private set; }
	public SpinButton anio_spin { get; private set; }

	public SelectorFecha () {
		this.set_orientation (Orientation.HORIZONTAL);
		this.dia_spin = new SpinButton (new Adjustment ( 17, 1, 31, 1, 1, 1 ), 1, 0 );
		this.anio_spin = new SpinButton (new Adjustment ( 1945, 1, 9999, 1, 1, 1 ), 1, 0 );
		this.anio_spin.value_changed.connect ( this.cambiar_anio );
		this.set_combo_box ();

		this.pack_start (dia_spin, false, false, 0);
		this.pack_start (mes_combo, false, false, 0);
		this.pack_start (anio_spin, false, false, 0);
	}

	private void set_combo_box () {
		this.mes_combo = new ComboBox ();		
		CellRendererText renderer = new CellRendererText ();
		this.set_meses_lista ();
		
		this.mes_combo.pack_start (renderer, true);
		this.mes_combo.add_attribute (renderer, "text", 0);
		this.mes_combo.active = 9;
		this.mes_combo.set_model ( this.mes_lista );
		this.mes_combo.changed.connect (set_dias_del_mes );
	}

	private void set_meses_lista () {
		TreeIter iter;
		string[] meses = {"Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio",
			              "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"};
		
		this.mes_lista = new ListStore ( 2, typeof(string), typeof(int) );

		for (int i = 0; i < 12; i++ ) {
			this.mes_lista.append (out iter);
			this.mes_lista.set (iter, 0, meses[i], 1, i+1);
		}
	}

	private void set_dias_del_mes () {
		int mes = this.get_mes ();
		
		if (mes == 1 || mes == 3 || mes == 5 || mes == 7 || mes == 8 || mes == 10 || mes == 12) {
			this.dia_spin.get_adjustment().set_upper ( 32 );
		} else if ( mes == 4 || mes == 6 || mes == 9 || mes == 11 ) {
			this.dia_spin.get_adjustment().set_upper ( 31 );
			if ( this.get_dia () == 31 ) {
				this.dia_spin.set_value (30);
			}
		} else {
			GLib.DateYear anio = (GLib.DateYear)this.get_anio ();
			if ( anio.is_leap_year() ) {
				this.dia_spin.get_adjustment().set_upper ( 30 );
				if ( this.get_dia () > 29 ) {
					this.dia_spin.set_value (29);
				}
			} else {
				this.dia_spin.get_adjustment().set_upper ( 29 );
				if ( this.get_dia () > 28 ) {
					this.dia_spin.set_value (28);
				}
			}	
		}
	}

	private void cambiar_anio () {
		GLib.DateYear anio = (GLib.DateYear)this.get_anio ();
		if ( anio.is_leap_year() && this.get_mes () == 2 ) {
			this.dia_spin.get_adjustment().set_upper ( 30 );			
		} else {
			if ( this.get_mes () == 2 && this.get_dia () == 29 ) {
				this.dia_spin.set_value (28);
			}	
		}
	}

	public int get_dia () {
		return (int) this.dia_spin.get_value ();
	}

	public int get_mes () {
		TreeIter iter;
		Value mes;
		
		this.mes_combo.get_active_iter( out iter );
		this.mes_lista.get_value (iter, 1, out mes);
		
		return (int) mes ;
	}

	public int get_anio () {
		return (int) this.anio_spin.get_value ();
	}

	public void set_dia ( int valor ) {
		this.dia_spin.set_value ( valor );
	}

	public void set_mes ( int valor ) {
		this.mes_combo.set_active ( valor-1 );
	}

	public void set_anio ( int valor ) {
		this.anio_spin.set_value ( valor );
	}
}
