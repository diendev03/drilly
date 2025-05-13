
import 'package:drilly/bloc/profile/profile_bloc.dart';
import 'package:drilly/bloc/profile/profile_event.dart';
import 'package:drilly/bloc/profile/profile_state.dart';
import 'package:drilly/generated/l10n.dart';
import 'package:drilly/model/profile.dart';
import 'package:drilly/utils/app_res.dart';
import 'package:drilly/utils/color_res.dart';
import 'package:drilly/utils/custom/custom_widget.dart';
import 'package:drilly/utils/style_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

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
    return BlocProvider(
      create: (context) => ProfileBloc()..add(GetInfo()),
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          ProfileBloc bloc = context.read<ProfileBloc>();
          Profile profile = state.profile ?? Profile.empty();
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
                  GestureDetector(
                    onTap: () => AppRes.showBottomSheet(
                      context,
                      _buildOptionAvatar(
                          () => bloc.add(
                              UpdateAvatar()),
                          profile.avatar),
                    ),
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
                  const SizedBox(height: 16),
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

  Widget _buildOptionAvatar(VoidCallback updateAvatar, String url) {
    return Container(
      height: 150,
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => updateAvatar(), // Gọi updateAvatar khi nhấn
            child: Row(
              children: [
                const Icon(Icons.upload, size: 30, color: ColorRes.primary),
                Text(
                  S.current.uploadNewAvatar,
                  style: normalText.copyWith(color: ColorRes.primary),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () => Get.to(
                () => ImageFromUrl(imageUrl: url)), // Chuyển trang để xem ảnh
            child: Row(
              children: [
                const Icon(
                  Icons.remove_red_eye_outlined,
                  size: 30,
                  color: ColorRes.primary,
                ),
                Text(
                  S.current.viewAvatar,
                  style: normalText.copyWith(color: ColorRes.primary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
