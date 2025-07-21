import 'package:drilly/bloc/home/home_bloc.dart';
import 'package:drilly/bloc/home/home_event.dart';
import 'package:drilly/bloc/home/home_state.dart';
import 'package:drilly/generated/l10n.dart';
import 'package:drilly/screens/home/widget/detail_chart.dart';
import 'package:drilly/screens/home/widget/last_week_chart.dart';
import 'package:drilly/screens/home/widget/overview.dart';
import 'package:drilly/screens/transaction/transaction_new_screen.dart';
import 'package:drilly/utils/asset_res.dart';
import 'package:drilly/utils/color_res.dart';
import 'package:drilly/utils/custom/custom_widget.dart';
import 'package:drilly/utils/string_res.dart';
import 'package:drilly/utils/style_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => HomeBloc()..add(LoadHome()),
      child: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
        final bloc = context.read<HomeBloc>();
        return Scaffold(
            body: Padding(
                padding: const EdgeInsets.all(20),
                child: Stack(
                  children: [
                    RefreshIndicator(
                      onRefresh: () async {
                        bloc.add(LoadHome());
                      },
                      child: ListView(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Overview(
                                expenseTotal: state.expenseTotal,
                                incomeTotal: state.incomeTotal,
                              ),
                              Text(S.current.totalIncomeExpenseLastWeek,
                                  style: StyleRes.header),
                              LastWeekChart(transactions: state.transactions),
                              const HSpace(),
                              Text(S.current.transactionFilter,
                                  style: StyleRes.header),
                              Row(
                                children: [
                                  Expanded(child: CustomDateField(
                                    label: S.current.from,
                                    dateString: state.startDate,
                                    onChanged: (date) {
                                      bloc.add(FilterTransaction(
                                          startDate: date));
                                    },
                                  ),),
                                  const WSpace(),
                                  Expanded(child: CustomDateField(
                                    dateString: S.current.to,
                                    label: state.startDate,
                                    onChanged: (date) {
                                      bloc.add(FilterTransaction(
                                          startDate: date));
                                    },
                                  ),),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(child: ToggleButtons(
                                    borderRadius: BorderRadius.circular(4),
                                    isSelected: [
                                      state.isIncome,
                                      !state.isIncome,
                                    ],
                                    onPressed: (index) {
                                      final newIsIncome = index == 0;
                                     bloc.add(
                                        FilterTransaction(isIncome: newIsIncome),
                                      );
                                    },
                                    selectedColor: Colors.white,
                                    fillColor: ColorRes.primary,
                                    color: Colors.black54,
                                    constraints: const BoxConstraints(minWidth: 80, minHeight: 36),
                                    children: const [
                                      Text('Income'),
                                      Text('Expense'),
                                    ],
                                  )),
                                  const WSpace(),
                                  Expanded(child: CategoryPicker(
                                    categories: state.categories.where((e) => e.type == (state.isIncome ? 'income' : 'expense')).toList(),
                                    selectedId: state.selCate,
                                    allowAll: true,
                                    onChanged: (id) =>bloc.add(FilterTransaction(category: id)),
                                  )),
                                ],
                              ),
                              const HSpace(30),
                              DetailTransactionChart(
                                transactions: state.filteredTransactions.where((e) => e.type == (state.isIncome ? 'income' : 'expense')).toList(),
                                categories: state.categories,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: height * .1,
                      right: 0,
                      child: InkWell(
                          onTap: () => Get.to(() => const TransactionNewScreen()),
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(45),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            alignment: Alignment.center,
                            child: Image.asset(
                              AssetRes.icNewTransaction,
                              fit: BoxFit.cover,
                              color: ColorRes.primary,
                              width: 25,
                              height: 25,
                            ),
                          )),
                    ),
                  ],
                )));
      }),
    );
  }
}
