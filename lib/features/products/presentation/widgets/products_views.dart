import 'package:flutter/material.dart';
import 'package:pos_02/features/products/presentation/bloc/products_bloc.dart';

class ProductsView extends StatelessWidget {
  const ProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'รายการสินค้า',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  title: Text('สินค้า ${index + 1}'),
                  subtitle: const Text('ราคา 100 บาท'),
                  trailing: const Icon(Icons.add),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
