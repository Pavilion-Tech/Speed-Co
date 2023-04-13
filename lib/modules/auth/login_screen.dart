import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speed_co/layouts/user_layout/user_layout.dart';
import 'package:speed_co/modules/auth/auth_cubit/auth_cubit.dart';
import 'package:speed_co/modules/auth/auth_cubit/auth_states.dart';
import 'package:speed_co/modules/item_shared/default_button.dart';
import 'package:speed_co/modules/auth/verify_bottomsheet.dart';
import 'package:speed_co/shared/components/components.dart';

import '../../shared/components/constants.dart';
import '../../shared/images/images.dart';
import '../intro/join_as_screen.dart';
import '../item_shared/default_form.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({this.haveArrow = false});
  bool haveArrow ;

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {
        if(isConnect!=null)checkNet(context);
        if (state is LoginSuccessState)
          showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) => VerificationSheet());
      },
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading:haveArrow? IconButton(
              onPressed: ()=>Navigator.pop(context),
              icon: Icon(Icons.arrow_back_ios_outlined,color: Colors.white,),
            ):SizedBox(),
            actions: [
              TextButton(
                  onPressed: ()=>navigateAndFinish(context, UserLayout()),
                  child: Text(
                      tr('skip'),
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          ),
          body: Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 270,
                  width: double.infinity,
                  child: Stack(
                    alignment: AlignmentDirectional.topCenter,
                    children: [
                      Image.asset(
                        Images.curve,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                      Image.asset(
                        Images.background,
                        color: Colors.white,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                      Align(
                        alignment: AlignmentDirectional.center,
                        child: Text(
                          tr('sign_in'),
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: DefaultForm(
                            filteringTextInputFormatter: true,
                            hint: tr('phone'),
                            textLength: 10,
                            validator: (val) {
                              if (val.length < 10) return tr('password_poor');
                              if (val.isEmpty) return tr('phone_empty');
                            },
                            type: TextInputType.phone,
                            controller: AuthCubit.get(context).phoneC,
                            onChange: (val) {
                              if (val.isEmpty) {
                                Future.delayed(Duration(seconds: 3), () {
                                  FocusManager.instance.primaryFocus!.unfocus();
                                });
                              }
                            },
                            suffix: Image.asset(
                              Images.flag,
                              width: 9,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50.0),
                          child:state is! LoginLoadingState ? DefaultButton(
                            text: tr('sign_in'),
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                AuthCubit.get(context).login();
                              }
                            },
                          ):const Center(child: CircularProgressIndicator(),),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              tr('dont_have_account'),
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 10),
                            ),
                            TextButton(
                                onPressed: () {
                                  navigateTo(context, JoinAsScreen());
                                },
                                child: Text(
                                  tr('sign_up'),
                                  style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600),
                                ))
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
