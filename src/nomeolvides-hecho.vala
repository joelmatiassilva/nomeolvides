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
using GLib;

public class Nomeolvides.Hecho : GLib.Object {
	
	public string nombre { get; private set; }
	public string descripcion { get; private set; }
	public DateTime fecha {get; private set; }
	public string hash { get; private set; }
	public string archivo_fuente { get; private set; }
	private string reemplazoSaltoDeLinea { get; private set; } 

	// Constructor
	public Hecho ( string nombre, string descripcion, int anio, int mes, int dia, string archivo_fuente )
	{
		this.nombre = nombre;
		this.descripcion = this.ponerSaltoDeLinea ( descripcion );
		this.fecha = new DateTime.utc (anio, mes, dia, 0,0,0);
		hash = Checksum.compute_for_string (ChecksumType.MD5, this.a_json ());
		this.archivo_fuente = archivo_fuente;
	}

	public Hecho.json (string json, string archivo_fuente ) {
		
		if (json.contains ("{\"Hecho\":{")) {
			this.nombre = this.sacarDatoJson (json, "nombre");
			this.descripcion = this.ponerSaltoDeLinea ( this.sacarDatoJson ( json, "descripcion" ) );
			this.fecha = new DateTime.utc (int.parse (this.sacarDatoJson(json, "anio")),
			                               int.parse (this.sacarDatoJson(json, "mes")),
			                               int.parse (this.sacarDatoJson(json, "dia")),
			                     		   0,0,0);			
		} else {
			this.nombre = "null";
			this.descripcion = "null";
			this.fecha = new DateTime.utc (2013,2,20,0,0,0);
			this.archivo_fuente = archivo_fuente;
		}
		
		hash = Checksum.compute_for_string(ChecksumType.MD5, this.a_json ());

		this.archivo_fuente = archivo_fuente;
	}

	private void saltoDeLinea () {
		this.reemplazoSaltoDeLinea = "|";
	}
	public string a_json () {
		string retorno = "{\"Hecho\":{";

		retorno += "\"nombre\":\"" + this.nombre + "\",";
		retorno += "\"descripcion\":\"" + this.sacarSaltoDeLinea(this.descripcion) + "\",";
		retorno += "\"anio\":\"" + this.fecha.get_year().to_string () + "\",";
		retorno += "\"mes\":\"" + this.fecha.get_month().to_string () + "\",";
		retorno += "\"dia\":\"" + this.fecha.get_day_of_month().to_string () + "\"";

		retorno +="}}";	
		
		return retorno;
	}

	private string sacarDatoJson(string json, string campo) {
		int inicio,fin;
		inicio = json.index_of(":",json.index_of(campo)) + 2;
		fin = json.index_of ("\"", inicio);
		return json[inicio:fin];
	}

	public string fecha_to_string () {
		string texto;
		texto = this.fecha.format("%e de %B de %Y");
		return texto;
	}

	public bool esIgual (string otroSum) {
		
		if (this.hash == otroSum) {
			return true;
		}
		else {
			return false;
		}
	}

	private string ponerSaltoDeLinea ( string inicial ) {

		string saltoDeLinea = "\n";
		this.saltoDeLinea ();
		string retorno = inicial.replace ( this.reemplazoSaltoDeLinea, saltoDeLinea );
		
		return retorno;
	}

	private string sacarSaltoDeLinea ( string inicial ) {

		string saltoDeLinea = "\n";
		string retorno = inicial.replace ( saltoDeLinea, this.reemplazoSaltoDeLinea );
		
		return retorno;
	}

	
}
