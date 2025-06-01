import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'transaction_new_event.dart';
import 'transaction_new_state.dart';

class TransactionNewBloc extends Bloc<TransactionNewEvent, TransactionNewState> {
  final TextEditingController nameEC = TextEditingController();
  final TextEditingController amountEC = TextEditingController();
  final TextEditingController noteEC = TextEditingController();

  TransactionNewBloc() : super(const TransactionNewState()) {
    on<Initialize>((event, emit) {
    });
    on<SubmitTransaction>((event, emit) {
    });
  }

  void dispose() {
    nameEC.dispose();
    amountEC.dispose();
    noteEC.dispose();
  }
}
