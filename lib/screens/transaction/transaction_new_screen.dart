import 'package:drilly/bloc/transaction_new/transaction_new_bloc.dart';
import 'package:drilly/bloc/transaction_new/transaction_new_event.dart';
import 'package:drilly/bloc/transaction_new/transaction_new_state.dart';
import 'package:drilly/generated/l10n.dart';
import 'package:drilly/utils/const_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionNewScreen extends StatefulWidget {
   const TransactionNewScreen({super.key});

  @override
  State<TransactionNewScreen> createState() => _TransactionNewScreenState();
}

class _TransactionNewScreenState extends State<TransactionNewScreen> {
  final _formKey = GlobalKey<FormState>();


  void submit() {
    final bloc = context.read<TransactionNewBloc>();
    if (_formKey.currentState?.validate() != true) return;

    final name = bloc.nameEC.text.trim();
    final amount = double.tryParse(bloc.amountEC.text.trim());
    final note = bloc.noteEC.text.trim();
    final type = bloc.state.selectedType;
    final category = bloc.state.selectedCategory;
    final payment = bloc.state.selectedPayment;
    final date = bloc.state.transactionDate;

    if (type == null || category == null || payment == null || date == null || amount == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("S.current.selectAllFields")),
      );
      return;
    }

    // Dispatch event để xử lý tạo giao dịch
    bloc.add(SubmitTransaction(
      name: name,
      amount: amount,
      note: note,
      type: type,
      category: category,
      payment: payment,
      transactionDate: date,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TransactionNewBloc()..add(Initialize()),
      child: BlocBuilder<TransactionNewBloc, TransactionNewState>(
        builder: (context, state) {
          final bloc = context.read<TransactionNewBloc>();
          return Scaffold(
            appBar: AppBar(title: Text(S.current.addTransaction)),
            body: Padding(
              padding:  const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      controller: bloc.nameEC,
                      decoration:  InputDecoration(labelText: S.current.transactionName),
                      validator: (val) => val == null || val.isEmpty ? 'Không để trống' : null,
                    ),
                    TextFormField(
                      controller: bloc.amountEC,
                      decoration:  const InputDecoration(labelText: 'Số tiền'),
                      keyboardType: TextInputType.number,
                      validator: (val) {
                        final parsed = double.tryParse(val ?? '');
                        if (parsed == null || parsed <= 0) return 'Số tiền không hợp lệ';
                        return null;
                      },
                    ),
                     const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      value: state.selectedType,
                      items: ConstRes.transactionTypes.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                      decoration:  const InputDecoration(labelText: 'Loại'),
                      onChanged: (val) {},
                      validator: (val) => val == null ? 'Chọn loại giao dịch' : null,
                    ),
                    DropdownButtonFormField<String>(
                      value: state.selectedCategory,
                      items: ConstRes.transactionCategories.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                      decoration:  InputDecoration(labelText: S.current.category),
                      onChanged: (val) {},
                      validator: (val) => val == null ? S.current.selectCategory : null,
                    ),
                    DropdownButtonFormField<String>(
                      value: state.selectedPayment,
                      items: ConstRes.transactionPayments.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                      decoration:  InputDecoration(labelText: S.current.paymentMethod),
                      onChanged: (val) {},
                      validator: (val) => val == null ? S.current.selectPaymentMethod : null,
                    ),
                     const SizedBox(height: 12),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        state.transactionDate != null
                            ? '${S.current.date}: ${state.transactionDate!.day}/${state.transactionDate!.month}/${state.transactionDate!.year}'
                            : S.current.chooseYourBirthday,
                      ),
                      trailing:  const Icon(Icons.calendar_today),
                      onTap: () async {},
                    ),
                    TextFormField(
                      controller: bloc.noteEC,
                      decoration:  InputDecoration(labelText: S.current.note),
                      maxLines: 2,
                    ),
                     const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        final bloc = context.read<TransactionNewBloc>();
                        if (_formKey.currentState?.validate() != true) return;

                        final name = bloc.nameEC.text.trim();
                        final amount = double.tryParse(bloc.amountEC.text.trim());
                        final note = bloc.noteEC.text.trim();
                        final type = bloc.state.selectedType;
                        final category = bloc.state.selectedCategory;
                        final payment = bloc.state.selectedPayment;
                        final date = bloc.state.transactionDate;

                        if (type == null || category == null || payment == null || date == null || amount == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("hahahahaa"
                                )),
                          );
                          return;
                        }

                        bloc.add(SubmitTransaction(
                          name: name,
                          amount: amount,
                          note: note,
                          type: type,
                          category: category,
                          payment: payment,
                          transactionDate: date,
                        ));
                      },
                      child: Text(S.current.createTransaction),
                    )

                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
