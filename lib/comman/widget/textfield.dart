import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project_k/comman/screen_utilse/appcolor.dart';
import 'package:project_k/comman/screen_utilse/screen_utilze.dart';
import 'package:project_k/comman/screen_utilse/textstyle.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final bool isEditPage;
  final String label;
  bool obscureText;
  final Widget? suffixIcon;
  final TextInputType? keyBoardType;
  final String secText;
  final String? Function(String?)? validator;

  CustomTextField({
    super.key,
    this.isEditPage = false,
    this.keyBoardType,
    this.secText = '',
    required this.controller,
    required this.label,
    this.obscureText = false,
    this.suffixIcon,
    this.validator,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _obscure;

  void initState() {
    super.initState();
    _obscure = widget.obscureText; // initialize local state
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              widget.label,
              style: AppText.txSmallBoldDark.copyWith(fontSize: 12.sp),
            ),
            widget.secText == '(Optional)'
                ? Text(
                  widget.secText,
                  style: AppText.txSmallBoldDark.copyWith(color: AppColor.grey),
                )
                : SizedBox(),
          ],
        ),
        kHeight3,
        TextFormField(
          style: AppText.tSmallDark,
          keyboardType: widget.keyBoardType,
          controller: widget.controller,
          obscureText: _obscure,
          autovalidateMode: AutovalidateMode.disabled,
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColor.white,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: widget.isEditPage ? Colors.transparent : AppColor.grey,
                width: 1,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.red, width: 1),
            ),
            suffixIcon:
                widget.obscureText
                    ? IconButton(
                      icon: Icon(
                        _obscure
                            ? Icons.visibility_off
                            : Icons.visibility, // ✅ Use _obscure
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscure = !_obscure;
                        });
                      },
                    )
                    : widget.suffixIcon,
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.red, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: widget.isEditPage ? Colors.transparent : AppColor.grey,
                width: 1,
              ),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 15.w,
              vertical: 10.h,
            ),
          ),
          validator: widget.validator,
        ),
      ],
    );
  }
}
