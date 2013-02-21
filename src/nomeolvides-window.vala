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
 *   bullit - 39 escalones - silent love (japonesa) 
 * You should have received a copy of the GNU General Public License along
 * with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

using Gtk;
using Gee;
using Nomeolvides;

public class Nomeolvides.Window : Gtk.ApplicationWindow
{
	public Box main_box { get; private set; }
	public Box list_view_box { get; private set; }	
	private MainToolbar toolbar;
	private ViewHechos hechos_view;
	private ViewAnios anios_view;
	private VistaHecho vista_hecho;
	private ScrolledWindow scroll_vista_hecho;
	private HechosFuentes fuentes;
	
	public Window ( Gtk.Application app )
	{   
		Object (application: app);
		this.set_application (app);
		this.set_title ("Nomeolvides v" + Config.VERSION );
		this.set_position (WindowPosition.CENTER);
		this.set_default_size (800,500);
		this.set_size_request (500,350);
		this.hide_titlebar_when_maximized = true;

		main_box = new Box (Orientation.VERTICAL,0);
		list_view_box = new Box (Orientation.HORIZONTAL,0);
		this.scroll_vista_hecho = new ScrolledWindow (null,null);
		this.scroll_vista_hecho.set_policy (PolicyType.NEVER, PolicyType.AUTOMATIC);
		this.scroll_vista_hecho.set_size_request (300,-1);
		
		this.add (main_box);
		
		this.toolbar = new MainToolbar ();
		this.botones_toolbar ();

		this.anios_view = new ViewAnios ();
		this.hechos_view = new ViewHechos ();
		this.vista_hecho = new VistaHecho ();
		
		this.anios_view.cursor_changed.connect ( elegir_anio );
		this.hechos_view.cursor_changed.connect ( elegir_hecho );
		this.hechos_view.row_activated.connect ( mostrar_hecho );
		this.hechos_view.cambia_anio_signal.connect ( label_anio );

		Separator separador = new Separator(Orientation.VERTICAL);

		this.toolbar.set_anio( this.anios_view.get_anio () );

		this.scroll_vista_hecho.add_with_viewport (this.vista_hecho);
		
		list_view_box.pack_start (anios_view, false, false, 0);
		list_view_box.pack_start (new Separator(Orientation.VERTICAL), false, false, 2);
		list_view_box.pack_start (this.hechos_view, true, true, 0);
		list_view_box.pack_start (separador, false, false, 2);
		list_view_box.pack_start (scroll_vista_hecho, false, false, 0);

		this.main_box.pack_start (toolbar, false, false, 0);		
		this.main_box.pack_start (list_view_box, true, true, 0);		
	}

	private void elegir_anio () {
		string anio = this.anios_view.get_anio ();
		
		if ( anio != "0") { //acá uso el número mágico del año 0 que no existe para evitar pedir algo null
			this.hechos_view.mostrar_anio ( anio );
		}
	}

	private void botones_toolbar ()
	{
		this.toolbar.open_button.clicked.connect ( this.open_file_dialog );
		this.toolbar.save_as_button.clicked.connect ( this.save_as_file_dialog);
		this.toolbar.save_button.clicked.connect ( this.save_file);
		this.toolbar.add_button.clicked.connect ( this.add_hecho );
		this.toolbar.edit_button.clicked.connect ( this.edit_hecho );
		this.toolbar.delete_button.clicked.connect ( this.delete_hecho );
	}

	public void add_hecho ()
	{
		var add_dialog = new AddHechoDialog( this, this.fuentes);
		
		add_dialog.show();

		if (add_dialog.run() == ResponseType.APPLY)
		{
			this.hechos_view.agregar_hecho(add_dialog.respuesta);
			this.anios_view.agregar_varios (this.hechos_view.lista_de_anios());
			this.toolbar.save_button.set_visible_horizontal (true);
			add_dialog.destroy();
		}		
	}

	public void edit_hecho () {
		Hecho hecho_anterior = this.hechos_view.get_hecho_cursor();
		
		var edit_dialog = new EditHechoDialog(this, this.fuentes );
		edit_dialog.set_datos (hecho_anterior);
		edit_dialog.show_all ();

		if (edit_dialog.run() == ResponseType.APPLY)
		{
			this.hechos_view.eliminar_hecho ( hecho_anterior );
			this.hechos_view.agregar_hecho ( edit_dialog.respuesta );			
			this.anios_view.agregar_varios ( this.hechos_view.lista_de_anios() );
			this.toolbar.save_button.set_visible_horizontal (true);
			edit_dialog.destroy();
		}

	}

