// auth_screen.dart

// ignore_for_file: deprecated_member_use

import 'package:drilly/bloc/auth/auth_event.dart';
import 'package:drilly/utils/custom/animate_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:drilly/generated/l10n.dart';
import 'package:drilly/bloc/auth/auth_bloc.dart';
import 'package:drilly/utils/asset_res.dart';
import 'package:drilly/utils/color_res.dart';
import 'package:drilly/utils/custom/custom_widget.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          // Ảnh nền
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AssetRes.backgroundLogin),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Container nổi lên với nền trắng
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: BlocProvider(
                create: (context) => AuthBloc()..add(ShowLogin()),
                child: BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    AuthBloc bloc = context.read<AuthBloc>();
                    double height = state is LoginState
                        ? 550
                        : (state is RegistrationState ? 650 : 450);
                    return SingleChildScrollView(
                      child: Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 10),
                        height: height,
                        decoration: BoxDecoration(
                          color: ColorRes.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 15,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            RotatingWidget(child:Image(
                              image: const AssetImage(AssetRes.logoTransparent),
                              height: screen.width * 0.5,
                            )),
                            const SizedBox(
                              height: 30,
                            ),
                            if (state is LoginState) ...[
                              TextWithTextFieldWidget(
                                title: S.current.username,
                                controller: bloc.emailEC,
                              ),
                              const SizedBox(height: 20),
                              TextWithTextFieldWidget(
                                title: S.current.password,
                                isPassword: true,
                                controller: bloc.passwordEC,
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextButton(
                                    onPressed: () =>
                                        bloc.add(ShowForgotPassword()),
                                    child: Text(S.current.forgotYourPassword),
                                  ),
                                  TextButton(
                                    onPressed: () => bloc.add(ShowRegistration()),
                                    child: Text(S.current.registration),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              CustomCard(
                                text: S.current.login,
                                width: screen.width * 0.5,
                                action: () => bloc.add(Login()),
                              ),
                            ] else if (state is RegistrationState) ...[
                              // Registration UI
                              TextWithTextFieldWidget(
                                title: S.current.username,
                                controller: bloc.emailEC,
                              ),
                              const SizedBox(height: 20),
                              TextWithTextFieldWidget(
                                title: S.current.password,
                                isPassword: true,
                                controller: bloc.passwordEC,
                              ),
                              const SizedBox(height: 20),
                              TextWithTextFieldWidget(
                                title: S.current.rePassword,
                                isPassword: true,
                                controller: bloc.rePasswordEC,
                              ),
                              const SizedBox(height: 20),
                              CustomCard(
                                text: S.current.registration,
                                width: screen.width * 0.5,
                                action: () => bloc.add(Registration()),
                              ),
                              TextButton(
                                onPressed: () => bloc.add(ShowLogin()),
                                child: Text(S.current.login),
                              ),
                            ] else if (state is ForgotPasswordState) ...[
                              // Forgot Password UI
                              TextWithTextFieldWidget(
                                title: S.current.emailAddress,
                                controller: bloc.emailEC,
                              ),
                              const SizedBox(height: 20),
                              CustomCard(
                                text: S.current.sendResetLink,
                                width: screen.width * 0.5,
                                action: (){
                                  bloc.add(ForgotPassword());
                                  bloc.passwordEC.clear();
                                },
                              ),
                              TextButton(
                                onPressed: () => bloc.add(ShowLogin()),
                                child: Text(S.current.login),
                              ),
                            ],
                          ],
                        ),
                      )
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
