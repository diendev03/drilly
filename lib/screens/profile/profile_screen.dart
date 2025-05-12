import 'package:drilly/bloc/profile/profile_bloc.dart';
import 'package:drilly/bloc/profile/profile_event.dart';
import 'package:drilly/bloc/profile/profile_state.dart';
import 'package:drilly/generated/l10n.dart';
import 'package:drilly/utils/app_res.dart';
import 'package:drilly/utils/color_res.dart';
import 'package:drilly/utils/custom/custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({
    super.key,
  });

  final List<DropdownAction> actions = [
    DropdownAction(
      title: S.current.logout,
      icon: Icons.exit_to_app,
      action: () => AppRes.logout(),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return BlocProvider(
        create: (context) => ProfileBloc()..add(GetInfo()),
    child: BlocBuilder<ProfileBloc, ProfileState>(
    builder: (context, state) {
      ProfileBloc bloc = context.read<ProfileBloc>();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50, right: 20, left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: CustomDropdownMenu(
                  actions: actions, child: const Icon(Icons.settings)),
            ),
            const Center(
                child: ClipOval(
              child: SizedBox(
                height: 150,
                width: 150,
                child: CustomNetworkImage("url"),
              ),
            )),
            const SizedBox(height: 16),
            const Center(
              child: Text(
                'Catherine Massey',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildInfoColumn('80', 'Posts'),
                _buildInfoColumn('110', 'Followers'),
                _buildInfoColumn('152', 'Following'),
              ],
            ),
            const SizedBox(height: 16),
            // Nút Message và Follow
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomButton(
                    width: screenSize.width * .25,
                    text: S.current.message,
                    backgroundColor: ColorRes.amber),
                CustomButton(
                    width: screenSize.width * .25,
                    text: S.current.follow,
                    backgroundColor: ColorRes.amber),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );

    },
    ),
    );
  }

  Widget _buildInfoColumn(String value, String label) {
    return Column(
      children: [
        Text(value,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(fontSize: 16, color: Colors.grey)),
      ],
    );
  }
}
