import 'package:flutter/material.dart';

class PagoScreen extends StatefulWidget {
  final String nombreProducto;
  final String precio;

  const PagoScreen({
    super.key,
    required this.nombreProducto,
    required this.precio,
  });

  @override
  _PagoScreenState createState() => _PagoScreenState();
}

class _PagoScreenState extends State<PagoScreen> {
  final TextEditingController descuentoController = TextEditingController();
  String metodoPagoSeleccionado = "PayPal";

  final TextEditingController numeroTarjetaController = TextEditingController();
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController caducidadController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pago'),
        backgroundColor: Colors.brown.shade600,
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.brown.shade100, Colors.brown.shade50],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Producto: ${widget.nombreProducto}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown.shade800,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Precio: ${widget.precio}€',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.green.shade700,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Selecciona un método de pago:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown,
                ),
              ),
              const SizedBox(height: 8),
              DropdownButton<String>(
                value: metodoPagoSeleccionado,
                onChanged: (String? nuevoMetodo) {
                  setState(() {
                    metodoPagoSeleccionado = nuevoMetodo!;
                  });
                },
                items: <String>['PayPal', 'Bizum', 'Efectivo', 'Visa']
                    .map<DropdownMenuItem<String>>((String metodo) {
                  return DropdownMenuItem<String>(
                    value: metodo,
                    child: Text(metodo, style: TextStyle(color: Colors.brown.shade800)),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              if (metodoPagoSeleccionado == 'Visa') ...[
                const Text(
                  'Datos de la Tarjeta:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: numeroTarjetaController,
                  decoration: const InputDecoration(
                    labelText: 'Número de Tarjeta',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: nombreController,
                  decoration: const InputDecoration(
                    labelText: 'Nombre y Apellidos',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: caducidadController,
                  decoration: const InputDecoration(
                    labelText: 'Fecha de Caducidad (MM/AA)',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.datetime,
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: cvvController,
                  decoration: const InputDecoration(
                    labelText: 'CVV',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ],
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  // Manejo del pago
                },
                child: const Text('Confirmar Pago'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown.shade600,
                  foregroundColor: Colors.brown.shade50,
                  minimumSize: const Size(double.infinity, 50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
