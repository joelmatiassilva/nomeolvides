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

public class Nomeolvides.Fuente : GLib.Object{
	public string nombre_fuente { get; private set; }
	public string nombre_archivo { get; private set; }
	public string direccion_fuente { get; private set; }
	public FuentesTipo tipo_fuente { get; private set; }

	public Fuente ( string nombre_fuente, string nombre_archivo, string direccion_fuente, FuentesTipo tipo_fuente ) {
		this.nombre_fuente = nombre_fuente;
		this.nombre_archivo = nombre_archivo;
		this.direccion_fuente = direccion_fuente;
		this.tipo_fuente = tipo_fuente;
	}

	public Fuente.json ( string json ) {
		if (json.contains ("{\"Fuente\":{")) {
			this.nombre_fuente = this.sacarDatoJson (json, "nombre");
			this.nombre_archivo = this.sacarDatoJson (json, "archivo");
			this.direccion_fuente = this.sacarDatoJson (json, "path");
			this.tipo_fuente = FuentesTipo.LOCAL;
		} else {
			this.nombre_fuente = "null";
			this.nombre_archivo = "null";
			this.direccion_fuente = "null";
			this.tipo_fuente = FuentesTipo.LOCAL;
		}
	}

	public bool verificar_fuente () {
		bool retorno = true;
		if ( this.tipo_fuente == FuentesTipo.LOCAL ) {
			if( !(FileUtils.test (this.direccion_fuente + this.nombre_archivo, FileTest.EXISTS))) {
				retorno = false;
				print ("No existe el archivo " + this.direccion_fuente + this.nombre_archivo);
			}
		}

		return retorno;
	}

	public string a_json () {
		string retorno = "{\"Fuente\":{";

		retorno += "\"nombre\":\"" + this.nombre_fuente + "\",";
		retorno += "\"archivo\":\"" + this.nombre_archivo + "\",";
		retorno += "\"path\":\"" + this.direccion_fuente + "\",";
		retorno += "\"tipo\":\"" + "local" + "\"";

		retorno +="}}";	
		
		return retorno;
	}

	private string sacarDatoJson(string json, string campo) {
		int inicio,fin;
		inicio = json.index_of(":",json.index_of(campo)) + 2;
		fin = json.index_of ("\"", inicio);
		return json[inicio:fin];
	}
}


public enum FuentesTipo {
	LOCAL
}