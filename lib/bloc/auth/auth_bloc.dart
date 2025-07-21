import 'package:drilly/screens/main/main_screen.dart';
import 'package:drilly/service/auth_service/auth_service.dart';
import 'package:drilly/utils/app_res.dart';
import 'package:drilly/utils/const_res.dart';
import 'package:drilly/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:drilly/generated/l10n.dart';

import 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  TextEditingController emailEC = TextEditingController();
  TextEditingController passwordEC = TextEditingController();
  TextEditingController nameEC = TextEditingController();
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
            if(response.status){
              Navigator.of(Get.context!).pop();
              if(response.data!=null){
                Get.off(()=>const MainScreen());
                SharePref().saveString(ConstRes.token, response.data??"",);
              }else{
                AppRes.showSnackBar(S.current.canNotFindToken);
              }
            }
          } catch (e) {
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
            final response = await AuthService().signUpAndSaveUser(name: nameEC.text,
                email: emailEC.text, password: passwordEC.text);
            if (response.status) {
              Navigator.of(Get.context!).pop();
              AppRes.showSnackBar(response.message, type: true);
              add(ShowLogin());
            } else {
              Navigator.of(Get.context!).pop();
              AppRes.showSnackBar(response.message);
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
