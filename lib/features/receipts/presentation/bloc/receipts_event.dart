part of 'receipts_bloc.dart';

@immutable
sealed class ReceiptsEvent {}

class LoadReceiptsEvent extends ReceiptsEvent {}
