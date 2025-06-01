import 'package:drilly/model/profile.dart';
import 'package:drilly/utils/enum.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

class ProfileEditState extends Equatable {
  final Profile? profile;
  final ScreenState status;
  final XFile? newAvatar;
  final String? errorMessage;
  final String? message;

  const ProfileEditState({
    this.profile,
    this.status = ScreenState.initial,
    this.newAvatar,
    this.errorMessage,
    this.message,
  });

  ProfileEditState copyWith({
    Profile? profile,
    ScreenState? status,
    XFile? newAvatar,
    String? errorMessage,
    String? message,
  }) {
    return ProfileEditState(
      profile: profile ?? this.profile,
      status: status ?? this.status,
      newAvatar: newAvatar ?? this.newAvatar,
      errorMessage: errorMessage,
      message: message,
    );
  }

  @override
  List<Object?> get props =>
      [profile, status, newAvatar, errorMessage, message];
}
