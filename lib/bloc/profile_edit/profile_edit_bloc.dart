import 'package:drilly/model/profile.dart';
import 'package:drilly/service/auth_service/auth_service.dart';
import 'package:drilly/service/cloudianry_service.dart';
import 'package:drilly/utils/app_res.dart';
import 'package:drilly/utils/const_res.dart';
import 'package:drilly/utils/enum.dart';
import 'package:drilly/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../generated/l10n.dart';
import 'profile_edit_event.dart';
import 'profile_edit_state.dart';

class ProfileEditBloc extends Bloc<ProfileEditEvent, ProfileEditState> {
  TextEditingController nameEC = TextEditingController();
  TextEditingController birthdayEC = TextEditingController();
  TextEditingController phoneEC = TextEditingController();
  ProfileEditBloc({required Profile profile})
      : super(const ProfileEditState()) {
    on<FillData>((event, emit) async {
      nameEC.text = profile.name;
      birthdayEC.text = profile.birthday;
      phoneEC.text = profile.phone;
    });
    on<GetImage>(
      (event, emit) async {
        ImagePicker picker = ImagePicker();
        XFile? xFile = await AppRes().pickImage(picker);
        if (xFile != null) {
          emit(state.copyWith(newAvatar: xFile, status: ScreenState.success));
        } else {
          emit(state.copyWith(
              status: ScreenState.error,
              errorMessage: S.current.noImageSelected));
        }
      },
    );
    on<UpdateProfile>(
      (event, emit) async {
        emit(state.copyWith(status: ScreenState.loading));
        String? uuid = await SharePref().getString(ConstRes.uuid);
        if (uuid == null) {
          emit(state.copyWith(
              status: ScreenState.error,
              errorMessage: S.current.notFindYourId));
          return;
        }
        String? url;
        if (state.newAvatar != null) {
          url = await CloudinaryService().uploadImage(state.newAvatar!);
          if (url == null) {
            emit(state.copyWith(
                status: ScreenState.error,
                errorMessage: S.current.uploadFailed));
            return;
          } else {
            final response = await AuthService().updateProfile(
                uuid: uuid,
                name: nameEC.text,
                phone: phoneEC.text,
                avatarUrl: url,
                birthday: birthdayEC.text);
            if (response.data["status"] == true) {
              emit(state.copyWith(status: ScreenState.success));
            } else {
              emit(state.copyWith(
                  status: ScreenState.error,
                  errorMessage: S.current.updateFailed));
            }
          }
        }
      },
    );
  }
}
// if (xFile != null) {
// String? url = await CloudinaryService().uploadImage(xFile);
// if (url != null) {
// ApiService().updateColumn(
//     tableName: ConstRes.profiles,
//     columnName: "avatar",
//     columnValue: url,
//     conditionColumn: "uuid",
//     conditionValue: uuid);
// }
// }
