import 'package:drilly/model/account.dart';
import 'package:drilly/screens/main/main_screen.dart';
import 'package:drilly/service/auth_service/auth_service.dart';
import 'package:drilly/utils/app_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:drilly/generated/l10n.dart';

import 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  TextEditingController emailEC = TextEditingController();
  TextEditingController passwordEC = TextEditingController();
  TextEditingController rePasswordEC = TextEditingController();

  AuthBloc() : super(AuthInitial()) {
    on<ShowLogin>((event, emit) {
      emit(LoginState());
    });

    on<ShowRegistration>((event, emit) {
      emit(RegistrationState());
    });

    on<ShowForgotPassword>((event, emit) {
      emit(ForgotPasswordState());
    });

    on<Login>(
      (event, emit) async {
        AppRes.hideKeyboard(Get.context!);

        await AppRes.showCustomLoader();
        if (validationLogin()==true) {
          try {
            final response=await AuthService().login(
              email: emailEC.text, password:passwordEC.text,
            );
            if(response!=null){
              Navigator.of(Get.context!).pop();
              AppRes.showSnackBar(S.current.login);
              print("Login response: ${response.data['uuid']}");
              AppRes.saveLogin(uuid: response.data['data']['uuid']);
              Get.off(()=>const MainScreen());
            }
          } catch (e) {
            print("Login error: $e");
            if (Navigator.of(Get.context!).canPop()) {
              Navigator.of(Get.context!).pop();
            }
            AppRes.showSnackBar(e.toString());
          }
        }else {
          if (Navigator.of(Get.context!).canPop()) {
            Navigator.of(Get.context!).pop();
          }
        }
      },
    );
    on<Registration>(
      (event, emit) async {
        AppRes.hideKeyboard(Get.context!);

        await AppRes.showCustomLoader();
        if (validationRegistration()) {
          try {
            final account = await AuthService().signUpAndSaveUser(
                email: emailEC.text, password: passwordEC.text);
            if (account != null) {
              Navigator.of(Get.context!).pop();
              AppRes.showSnackBar(S.current.registrationSuccessful, type: true);
              add(ShowLogin());
            } else {
              AppRes.showSnackBar(S.current.registrationFailed);
            }
          } catch (e) {
            Navigator.of(Get.context!).pop();
            AppRes.showSnackBar(e.toString());
          }
        }
      },
    );
    on<ForgotPassword>(
      (event, emit) async {
        AppRes.hideKeyboard(Get.context!);
        await AppRes.showCustomLoader();
        await AuthService().forgotPassword(emailEC.text);
        Navigator.of(Get.context!).pop();
        AppRes.showSnackBar(S.current.checkYourEmail, type: true);
        add(ShowLogin());
      },
    );
  }
  bool validationLogin() {
    if (emailEC.text.isEmpty) {
      AppRes.showSnackBar(S.current.pleaseEnterUsername);
      return false;
    }
    if (passwordEC.text.isEmpty) {
      AppRes.showSnackBar(S.current.pleaseEnterPassword);
      return false;
    }
    return true;
  }

  bool validationRegistration() {
    if (!validationLogin()) {
      return false;
    }
    if (passwordEC.text != rePasswordEC.text) {
      AppRes.showSnackBar(S.current.passwordsDoNotMatch);
      return false;
    }
    return true;
  }
}
