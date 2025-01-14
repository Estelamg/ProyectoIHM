import 'package:flutter/material.dart';

class PagoScreen extends StatelessWidget {
  final String nombreProducto;
  final String precio;

  const PagoScreen({
    super.key,
    required this.nombreProducto,
    required this.precio,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController metodoPagoController = TextEditingController();
    final TextEditingController descuentoController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pago'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Producto: $nombreProducto',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Precio: $precio€',
              style: const TextStyle(fontSize: 18, color: Colors.green),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: metodoPagoController,
              decoration: const InputDecoration(
                labelText: 'Método de Pago',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: descuentoController,
              decoration: const InputDecoration(
                labelText: 'Código de Descuento',
                border: OutlineInputBorder(),
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                final metodoPago = metodoPagoController.text;
                final descuento = descuentoController.text;

                if (descuento.isNotEmpty) {
                  print('Código de descuento ingresado: $descuento');
                }

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Pago realizado con método: $metodoPago y descuento: $descuento'),
                  ),
                );
              },
              child: const Text('Confirmar Pago'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
