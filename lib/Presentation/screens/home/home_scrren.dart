import 'package:flutter/material.dart';
import 'package:productos_app/Presentation/screens/screens.dart';
import 'package:productos_app/infraestructure/services/services.dart';
import 'package:productos_app/Presentation/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../../../domain/models/models.dart';
import '../../../infraestructure/services/auth_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productsService = Provider.of<ProductsService>(context);
    final authService = Provider.of<AuthService>(context, listen: false);

    if (productsService.isLoading) return const LoadingScreen();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Autos'),

        leading: IconButton(
          icon: const Icon( Icons.login_outlined ),
          onPressed: () {

            authService.logout();
            Navigator.pushReplacementNamed(context, 'login');

          },
        ),
        actions: [
          
          IconButton(
            icon: const Icon(Icons.chat),
            onPressed: () {
              // Aquí puede agregar la lógica para mostrar la ayuda
               Navigator.pushNamed(context, 'chat');
            },
          ),
        ],
      ),
      body: ListView.builder(
          itemCount: productsService.products.length,
          itemBuilder: (BuildContext context, int index) => GestureDetector(
                onTap: () {
                  productsService.selectedProdct =
                      productsService.products[index].copy();
                  Navigator.pushNamed(context, 'product');
                },
                child: ProductCard(
                  product: productsService.products[index],
                ),
              )),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          productsService.selectedProdct =
              Product(available: false, name: '', price: 0);
          Navigator.pushNamed(context, 'product');
        },
      ),
    );
  }
}
