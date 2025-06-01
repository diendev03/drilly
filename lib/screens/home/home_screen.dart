import 'package:drilly/bloc/home/home_bloc.dart';
import 'package:drilly/bloc/home/home_event.dart';
import 'package:drilly/bloc/home/home_state.dart';
import 'package:drilly/generated/l10n.dart';
import 'package:drilly/screens/transaction/transaction_new_screen.dart';
import 'package:drilly/utils/asset_res.dart';
import 'package:drilly/utils/color_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:pie_chart/pie_chart.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => HomeBloc()..add(LoadHome()),
      child: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
        return Scaffold(
            body: Padding(
                padding: const EdgeInsets.only(top: 50, right: 20, left: 20),
                child: Stack(
                  children: [
                    RefreshIndicator(
                      onRefresh: () async {},
                      child: ListView(
                        children: [
                          Column(
                            children: [
                              PieChart(
                                dataMap: {
                                  S.current.income: state.incomeTotal,
                                  S.current.expense: state.expenseTotal,
                                },
                                animationDuration:
                                    const Duration(milliseconds: 800),
                                chartRadius:
                                    MediaQuery.of(context).size.width / 2.2,
                                colorList: const [ColorRes.primary, ColorRes.accent],
                                chartType: ChartType.ring,
                                ringStrokeWidth: 32,
                                legendOptions: const LegendOptions(
                                  showLegendsInRow: false,
                                  legendPosition: LegendPosition.right,
                                ),
                                chartValuesOptions: const ChartValuesOptions(
                                  showChartValuesInPercentage: true,
                                  showChartValuesOutside: false,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: height * .1,
                      right: 0,
                      child: InkWell(
                          onTap: () =>
                              Get.to(() => const TransactionNewScreen()),
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
