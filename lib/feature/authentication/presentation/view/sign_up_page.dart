import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_k/comman/screen_utilse/appcolor.dart';
import 'package:project_k/comman/screen_utilse/screen_utilze.dart';
import 'package:project_k/comman/screen_utilse/textstyle.dart';
import 'package:project_k/comman/screen_utilse/validation.dart';
import 'package:project_k/comman/widget/textfield.dart';
import 'package:project_k/feature/authentication/presentation/view_model/auth_bloc.dart';
import 'package:project_k/feature/authentication/presentation/view_model/auth_event.dart';
import 'package:project_k/feature/authentication/presentation/view_model/auth_state.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController confirmPhoneNumberController =
      TextEditingController();
  final TextEditingController shopNameController = TextEditingController();
  final TextEditingController shopLicenceNumberController =
      TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final ValueNotifier<bool> _isChecked = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: AppBar(
        forceMaterialTransparency: true,
        centerTitle: true,
        title: Text('Sign Up', style: AppText.appBartext),
        backgroundColor: AppColor.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextField(
                    controller: nameController,
                    label: "User name",
                    validator: (value) => Validations.emtyValidation(value),
                  ),
                  kHeight11,
                  CustomTextField(
                    keyBoardType: TextInputType.phone,
                    controller: phoneNumberController,
                    label: "Phone Number",
                    validator: (value) => Validations.emtyValidation(value),
                  ),
                  kHeight11,
                  CustomTextField(
                    keyBoardType: TextInputType.phone,
                    controller: confirmPhoneNumberController,
                    label: "Confirm Phone Number",
                    validator:
                        (value) => Validations.conformNumberValidation(
                          confirmPhoneNumberController.text,
                          phoneNumberController.text,
                        ),
                  ),
                  kHeight11,
                  CustomTextField(controller: emailController, label: "Email"),
                  kHeight11,
                  ValueListenableBuilder<bool>(
                    valueListenable: _isChecked,
                    builder: (context, value, _) {
                      return Row(
                        children: [
                          Checkbox(
                            value: value,
                            onChanged: (bool? newValue) {
                              _isChecked.value = newValue ?? false;
                            },
                          ),
                          Text("Beauty parlour", style: AppText.tSmallDarkBold),
                        ],
                      );
                    },
                  ),
                  kHeight11,
                  ValueListenableBuilder<bool>(
                    valueListenable: _isChecked,
                    builder: (context, value, _) {
                      return value
                          ? Column(
                            children: [
                              kHeight11,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  _imageFile != null
                                      ? Image.file(
                                        _imageFile!,
                                        width: 150,
                                        height: 200,
                                      )
                                      : const SizedBox(),
                                  const SizedBox(height: 20),
                                  InkWell(
                                    onTap: pickImageFromGallery,
                                    child: imagePickButton(Icons.photo),
                                  ),
                                  InkWell(
                                    onTap: pickImageFromCamera,
                                    child: imagePickButton(Icons.camera_alt),
                                  ),
                                ],
                              ),
                              CustomTextField(
                                controller: shopNameController,
                                label: "Shop Name",
                              ),
                              kHeight11,
                              CustomTextField(
                                controller: shopLicenceNumberController,
                                label: "Shop Licence Number",
                                validator:
                                    (value) =>
                                        Validations.emtyValidation(value),
                              ),
                              kHeight11,
                              CustomTextField(
                                controller: addressController,
                                label: "Address",
                                validator:
                                    (value) =>
                                        Validations.emtyValidation(value),
                              ),
                            ],
                          )
                          : const SizedBox();
                    },
                  ),
                  kHeight11,
                  CustomTextField(
                    controller: passwordController,
                    label: "Password",
                    validator: (value) => Validations.isPassword(value),
                  ),
                  kHeight11,
                  CustomTextField(
                    controller: confirmPasswordController,
                    label: "Confirm Password",
                    validator:
                        (value) => Validations.conformPasswordValidation(
                          passwordController.text,
                          confirmPasswordController.text,
                        ),
                  ),
                  kHeight30,
                  BlocBuilder<AuthenticationBloc, AuthenticationState>(
                    builder: (context, state) {
                      return SizedBox(
                        width: 150,
                        height: 45,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              if (_isChecked.value && !validateImage(context))
                                return;

                              final base64Image =
                                  _imageFile != null
                                      ? await convertImageToBase64(_imageFile!)
                                      : '';

                              context.read<AuthenticationBloc>().add(
                                SignUpRequest(
                                  username: nameController.text,
                                  password: passwordController.text,
                                  email: emailController.text,
                                  phone_number: phoneNumberController.text,
                                  firstName: "",
                                  lastName: '',
                                  is_barber: _isChecked.value,
                                  shop_name: shopNameController.text,
                                  shop_address: addressController.text,
                                  licensceNumber:
                                      shopLicenceNumberController.text,
                                  shop_image_url: base64Image,
                                  context: context,
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green[700],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child:
                              state.isLoading
                                  ? const CircularProgressIndicator(
                                    color: AppColor.cardColor,
                                  )
                                  : const Text(
                                    'Sign Up',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontFamily: 'monospace',
                                    ),
                                  ),
                        ),
                      );
                    },
                  ),
                  kHeight30,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget imagePickButton(IconData icon) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColor.borderColor, width: 1),
      ),
      height: 40,
      width: 40,
      child: Center(child: Icon(icon)),
    );
  }

  pickImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  pickImageFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<String> convertImageToBase64(File imageFile) async {
    final bytes = await imageFile.readAsBytes();
    return base64Encode(bytes);
  }

  bool validateImage(BuildContext context) {
    if (_imageFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please select an image."),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }
    return true;
  }
}
