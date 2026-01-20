part of 'receipts_bloc.dart';

@immutable
sealed class ReceiptsState {}

final class ReceiptsInitial extends ReceiptsState {}

class ReceiptsLoading extends ReceiptsState {}

class ReceiptsLoaded extends ReceiptsState {
  final List<ReceiptModel> receipts;
  ReceiptsLoaded(this.receipts);
}

final class ReceiptsError extends ReceiptsState {
  final String message;
  ReceiptsError({required this.message});
}
