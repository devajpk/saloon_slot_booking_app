import 'dart:async';
import 'package:flutter/material.dart';
import 'package:project_k/comman/screen_utilse/appcolor.dart';
import 'package:project_k/comman/screen_utilse/asset_image.dart';
import 'package:project_k/comman/screen_utilse/image_loaded.dart';
import 'package:project_k/comman/screen_utilse/textstyle.dart';

class SearchTextfieldWidget extends StatefulWidget {
  final String hintText;
  final bool isOfferScreen;
  final bool readOnly;
  final void Function(String) onChanged;
  final void Function()? onFocus;
  final bool isUseDebounce;
  const SearchTextfieldWidget({
    super.key,
    required this.hintText,
    required this.onChanged,
    this.isOfferScreen = false,
    this.onFocus,
    this.readOnly = false,
    this.isUseDebounce = false,
  });

  @override
  State<SearchTextfieldWidget> createState() => _SearchTextfieldWidgetState();
}

class _SearchTextfieldWidgetState extends State<SearchTextfieldWidget> {
  Timer? _debounceTimer;
  FocusNode? focusNode;

  @override
  void initState() {
    //if on focus call back is there, create focusNode instance.
    if (widget.onFocus != null) {
      focusNode = FocusNode();
      focusNode!.addListener(() {
        if (focusNode!.hasFocus) {
          widget.onFocus!();
        }
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    focusNode?.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }

  void _onTextChanged(String text) {
    // Cancel the previous timer if it exists
    if (_debounceTimer?.isActive ?? false) {
      _debounceTimer?.cancel();
    }

    // Start a new timer
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      // Trigger the API call after 500ms of inactivity
      widget.onChanged(text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      decoration: BoxDecoration(
        border: Border.all(width: 0.5, color: AppColor.fadeGrey),
        borderRadius: BorderRadius.circular(15),
        color: AppColor.white,
      ),
      child: TextField(
        focusNode: focusNode,
        readOnly: widget.readOnly,
        onChanged: widget.isUseDebounce ? _onTextChanged : widget.onChanged,
        style: AppText.tSearchfieldStyle,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 3, vertical: 10),
          border: InputBorder.none,
          hintText: widget.hintText,
          hintStyle: AppText.tSearchfieldStyle.copyWith(fontSize: 14),
          prefixIcon: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomeImageLoader(
                imagePath: AssetImages.searchIcon,
                hight: 25,
                width: 18,
                boxFit: BoxFit.fitWidth,
              ),
            ],
          ),
          prefixIconConstraints: const BoxConstraints(minWidth: 40),
        ),
      ),
    );
  }
}
