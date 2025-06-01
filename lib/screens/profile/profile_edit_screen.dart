import 'package:drilly/bloc/profile_edit/profile_edit_bloc.dart';
import 'package:drilly/bloc/profile_edit/profile_edit_event.dart';
import 'package:drilly/bloc/profile_edit/profile_edit_state.dart';
import 'package:drilly/generated/l10n.dart';
import 'package:drilly/model/profile.dart';
import 'package:drilly/utils/asset_res.dart';
import 'package:drilly/utils/color_res.dart';
import 'package:drilly/utils/custom/custom_widget.dart';
import 'package:drilly/utils/enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class ProfileEditScreen extends StatelessWidget {
  final Profile profile;
  const ProfileEditScreen({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileEditBloc(profile: profile)..add(FillData()),
      child: BlocBuilder<ProfileEditBloc, ProfileEditState>(
        builder: (context, state) {
          ProfileEditBloc bloc = context.read();
          return Scaffold(
            backgroundColor: Colors.white,
            body: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                spacing: 20,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: ColorRes.primary,
                          size: 30,
                        )),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Avatar
                      ClipOval(
                        child: SizedBox(
                          height: 100,
                          width: 100,
                          child: CustomNetworkImage(profile.avatar),
                        ),
                      ),
                      CustomButton(
                        width: 100,
                        text: S.current.change,
                        action: () => bloc.add(GetImage()),
                      ),
                      ClipOval(
                          child: XFileImageWidget(
                        xFile: state.newAvatar,
                      ))
                    ],
                  ),
                  TextWithTextFieldWidget(
                    title: S.current.name,
                    controller: bloc.nameEC,
                  ),
                  TextWithTextFieldWidget(
                    title: S.current.numberPhone,
                    controller: bloc.phoneEC,
                  ),
                  DatePicker(
                      initialDate: profile.birthday,
                      onDateChanged: (newDateString) {
                        bloc.birthdayEC.text = newDateString; // 2025-05-26
                      }),
                  Align(
                    alignment: Alignment.center,
                    child: CustomButton(
                      width: 100,
                      text: S.current.save,
                      action: () => bloc.add(UpdateProfile()),
                    ),
                  ),
                  const Spacer(),
                  Align(
                      alignment: Alignment.center,
                      child: Visibility(
                          visible: state.status == ScreenState.loading,
                          child: const SpinningImageWidget(
                            imagePath: AssetRes.loading,
                            size: 50,
                            duration: Duration(seconds: 2),
                          ))),
                  const Spacer(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
