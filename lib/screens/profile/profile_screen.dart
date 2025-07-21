import 'package:drilly/bloc/profile/profile_bloc.dart';
import 'package:drilly/bloc/profile/profile_event.dart';
import 'package:drilly/bloc/profile/profile_state.dart';
import 'package:drilly/generated/l10n.dart';
import 'package:drilly/model/profile.dart';
import 'package:drilly/screens/profile/profile_edit_screen.dart';
import 'package:drilly/utils/app_res.dart';
import 'package:drilly/utils/color_res.dart';
import 'package:drilly/utils/custom/custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc()..add(GetInfo()),
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          context.read<ProfileBloc>();
          Profile profile = state.profile ?? Profile.empty();
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              actions: [
                CustomDropdownMenu(
                    actions: [
                      DropdownAction(
                        title: S.current.editProfile,
                        icon: Icons.edit,
                        action: () => Get.to(()=>ProfileEditScreen(profile: profile)),
                      ),
                      DropdownAction(
                        title: S.current.logout,
                        icon: Icons.exit_to_app,
                        action: () => AppRes.logout(),
                      ),
                    ],
                    child: const Icon(
                      Icons.settings,
                      color: ColorRes.black,
                    )),
                const WSpace(20)
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () =>
                        Get.to(() => ImageFromUrl(imageUrl: profile.avatar)),
                    child: Center(
                      child: ClipOval(
                        child: SizedBox(
                          height: 150,
                          width: 150,
                          child: CustomNetworkImage(profile.avatar),
                        ),
                      ),
                    ),
                  ),
                  const HSpace(15),
                  Center(
                    child: Text(
                      profile.name,
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildInfoColumn(
                          profile.achievements, S.current.achievements),
                      _buildInfoColumn(profile.follower, S.current.follower),
                      _buildInfoColumn(profile.following, S.current.following),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoColumn(int value, String label) {
    return Column(
      children: [
        Text(value.toString(),
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(fontSize: 16, color: Colors.grey)),
      ],
    );
  }
}