	public void delete_hecho () {
		Hecho hecho_a_borrar = this.hechos_view.get_hecho_cursor ();
		
		BorrarHechoDialogo delete_dialog = new BorrarHechoDialogo ( hecho_a_borrar, this );

		if (delete_dialog.run() == ResponseType.APPLY)
		{
			this.hechos_view.eliminar_hecho ( hecho_a_borrar );
			this.anios_view.agregar_varios ( this.hechos_view.lista_de_anios() );
			this.toolbar.save_button.set_visible_horizontal (true);
		}
		
		delete_dialog.destroy ();
	}

	public void open_file ( string archivo ) {
		string todo;
		string[] lineas;
		Hecho nuevoHecho;
		int i;	

		try {
			FileUtils.get_contents (archivo, out todo);
		}  catch (Error e) {
			error (e.message);
		}
		
		lineas = todo.split_set ("\n");

		for (i=0; i < (lineas.length - 1); i++) {
        	nuevoHecho = new Hecho.json(lineas[i], archivo);
			if ( nuevoHecho.nombre != "null" ) {
				this.hechos_view.agregar_hecho(nuevoHecho);
			}
		}
		
		this.anios_view.agregar_varios (this.hechos_view.lista_de_anios());
	}

	public void open_file_dialog ()
	{
		OpenFileDialog abrir_archivo = new OpenFileDialog(GLib.Environment.get_current_dir ());
		abrir_archivo.set_transient_for ( this as Window );

		if (abrir_archivo.run () == ResponseType.ACCEPT) {
            this.open_file ( abrir_archivo.get_filename () );
		}

		abrir_archivo.close ();
	}

	public void save_as_file ( string archivo ) {
		int i;
		ArrayList<Hecho> lista;
		string a_guardar = "";

		lista = this.hechos_view.lista_de_hechos ();
		for (i=0; i < lista.size; i++) {
			a_guardar +=lista[i].a_json() + "\n"; 
		}

		try {
			FileUtils.set_contents (archivo, a_guardar);
		}  catch (Error e) {
			error (e.message);
		}
	}

	public void save_file () {
		int i,y;
		ArrayList<Hecho> lista;
		string archivo;
		string a_guardar = "";

		lista = this.hechos_view.lista_de_hechos ();
	
		for (i=0; i < lista.size; i++) {
			archivo = lista[i].archivo_fuente;
			for (y=0; y < lista.size; y++) {
				if (lista[y].archivo_fuente == archivo) {
					a_guardar +=lista[y].a_json() + "\n";
					lista.remove_at(y);
					y--;
				}
			}
			
			try {
				FileUtils.set_contents (archivo, a_guardar);
				i--;
			} catch (Error e) {
				error (e.message);
			}

			a_guardar = "";
		}	
	}

	public void save_as_file_dialog () {
		SaveFileDialog guardar_archivo = new SaveFileDialog(GLib.Environment.get_current_dir ());
		guardar_archivo.set_transient_for ( this as Window );

		if (guardar_archivo.run () == ResponseType.ACCEPT) {
			
            this.save_as_file ( guardar_archivo.get_filename () );
		}
		
		guardar_archivo.close ();
	}

	public void elegir_hecho () {
		if(this.hechos_view.get_hecho_cursor () != null) {
			this.toolbar.set_buttons_visible ( true );
		} else {
			this.toolbar.set_buttons_visible ( false );		
		}

		this.scroll_vista_hecho.set_visible ( false );
	}

	public void mostrar_hecho () {
		Hecho hecho_a_mostrar = this.hechos_view.get_hecho_cursor();

		if (this.scroll_vista_hecho.visible == true ) {
			this.scroll_vista_hecho.set_visible (false);
		} else {
			if ( hecho_a_mostrar != null ) {
				this.vista_hecho.set_datos_hecho ( hecho_a_mostrar );
				this.scroll_vista_hecho.set_visible ( true );
			}
		}
	}

	public void cargar_fuentes_predefinidas ( HechosFuentes fuentes ) {		
		int indice;

		this.fuentes = fuentes;
		
		for (indice = 0; indice < fuentes.fuentes_liststore.archivos.size; indice++ ) {
			this.open_file ( fuentes.fuentes_liststore.archivos[indice] );
		}
	}

	public void show_visible () {
		this.show_all ();
		this.scroll_vista_hecho.hide ();
	}

	public void label_anio () {
		this.toolbar.set_anio( this.hechos_view.anio_actual );
	}
}
