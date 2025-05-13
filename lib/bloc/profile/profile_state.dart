import 'package:drilly/model/profile.dart';
import 'package:equatable/equatable.dart';

class ProfileState extends Equatable {
  final Profile? profile;
  final String? errorMessage;
  final String? message;

  const ProfileState({
    this.profile,
    this.errorMessage,
    this.message,
  });

  ProfileState copyWith({
    Profile? profile,
    String? errorMessage,
    String? message,
  }) {
    return ProfileState(
      profile: profile ?? this.profile,
      errorMessage: errorMessage,
      message: message,
    );
  }

  @override
  List<Object?> get props => [profile, errorMessage, message];
}
