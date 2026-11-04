import 'package:flutter/material.dart';

// MODELO DEL EVENTO
class Evento {
  final String nombre;
  final String teatro;
  final String categoria;
  final String fecha;
  final String hora;
  final bool esGratis;
  final String precio;
  final String descripcion;

  Evento({
    required this.nombre,
    required this.teatro,
    required this.categoria,
    required this.fecha,
    required this.hora,
    required this.esGratis,
    required this.precio,
    required this.descripcion,
  });
}

// PANTALLA PRINCIPAL
class ElementosScreen extends StatefulWidget {
  const ElementosScreen({super.key});

  @override
  State<ElementosScreen> createState() => _ElementosScreenState();
}

class _ElementosScreenState extends State<ElementosScreen> {
  final List<Evento> eventos = [];
  int? eventoSeleccionado;
  bool modoEliminar = false;

  final Color colorPrincipal = const Color.fromARGB(255, 1, 122, 137);

  // ICONO SEGÚN LA CATEGORÍA
  IconData obtenerIcono(String categoria) {
    switch (categoria) {
      case 'Teatro':
        return Icons.theater_comedy;
      case 'Música':
        return Icons.music_note;
      case 'Cine':
        return Icons.movie;
      case 'Danza':
        return Icons.sports_gymnastics;
      default:
        return Icons.event;
    }
  }

