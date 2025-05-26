import 'package:drilly/bloc/profile/profile_event.dart';
import 'package:drilly/bloc/profile/profile_state.dart';
import 'package:drilly/model/profile.dart';
import 'package:drilly/service/auth_service/auth_service.dart';
import 'package:drilly/service/cloudianry_service.dart';
import 'package:drilly/utils/app_res.dart';
import 'package:drilly/utils/const_res.dart';
import 'package:drilly/utils/enum.dart';
import 'package:drilly/utils/shared_pref.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../generated/l10n.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(const ProfileState()) {
    on<GetInfo>(
      (event, emit) async {
        try{
          String? uuid = await SharePref().getString(ConstRes.uuid);
          if (uuid != null) {
            final response = await AuthService().getUserProfile(uuid: uuid);
            if (response != null) {
              Profile profile = Profile.fromMap(response.data['data']);
              emit(state.copyWith(
                profile: profile,
                status: ScreenState.success,
                message: response.data['message'],));
            }
          } else {
            emit(state.copyWith(
                status: ScreenState.error,
                errorMessage: S.current.notFindYourId));
          }
        } catch (e) {
          emit(state.copyWith(
              status: ScreenState.error, errorMessage: e.toString()));
        }
      },
    );
    on<UpdateAvatar>(
      (event, emit) async {
        String uuid = state.profile?.uuid ?? "";
        ImagePicker picker = ImagePicker();
        XFile? xFile = await AppRes().pickImage(picker);
        if (xFile != null) {
          String? url = await CloudinaryService().uploadImage(xFile);
          if (url != null) {
            // ApiService().updateColumn(
            //     tableName: ConstRes.profiles,
            //     columnName: "avatar",
            //     columnValue: url,
            //     conditionColumn: "uuid",
            //     conditionValue: uuid);
          }
        }
      },
    );
  }
}
