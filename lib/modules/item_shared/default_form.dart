import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DefaultForm extends StatelessWidget {
  DefaultForm({
    required this.hint,
    this.suffix,
    this.type,
    this.onTap,
    this.controller,
    this.isRead = false,
    this.onChange,
    this.validator,
    this.textLength
});
  String hint;
  Widget? suffix;
  TextInputType? type;
  VoidCallback? onTap;
  bool isRead;
  ValueChanged<String>? onChange;
  FormFieldValidator? validator;
  int? textLength;

  TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: Stack(
        alignment: AlignmentDirectional.topStart,
        children: [
          Container(
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.circular(58),
              color: Colors.grey.shade200
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
              keyboardType: type,
              onTap: onTap,
              controller: controller,
              readOnly: isRead,
              validator: validator,
              onChanged: onChange,
              inputFormatters: [
                LengthLimitingTextInputFormatter(textLength),
              ],
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                enabledBorder: InputBorder.none,
                border: InputBorder.none,
               // contentPadding:const EdgeInsets.symmetric(horizontal: 30,vertical: 5),
                hintText:hint,
                hintStyle:const TextStyle(fontSize: 12),
                suffixIcon: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: suffix,
                )

              ),
            ),
          )
        ],
      ),
    );
  }
}