  // ABRIR FORMULARIO PARA AÑADIR EVENTO
  Future<void> abrirFormulario({int? indice}) async {
    final Evento? nuevoEvento = await showDialog<Evento>(
      context: context,
      builder: (context) => AddEventDialog(eventoInicial: indice == null ? null : eventos[indice]),
    );

    if (nuevoEvento != null) {
      setState(() {
        if (indice == null) {
          eventos.add(nuevoEvento);
          eventoSeleccionado = eventos.length - 1;
        } else {
          eventos[indice] = nuevoEvento;
          eventoSeleccionado = indice;
        }
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(indice == null ? 'Evento añadido correctamente' : 'Evento actualizado correctamente'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  Future<void> confirmarEliminacion(int indice) async {
    final evento = eventos[indice];
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar evento'),
        content: Text('¿Quieres eliminar "${evento.nombre}"?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancelar')),
          TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Eliminar')),
        ],
      ),
    );

    if (confirmar == true && mounted) {
      setState(() {
        eventos.removeAt(indice);
        if (eventoSeleccionado == indice) {
          eventoSeleccionado = null;
        } else if (eventoSeleccionado != null && eventoSeleccionado! > indice) {
          eventoSeleccionado = eventoSeleccionado! - 1;
        }
      });
    }
  }

  Future<void> confirmarEliminarTodos() async {
    if (eventos.isEmpty) return;

    final cantidad = eventos.length;
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Borrar todos los eventos'),
        content: Text('¿Quieres eliminar los $cantidad eventos? Esta acción no se puede deshacer.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancelar')),
          TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Borrar todos')),
        ],
      ),
    );

    if (confirmar == true && mounted) {
      setState(() {
        eventos.clear();
        eventoSeleccionado = null;
      });
    }
  }

  Widget construirAccion({
    required String texto,
    required VoidCallback? onPressed,
    bool principal = false,
    IconData? icono,
  }) {
    final habilitado = onPressed != null;
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(3),
        child: TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            backgroundColor: principal ? colorPrincipal : Colors.transparent,
            foregroundColor: principal ? Colors.white : (habilitado ? Colors.blueGrey.shade800 : Colors.grey.shade400),
            padding: const EdgeInsets.symmetric(vertical: 10),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icono != null) ...[Icon(icono, size: 18), const SizedBox(width: 4)],
              Flexible(child: Text(texto, maxLines: 1, overflow: TextOverflow.ellipsis)),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestionar eventos', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: colorPrincipal,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
            child: Container(
              decoration: BoxDecoration(color: const Color(0xFFE9EEF3), borderRadius: BorderRadius.circular(24)),
              child: Row(
                children: [
                  construirAccion(
                    texto: 'Añadir',
                    principal: !modoEliminar,
                    icono: Icons.add,
                    onPressed: () {
                      setState(() {
                        modoEliminar = false;
                      });
                      abrirFormulario();
                    },
                  ),
                  construirAccion(
                    texto: 'Editar',
                    onPressed: eventoSeleccionado == null || modoEliminar
                        ? null
                        : () {
                            setState(() {
                              modoEliminar = false;
                            });
                            abrirFormulario(indice: eventoSeleccionado);
                          },
                  ),
                  construirAccion(
                    texto: 'Eliminar',
                    principal: modoEliminar,
                    icono: Icons.delete_outline,
                    onPressed: () {
                      setState(() {
                        modoEliminar = true;
                        eventoSeleccionado = null;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),

          // ACCIONES Y CONTADOR DE EVENTOS
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Colors.grey.shade100,
            child: Column(
              children: [
                if (modoEliminar) ...[
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: eventos.isEmpty ? null : confirmarEliminarTodos,
                      icon: const Icon(Icons.delete_forever),
                      label: const Text('Borrar todos los eventos'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.red.shade700,
                        side: BorderSide(color: Colors.red.shade300),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      modoEliminar ? 'Selecciona qué borrar' : 'Mis eventos',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Chip(
                      avatar: const Icon(Icons.event, size: 18),
                      label: Text('${eventos.length} eventos'),
                      backgroundColor: Colors.teal.shade100,
                    ),
                  ],
                ),
              ],
            ),
          ),

          // LISTA DINÁMICA
          Expanded(
            child: eventos.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.event_busy, size: 65, color: Colors.grey.shade400),
                        const SizedBox(height: 12),
                        Text(
                          modoEliminar ? 'No hay eventos para eliminar' : 'Todavía no hay eventos',
                          style: const TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                        if (!modoEliminar)
                          const Text('Pulsa "Añadir" para comenzar', style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: eventos.length,
                    itemBuilder: (context, index) {
                      final evento = eventos[index];

                      final seleccionado = !modoEliminar && eventoSeleccionado == index;
                      return Card(
                        elevation: 3,
                        margin: const EdgeInsets.only(bottom: 12),
                        color: seleccionado ? Colors.teal.shade50 : null,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(color: seleccionado ? colorPrincipal : Colors.transparent),
                        ),
                        child: ListTile(
                          onTap: modoEliminar
                              ? null
                              : () {
                                  setState(() {
                                    eventoSeleccionado = seleccionado ? null : index;
                                  });
                                },
                          trailing: modoEliminar
                              ? IconButton(
                                  tooltip: 'Eliminar ${evento.nombre}',
                                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                                  onPressed: () => confirmarEliminacion(index),
                                )
                              : null,
                          contentPadding: const EdgeInsets.all(12),

                          // IMAGEN REPRESENTATIVA DE LA CATEGORÍA
                          leading: Container(
                            width: 60,
                            height: 65,
                            decoration: BoxDecoration(
                              color: Colors.teal.shade50,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(obtenerIcono(evento.categoria), color: colorPrincipal, size: 35),
                          ),

                          title: Text(evento.nombre, style: const TextStyle(fontWeight: FontWeight.bold)),

                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(evento.categoria),
                              Text(evento.teatro),
                              const SizedBox(height: 4),
                              Text(evento.descripcion),
                              const SizedBox(height: 6),
                              Text('${evento.fecha} - ${evento.hora}', style: const TextStyle(fontSize: 12)),
                              const SizedBox(height: 4),
                              Text(
                                evento.esGratis ? 'Gratis' : '${evento.precio} €',
                                style: TextStyle(color: colorPrincipal, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

// FORMULARIO PARA AÑADIR EVENTOS
class AddEventDialog extends StatefulWidget {
  final Evento? eventoInicial;

  const AddEventDialog({super.key, this.eventoInicial});

  @override
  State<AddEventDialog> createState() => _AddEventDialogState();
}

class _AddEventDialogState extends State<AddEventDialog> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nombreController = TextEditingController();
  final TextEditingController precioController = TextEditingController();
  final TextEditingController descripcionController = TextEditingController();

  String? categoriaSeleccionada;
  String? teatroSeleccionado;
  bool esGratis = true;

  DateTime? fechaSeleccionada;
  TimeOfDay? horaSeleccionada;

  final Color colorPrincipal = const Color.fromARGB(255, 1, 122, 137);

  @override
  void initState() {
    super.initState();
    final evento = widget.eventoInicial;
    if (evento == null) return;

    nombreController.text = evento.nombre;
    precioController.text = evento.precio;
    descripcionController.text = evento.descripcion;
    teatroSeleccionado = evento.teatro;
    categoriaSeleccionada = evento.categoria;
    esGratis = evento.esGratis;

    final partesFecha = evento.fecha.split('/');
    if (partesFecha.length == 3) {
      fechaSeleccionada = DateTime.tryParse(
        '${partesFecha[2]}-${partesFecha[1].padLeft(2, '0')}-${partesFecha[0].padLeft(2, '0')}',
      );
    }

    final coincidenciaHora = RegExp(r'(\d{1,2}):(\d{2})').firstMatch(evento.hora);
    if (coincidenciaHora != null) {
      var hora = int.parse(coincidenciaHora.group(1)!);
      final minuto = int.parse(coincidenciaHora.group(2)!);
      final horaEnMinusculas = evento.hora.toLowerCase();
      if (horaEnMinusculas.contains('pm') && hora < 12) hora += 12;
      if (horaEnMinusculas.contains('am') && hora == 12) hora = 0;
      horaSeleccionada = TimeOfDay(hour: hora, minute: minuto);
    }
  }

  @override
  void dispose() {
    nombreController.dispose();
    precioController.dispose();
    descripcionController.dispose();
    super.dispose();
  }

  // SELECCIONAR FECHA
  Future<void> seleccionarFecha() async {
    final hoy = DateUtils.dateOnly(DateTime.now());
    final fechaInicial = fechaSeleccionada != null && !fechaSeleccionada!.isBefore(hoy) ? fechaSeleccionada! : hoy;
    final DateTime? fecha = await showDatePicker(
      context: context,
      initialDate: fechaInicial,
      firstDate: hoy,
      lastDate: DateTime(2035),
      helpText: 'Selecciona la fecha del evento',
    );

    if (fecha != null) {
      setState(() {
        fechaSeleccionada = fecha;
      });
    }
  }

  // SELECCIONAR HORA
  Future<void> seleccionarHora() async {
    final TimeOfDay? hora = await showTimePicker(context: context, initialTime: TimeOfDay.now());

    if (hora != null) {
      setState(() {
        horaSeleccionada = hora;
      });
    }
  }

  // GUARDAR EVENTO
  void guardarEvento() {
    if (!_formKey.currentState!.validate()) return;

    if (fechaSeleccionada == null || horaSeleccionada == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Selecciona una fecha y una hora')));
      return;
    }

    final evento = Evento(
      nombre: nombreController.text.trim(),
      teatro: teatroSeleccionado!,
      categoria: categoriaSeleccionada!,
      fecha:
          '${fechaSeleccionada!.day.toString().padLeft(2, '0')}/'
          '${fechaSeleccionada!.month.toString().padLeft(2, '0')}/'
          '${fechaSeleccionada!.year}',
      hora: horaSeleccionada!.format(context),
      esGratis: esGratis,
      precio: esGratis ? '0' : precioController.text.trim(),
      descripcion: descripcionController.text.trim(),
    );

    Navigator.pop(context, evento);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        widget.eventoInicial == null ? 'Añadir evento' : 'Editar evento',
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),

      content: SizedBox(
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // NOMBRE
                const Text('Título del evento', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 6),

                TextFormField(
                  controller: nombreController,
                  decoration: const InputDecoration(
                    hintText: 'Ej. Hamlet',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Introduce el título del evento';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),
                const Text('Teatro', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 6),

                DropdownButtonFormField<String>(
                  value: teatroSeleccionado,
                  decoration: const InputDecoration(
                    hintText: 'Selecciona un teatro',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  ),
                  items: ['Teatro Guimerá', 'Teatro Leal', 'Cine Víctor', 'Multicines'].map((teatro) {
                    return DropdownMenuItem(value: teatro, child: Text(teatro));
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      teatroSeleccionado = value;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Selecciona un teatro';
                    }
                    return null;
                  },
                ),
                // CATEGORÍA
                const Text('Categoría', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 6),

                DropdownButtonFormField<String>(
                  value: categoriaSeleccionada,
                  decoration: const InputDecoration(
                    hintText: 'Selecciona una categoría',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  ),
                  items: ['Teatro', 'Música', 'Cine', 'Danza'].map((categoria) {
                    return DropdownMenuItem(value: categoria, child: Text(categoria));
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      categoriaSeleccionada = value;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Selecciona una categoría';
                    }
                    return null;
                  },
                ),

                // VISTA PREVIA DE LA CATEGORÍA
                if (categoriaSeleccionada != null) ...[
                  const SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: Colors.teal.shade50, borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        const Icon(Icons.image, color: Colors.teal),
                        const SizedBox(width: 10),
                        Text('Imagen de $categoriaSeleccionada', style: const TextStyle(fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ),
                ],

                const SizedBox(height: 16),

                // FECHA
                const Text('Fecha y hora', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 6),

                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: seleccionarFecha,
                        icon: const Icon(Icons.calendar_month),
                        label: Text(
                          fechaSeleccionada == null
                              ? 'Fecha'
                              : '${fechaSeleccionada!.day}/'
                                    '${fechaSeleccionada!.month}/'
                                    '${fechaSeleccionada!.year}',
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: seleccionarHora,
                        icon: const Icon(Icons.access_time),
                        label: Text(horaSeleccionada == null ? 'Hora' : horaSeleccionada!.format(context)),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // TIPO DE EVENTO
                const Text('Tipo', style: TextStyle(fontWeight: FontWeight.bold)),

                RadioListTile<bool>(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Gratis'),
                  value: true,
                  groupValue: esGratis,
                  activeColor: colorPrincipal,
                  onChanged: (value) {
                    setState(() {
                      esGratis = value!;
                    });
                  },
                ),

                RadioListTile<bool>(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('De pago'),
                  value: false,
                  groupValue: esGratis,
                  activeColor: colorPrincipal,
                  onChanged: (value) {
                    setState(() {
                      esGratis = value!;
                    });
                  },
                ),

                // PRECIO
                if (!esGratis) ...[
                  const Text('Precio (€)', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 6),
                  TextFormField(
                    controller: precioController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(hintText: 'Ej. 10,00 €', border: OutlineInputBorder()),
                    validator: (value) {
                      if (!esGratis && (value == null || value.trim().isEmpty)) {
                        return 'Introduce el precio';
                      }

                      if (!esGratis && double.tryParse(value!.trim().replaceAll(',', '.')) == null) {
                        return 'Introduce un precio válido';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                ],

                // DESCRIPCIÓN
                const Text('Descripción', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 6),

                TextFormField(
                  controller: descripcionController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    hintText: 'Escribe una breve descripción...',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Introduce una descripción';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
      ),

      // BOTONES DEL MODAL
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),

        ElevatedButton(
          onPressed: guardarEvento,
          style: ElevatedButton.styleFrom(backgroundColor: colorPrincipal, foregroundColor: Colors.white),
          child: Text(widget.eventoInicial == null ? 'Guardar evento' : 'Guardar cambios'),
        ),
      ],
    );
  }
}
