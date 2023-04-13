import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speed_co/modules/auth/auth_cubit/auth_states.dart';
import 'package:speed_co/modules/auth/login_screen.dart';
import 'package:speed_co/modules/item_shared/default_button.dart';
import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/images/images.dart';
import '../../auth/auth_cubit/auth_cubit.dart';
import '../../item_shared/default_form.dart';
import '../widgets/item_shared/map_address_screen.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({this.haveArrow = false});
  bool haveArrow ;
  TextEditingController addressController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController latController = TextEditingController();
  TextEditingController lngController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: haveArrow?AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: ()=>Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios_outlined,color: Colors.white,),
        ),
      ):null,
      body: BlocConsumer<AuthCubit, AuthStates>(
        listener: (context, state) {
          if(isConnect!=null)checkNet(context);
          if(state is CreateUserSuccessState)
            navigateAndFinish(context, LoginScreen());
        },
        builder: (context, state) {
          return Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 270,
                  width: double.infinity,
                  child: Stack(
                    alignment: AlignmentDirectional.center,
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
                      Text(
                        tr('sign_up'),
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.w600),
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
                          child: Column(
                            children: [
                              DefaultForm(
                                controller: nameController,
                                hint: tr('name'),
                                validator: (val){
                                  if(val.isEmpty)return tr('name_empty');
                                },
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20.0),
                                child: DefaultForm(
                                  controller: phoneController,
                                  hint: tr('phone'),
                                  textLength: 10,
                                  filteringTextInputFormatter: true,
                                  type: TextInputType.phone,
                                  validator: (val){
                                    if(val.length < 10)return tr('password_poor');
                                    if(val.isEmpty)return tr('phone_empty');
                                  },
                                  suffix: Image.asset(
                                    Images.flag,
                                    width: 9,
                                  ),
                                ),
                              ),
                              DefaultForm(
                                hint: tr('location'),
                                isRead: true,
                                controller: addressController,
                                validator: (val){
                                  if(val.isEmpty)return tr('location_empty');
                                },
                                onTap: () async {
                                  await AuthCubit.get(context)
                                      .getCurrentLocation();
                                  if (AuthCubit.get(context).position != null) {
                                    navigateTo(
                                        context,
                                        MapAddressScreen(
                                            AuthCubit.get(context).position!,
                                            addressController,
                                            lat: latController,
                                            lng: lngController,
                                        ));
                                  }
                                },
                                suffix: Image.asset(
                                  Images.addLocation,
                                  width: 9,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50.0),
                          child:state is! CreateUserLoadingState ? DefaultButton(
                            text: tr('sign_up'),
                            onTap: () {
                              if(formKey.currentState!.validate()){
                                AuthCubit.get(context).createUser(
                                    phone: phoneController.text.trim(),
                                    name: nameController.text,
                                    lat: latController.text,
                                    lng: lngController.text
                                );
                              }
                            },
                          ):const Center(child: CircularProgressIndicator(),),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              tr('have_account'),
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 10),
                            ),
                            TextButton(
                                onPressed: () {
                                  navigateTo(context, LoginScreen(haveArrow: true,));
                                },
                                child: Text(
                                  tr('back'),
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
          );
        },
      ),
    );
  }
}
