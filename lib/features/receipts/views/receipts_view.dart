import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_02/features/receipts/presentation/bloc/receipts_bloc.dart';
import 'package:pos_02/features/receipts/views/receipt_card.dart';

class ReceiptsView extends StatelessWidget {
  const ReceiptsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReceiptsBloc, ReceiptsState>(
      builder: (context, state) {
        if (state is ReceiptsLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is ReceiptsError) {
          return Center(
            child: Text(
              'ไม่สามารถโหลดรายการบิลได้',
              style: TextStyle(color: Colors.red.shade600),
            ),
          );
        }

        if (state is ReceiptsLoaded) {
          if (state.receipts.isEmpty) {
            return const Center(child: Text('ยังไม่มีบิล'));
          }

          //เดี๋ยวจัดหน้า ui ทีหลังสะอาดๆ
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'รายการบิลย้อนหลัง',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),

                Expanded(
                  child: ListView.separated(
                    itemCount: state.receipts.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      final receipt = state.receipts[index];
                      return ReceiptCard(receipt: receipt);
                    },
                  ),
                ),
              ],
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
