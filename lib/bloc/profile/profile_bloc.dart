import 'package:drilly/bloc/profile/profile_event.dart';
import 'package:drilly/bloc/profile/profile_state.dart';
import 'package:drilly/model/profile.dart';
import 'package:drilly/service/api_service.dart';
import 'package:drilly/service/cloudianry_service.dart';
import 'package:drilly/utils/app_res.dart';
import 'package:drilly/utils/const_res.dart';
import 'package:drilly/utils/shared_pref.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../generated/l10n.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(const ProfileState()) {
    on<GetInfo>(
      (event, emit) async {
        String? uuid = await SharePref().getString(ConstRes.uuid);
        if (uuid != null) {
          Profile? profile = await ApiService().getRecord<Profile>(
              tableName: ConstRes.profiles,
              columnName: ConstRes.uuid,
              value: uuid,
              fromMap: (map) => Profile.fromMap(map));
          if (profile != null) {
            emit(state.copyWith(
                profile: profile,
                message: S.current.profileInformationRetrievedSuccessfully));
          }
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
            ApiService().updateColumn(
                tableName: ConstRes.profiles,
                columnName: "avatar",
                columnValue: url,
                conditionColumn: "uuid",
                conditionValue: uuid);
          }
        }
      },
    );
  }
}
