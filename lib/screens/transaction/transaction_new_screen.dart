import 'package:drilly/bloc/transaction_new/transaction_new_bloc.dart';
import 'package:drilly/bloc/transaction_new/transaction_new_event.dart';
import 'package:drilly/bloc/transaction_new/transaction_new_state.dart';
import 'package:drilly/generated/l10n.dart';
import 'package:drilly/model/category.dart';
import 'package:drilly/utils/const_res.dart';
import 'package:drilly/utils/custom/custom_widget.dart';
import 'package:drilly/utils/date_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionNewScreen extends StatefulWidget {
  const TransactionNewScreen({super.key});

  @override
  State<TransactionNewScreen> createState() => _TransactionNewScreenState();
}

class _TransactionNewScreenState extends State<TransactionNewScreen> {
  final _formKey = GlobalKey<FormState>();

  Future<void> _pickDate(BuildContext context, TransactionNewBloc bloc) async {
    final now = DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      final pickedTime = await showTimePicker(
        // ignore: use_build_context_synchronously
        context: context,
        initialTime: TimeOfDay.fromDateTime(now),
      );

      if (pickedTime != null) {
        final fullDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        bloc.add(UpdateTransactionDate(DateTimeUtils.getDateTimeString(fullDateTime)));
      }
    }
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
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      controller: bloc.nameEC,
                      decoration: InputDecoration(labelText: S.current.transactionName),
                      validator: (val) =>
                      val == null || val.isEmpty ? S.current.cannotBeEmpty : null,
                    ),
                    TextFormField(
                      controller: bloc.amountEC,
                      decoration: InputDecoration(labelText: S.current.amount),
                      keyboardType: TextInputType.number,
                      validator: (val) {
                        final parsed = double.tryParse(val ?? '');
                        if (parsed == null || parsed <= 0) return S.current.invalidAmount;
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      value: state.selectedType,
                      items: ConstRes.transactionTypes
                          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                          .toList(),
                      decoration: InputDecoration(labelText: S.current.type),
                      onChanged: (val) {
                        bloc.add(UpdateSelectedType(val));
                      },
                      validator: (val) => val == null ? S.current.selectTransactionType : null,
                    ),
                    DropdownButtonFormField<Category>(
                      isExpanded: true,
                      value: state.selectedCategory,
                      items: state.categories
                          .map(
                            (cate) => DropdownMenuItem<Category>(
                          value: cate,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 20,
                                height: 20,
                                child: CustomNetworkImage(cate.icon.toString())
                              ),
                              const SizedBox(width: 8),
                              Text(cate.name),
                            ],
                          ),
                        ),
                      )
                          .toList(),
                      decoration: InputDecoration(labelText: S.current.category),
                      onChanged: (val) {
                        if (val != null) {
                          bloc.add(UpdateSelectedCategory(val));
                        }
                      },
                      validator: (val) =>
                      val == null ? S.current.selectCategory : null,
                    ),

                    DropdownButtonFormField<String>(
                      value: state.selectedPayment,
                      items: ConstRes.transactionPayments
                          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                          .toList(),
                      decoration: InputDecoration(labelText: S.current.paymentMethod),
                      onChanged: (val) {
                        bloc.add(UpdateSelectedPayment(val));
                      },
                      validator: (val) => val == null ? S.current.selectPaymentMethod : null,
                    ),
                    const SizedBox(height: 12),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        state.transactionDate != null
                            ? '${S.current.date}: ${state.transactionDate}'
                            : S.current.chooseDate,
                      ),
                      trailing: const Icon(Icons.calendar_today),
                      onTap: () => _pickDate(context, bloc),
                    ),
                    SwitchListTile(
                      title: Text(S.current.recurring),
                      contentPadding: EdgeInsets.zero,
                      value: state.isRecurring,
                      onChanged: (val) {
                        bloc.add(UpdateIsRecurring(val));
                      },
                    ),
                    if (state.isRecurring)
                      TextFormField(
                        initialValue: state.isRepeatCycle,
                        decoration: InputDecoration(labelText: S.current.repeatCycle),
                        onChanged: (val) {
                          bloc.add(UpdateRepeatCycle(val));
                        },
                      ),
                    TextFormField(
                      controller: bloc.noteEC,
                      decoration: InputDecoration(labelText: S.current.note),
                      maxLines: 2,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: (){
                        if (_formKey.currentState?.validate() != true) return;

                        final name = bloc.nameEC.text.trim();
                        final amount = double.tryParse(bloc.amountEC.text.trim());
                        final note = bloc.noteEC.text.trim();
                        final type = bloc.state.selectedType;
                        final category = bloc.state.selectedCategory;
                        final payment = bloc.state.selectedPayment;
                        final date = bloc.state.transactionDate;
                        final isRecurring = bloc.state.isRecurring;
                        final repeatCycle = bloc.state.isRepeatCycle ?? '';

                        if (type == null ||
                            category == null ||
                            payment == null ||
                            date == null ||
                            amount == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(S.current.selectAllFields)),
                          );
                          return;
                        }

                        bloc.add(SubmitTransaction(
                          name: name,
                          amount: amount,
                          note: note,
                          type: type,
                          category: state.selectedCategory!.id.toString(),
                          payment: payment,
                          transactionDate: date,
                          isRecurring: isRecurring,
                          repeatCycle: repeatCycle,
                          location: '', // Thêm trường location nếu có dữ liệu
                        ));
                      },
                      child: Text(S.current.createTransaction),
                    ),
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
