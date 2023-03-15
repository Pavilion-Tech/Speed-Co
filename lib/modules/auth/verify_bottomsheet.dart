import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speed_co/layouts/provider_layout/provider_layout.dart';
import 'package:speed_co/layouts/user_layout/user_layout.dart';
import 'package:speed_co/modules/auth/auth_cubit/auth_cubit.dart';
import 'package:speed_co/modules/auth/auth_cubit/auth_states.dart';
import 'package:speed_co/modules/item_shared/default_button.dart';
import 'package:speed_co/shared/images/images.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../item_shared/otp_widget.dart';

class VerificationSheet extends StatefulWidget {
  const VerificationSheet({Key? key}) : super(key: key);

  @override
  State<VerificationSheet> createState() => _VerificationSheetState();
}

class _VerificationSheetState extends State<VerificationSheet> {
  TextEditingController otpC1 = TextEditingController();
  TextEditingController otpC2 = TextEditingController();
  TextEditingController otpC3 = TextEditingController();
  TextEditingController otpC4 = TextEditingController();
  int _start = 60;

  bool timerFinished = false;

  Timer? timer;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
            timerFinished = true;
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void initState() {
    startTimer();
    showToast(msg: '${tr('code_is')} $code');
    super.initState();
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  bool checkCode() {
    String codeFromOtp = otpC1.text + otpC2.text + otpC3.text + otpC4.text;
    print(codeFromOtp);
    return int.parse(myLocale == 'en'
            ? codeFromOtp
            : String.fromCharCodes(codeFromOtp.runes.toList().reversed)) ==
        code;
  }

  bool checkOTP() {
    if (otpC1.text.isEmpty ||
        otpC2.text.isEmpty ||
        otpC3.text.isEmpty ||
        otpC4.text.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  void submit(BuildContext context) {
    if (checkOTP()) {
      if (checkCode()) {
         AuthCubit.get(context).verify(context);
      } else {
        showToast(msg: tr('code_invalid'), toastState: true);
      }
    } else {
      showToast(msg: tr('code_empty'), toastState: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {
        if(state is VerifyUserSuccessState)
          navigateAndFinish(context, UserLayout());
        if(state is VerifyProviderSuccessState)
          navigateAndFinish(context, ProviderLayout());
      },
      builder: (context, state) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 80),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  alignment: AlignmentDirectional.topCenter,
                  children: [
                    Image.asset(Images.verifyCurve),
                    Image.asset(
                      Images.background,
                      height: 150,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      color: Colors.white,
                    ),
                    Align(
                      alignment: AlignmentDirectional.bottomCenter,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            tr('verification'),
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 32,
                                fontWeight: FontWeight.w600),
                          ),
                          if (!timerFinished)
                            Text(
                              '00:$_start',
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                          if (timerFinished)
                            InkWell(
                              onTap: () {
                                AuthCubit.get(context).login();
                                timer;
                                _start = 60;
                                timerFinished = false;
                                startTimer();
                              },
                              child: Text(
                                tr('try_again'),
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                        ],
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: otp(),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child:state is! VerifyLoadingState? DefaultButton(
                      text: tr('verify'),
                      onTap: () {
                        submit(context);
                      }):const Center(child: CircularProgressIndicator(),),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget otp() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        OTPWidget(
          otpC1,
          autoFocus: myLocale == 'en'?true:false,
          onFinished: () {
            if (checkOTP() && myLocale != 'en') {
              submit(context);
            }
          },
        ),
        OTPWidget(otpC2),
        OTPWidget(otpC3),
        OTPWidget(
          otpC4,
          autoFocus: myLocale == 'ar'?true:false,
          onFinished: () {
            if (checkOTP() && myLocale != 'ar') {
              submit(context);
            }
          },
        ),
      ],
    );
  }
}
