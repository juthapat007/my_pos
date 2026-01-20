import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_02/features/products/presentation/bloc/products_bloc.dart';
import 'package:pos_02/features/products/presentation/bloc/products_event.dart';

class Summary extends StatelessWidget {
  const Summary({super.key});

  String _formatNumber(num number) {
    return number.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade100,
      child: BlocBuilder<ProductsBloc, ProductsState>(
        builder: (context, state) {
          if (state is! ProductsLoaded) {
            return const Center(child: Text('โหลดสินค้าก่อน'));
          }

          final cart = state.cart;
          final products = state.products;

          // Calculate totals
          double subtotal = 0;
          cart.forEach((productId, quantity) {
            final product = products.firstWhere((p) => p.id == productId);
            subtotal += product.price * quantity;
          });

          final tax = subtotal * 0.07; // 7% VAT
          final total = subtotal + tax;

          return Column(
            children: [
              // Header
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Text(
                  'ตะกร้าสินค้า',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),

              // Cart Items
              Expanded(
                child: cart.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.shopping_cart_outlined,
                              size: 64,
                              color: Colors.grey.shade400,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'ตะกร้าว่าง',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: cart.length,
                        itemBuilder: (context, index) {
                          final productId = cart.keys.elementAt(index);
                          final quantity = cart[productId]!;
                          final product = products.firstWhere(
                            (p) => p.id == productId,
                          );

                          return Card(
                            margin: const EdgeInsets.only(bottom: 8),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          product.name,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          '฿${_formatNumber(product.price)} × $quantity',
                                          style: TextStyle(
                                            color: Colors.grey.shade600,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Column(
                                    children: [
                                      IconButton(
                                        icon: const Icon(
                                          Icons.add_circle,
                                          color: Colors.blue,
                                        ),
                                        onPressed: () {
                                          context.read<ProductsBloc>().add(
                                            AddToCartEvent(product),
                                          );
                                        },
                                      ),
                                      Text(
                                        '฿${_formatNumber(product.price * quantity)}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green,
                                        ),
                                      ),
                                      IconButton(
                                        icon: const Icon(
                                          Icons.remove_circle,
                                          color: Colors.red,
                                        ),
                                        onPressed: () {
                                          context.read<ProductsBloc>().add(
                                            RemoveFromCartEvent(product),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),

              // Summary Section
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _PriceRow(
                      label: 'รวม',
                      value: '฿${_formatNumber(subtotal)}',
                    ),

                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: cart.isEmpty
                            ? null
                            : () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text('ยืนยันการชำระเงิน'),
                                    content: Text(
                                      'ยอดชำระ: ฿${_formatNumber(total)}',
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text('ยกเลิก'),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          context.read<ProductsBloc>().add(
                                            ClearCartEvent(),
                                          );
                                          Navigator.pop(context);
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            const SnackBar(
                                              content: Text('ชำระเงินสำเร็จ!'),
                                            ),
                                          );
                                        },
                                        child: const Text('ยืนยัน'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                        child: const Text(
                          'ชำระเงิน',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    if (cart.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      TextButton(
                        onPressed: () {
                          context.read<ProductsBloc>().add(ClearCartEvent());
                        },
                        child: const Text('ล้างตะกร้า'),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _PriceRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isTotal;

  const _PriceRow({
    required this.label,
    required this.value,
    this.isTotal = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 18 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 20 : 16,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: isTotal ? Colors.green : Colors.black,
          ),
        ),
      ],
    );
  }
}
