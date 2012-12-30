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


public class Nomeolvides.Hecho : GLib.Object {
	
	public string nombre { get; private set; }
	public string descripcion { get; private set; }
	public string hash { get; private set; }

	// Constructor
	public Hecho (string nombre, string descripcion)
	{
		this.nombre = nombre;
		this.descripcion = descripcion;
		hash = Checksum.compute_for_string(ChecksumType.MD5, this.aJson ());
	}

	public Hecho.json (string json) {
		if (json.contains ("{\"Hecho\":{")) {
			this.nombre = this.sacarDatoJson (json, "nombre");
			this.descripcion = this.sacarDatoJson (json, "descripcion");
			hash = Checksum.compute_for_string(ChecksumType.MD5, this.aJson ());
		}
		    

	}

	public string aJson () {
		string retorno = "{\"Hecho\":{";

		retorno += "\"nombre\":\"" + this.nombre + "\",";
		retorno += "\"descripcion\":\"" + this.descripcion + "\"";

		retorno +="}}";	

		return retorno;
	}

	private string sacarDatoJson(string json, string campo) {
		int inicio,fin;
		inicio = json.index_of(":",json.index_of(campo)) + 2;
		fin = json.index_of ("\"", inicio);
		return json[inicio:fin];
	}

	public bool esIgual (string otroSum) {
		
		if (this.hash == otroSum) {
			return true;
		}
		else {
			return false;
		}
	}
}
