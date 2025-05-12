import 'package:drilly/bloc/profile/profile_event.dart';
import 'package:drilly/bloc/profile/profile_state.dart';
import 'package:drilly/model/account.dart';
import 'package:drilly/model/profile.dart';
import 'package:drilly/service/api_service.dart';
import 'package:drilly/utils/const_res.dart';
import 'package:drilly/utils/shared_pref.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../generated/l10n.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(const ProfileState()) {
    on<GetInfo>(
      (event, emit) async {
        String? uuid = await SharePref().getString(ConstRes.uuid);
        if (uuid != null) {
          Profile? drillier = await ApiService().getRecord<Profile>(
              tableName: ConstRes.profiles,
              columnName: ConstRes.uuid,
              value: uuid,fromMap: (map) => Profile.fromMap(map));
          if (drillier != null) {
            emit(state.copyWith(
                user: drillier,
                message: S.current.profileInformationRetrievedSuccessfully));
          }
        }
      },
    );
  }
}
