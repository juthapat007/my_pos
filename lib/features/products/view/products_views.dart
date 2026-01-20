import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_02/features/products/presentation/bloc/products_bloc.dart';
import 'package:pos_02/features/products/presentation/bloc/products_event.dart';
import 'package:pos_02/features/products/repository/models/product_model.dart';

class ProductsView extends StatelessWidget {
  const ProductsView({super.key});

  String _formatNumber(num number) {
    return number.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: BlocBuilder<ProductsBloc, ProductsState>(
        builder: (context, state) {
          if (state is ProductsLoading) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('กำลังโหลดสินค้า...'),
                ],
              ),
            );
          }

          if (state is ProductsError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(state.message),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<ProductsBloc>().add(ProductsLoadEvent());
                    },
                    child: const Text('ลองใหม่'),
                  ),
                ],
              ),
            );
          }

          if (state is ProductsLoaded) {
            final products = state.products;

            if (products.isEmpty) {
              return const Center(child: Text('ไม่มีสินค้า'));
            }

            return Column(
              children: [
                // Header
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    border: Border(
                      bottom: BorderSide(color: Colors.grey.shade300),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'รายการสินค้า',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'ทั้งหมด ${products.length} รายการ',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ),
                ),

                // Products Grid with Lazy Loading
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(12),
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 220, // ความกว้างสูงสุดของ card
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          childAspectRatio: 1.00,
                        ),
                    itemCount: products.length,
                    itemBuilder: (_, i) => _ProductCard(
                      product: products[i],
                      formatNumber: _formatNumber,
                    ),
                  ),
                ),
              ],
            );
          }

          return const Center(child: Text('ยินดีต้อนรับ'));
        },
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  final ProductModel product;
  final String Function(num) formatNumber;

  const _ProductCard({required this.product, required this.formatNumber});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        final bool isCompact = width < 160;
        final bool isMedium = width >= 160 && width < 240;

        return Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              context.read<ProductsBloc>().add(AddToCartEvent(product));

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('เพิ่ม ${product.name} ลงตะกร้า'),
                  duration: const Duration(seconds: 1),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            child: Padding(
              padding: EdgeInsets.all(isCompact ? 6 : 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// NAME
                  Text(
                    product.name,
                    maxLines: isCompact ? 1 : 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: isCompact ? 13 : 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  if (!isCompact) ...[
                    const SizedBox(height: 4),
                    Text(
                      product.categoryName,
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],

                  const SizedBox(height: 6),

                  /// STOCK
                  Row(
                    children: [
                      Icon(
                        Icons.inventory,
                        size: isCompact ? 12 : 14,
                        color: product.amount > 100
                            ? Colors.green
                            : Colors.orange,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          'คงเหลือ ${formatNumber(product.amount)}',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: isCompact ? 11 : 12,
                            color: product.amount > 100
                                ? Colors.green
                                : Colors.orange,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const Spacer(),

                  /// PRICE
                  Text(
                    '฿${formatNumber(product.price)}',
                    style: TextStyle(
                      fontSize: isCompact ? 14 : 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

//เดี๋ยวค่อยกลับมาทำ
// Bills View (Placeholder)
// class BillsView extends StatelessWidget {
//   const BillsView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.white,
//       child: const Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(Icons.receipt_long, size: 64, color: Colors.grey),
//             SizedBox(height: 16),
//             Text(
//               'หน้าบิล',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 8),
//             Text('กำลังพัฒนา...'),
//           ],
//         ),
//       ),
//     );
//   }
// }
