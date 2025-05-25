import 'package:drilly/bloc/home/home_bloc.dart';
import 'package:drilly/bloc/home/home_event.dart';
import 'package:drilly/bloc/home/home_state.dart';
import 'package:drilly/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pie_chart/pie_chart.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc()..add(LoadHome()),
      child: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
        return Scaffold(
            body: Padding(
                padding: const EdgeInsets.only(top: 50, right: 20, left: 20),
                child: RefreshIndicator(
                    onRefresh: () async {},
                    child: Column(
                      children: [
                        PieChart(
                          dataMap: {
                            S.current.income: state.incomeTotal,
                            S.current.expense: state.expenseTotal,
                          },
                          animationDuration: const Duration(milliseconds: 800),
                          chartRadius: MediaQuery.of(context).size.width / 2.2,
                          colorList: const [Colors.green, Colors.red],
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
                        )

                      ],
                    ))));
      }),
    );
  }
}
