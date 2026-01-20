import 'package:flutter/material.dart';
import 'package:pos_02/features/receipts/repository/models/receipt_model.dart';

class ReceiptCard extends StatelessWidget {
  final ReceiptModel receipt;

  const ReceiptCard({super.key, required this.receipt});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            /// LEFT
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'บิล #${receipt.receiptNo}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    receipt.createdAtFormatted,
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),

            /// RIGHT
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '฿${receipt.totalFormatted}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${receipt.totalAmount} รายการ',
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
