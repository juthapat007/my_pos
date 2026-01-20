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

        if (state is ReceiptsLoaded) {
          if (state.receipts.isEmpty) {
            return const Center(child: Text('ไม่มีข้อมูลบิล'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: state.receipts.length,
            itemBuilder: (context, index) {
              return ReceiptCard(receipt: state.receipts[index]);
            },
          );
        }

        if (state is ReceiptsError) {
          return Center(child: Text(state.message));
        }

        return const SizedBox();
      },
    );
  }
}
