import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_k/comman/screen_utilse/appcolor.dart';
import 'package:project_k/comman/screen_utilse/asset_image.dart';
import 'package:project_k/comman/screen_utilse/image_loaded.dart';
import 'package:project_k/comman/screen_utilse/textstyle.dart' show AppText;
import 'package:project_k/comman/screen_utilse/validation.dart';
import 'package:project_k/comman/widget/textfield.dart';
import 'package:project_k/feature/authentication/presentation/view/sign_up_page.dart';
import 'package:project_k/feature/authentication/presentation/view_model/auth_bloc.dart';
import 'package:project_k/feature/authentication/presentation/view_model/auth_event.dart';
import 'package:project_k/feature/authentication/presentation/view_model/auth_state.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();
  late bool _minTextAdapt;

  @override
  void initState() {
    super.initState();
    _minTextAdapt = true; // ✅ Now it’s initialized before use
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomeImageLoader(
                  imagePath: AssetImages.profileIcon,
                  hight: 105,
                  width: 200,
                  boxFit: BoxFit.fitHeight,
                ),
                const SizedBox(height: 30),
                CustomTextField(
                  keyBoardType: TextInputType.phone,
                  controller: phoneController,
                  label: "phone number",
                  validator: (value) => Validations.numberValidation(value),
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  controller: passwordController,
                  label: "password",
                  validator: (value) => Validations.isPassword(value),
                  obscureText: true,
                ),
                const SizedBox(height: 30),
                BlocBuilder<AuthenticationBloc, AuthenticationState>(
                  builder: (context, state) {
                    return SizedBox(
                      width: 150,
                      height: 45,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<AuthenticationBloc>().add(
                              LoginRequested(
                                username: phoneController.text,
                                password: passwordController.text,
                                context: context,
                              ),
                            );
                          }
                          print(
                            " ${phoneController.text} ${passwordController.text}",
                          );
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
                                  'Login in',
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
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("dont have an account? ", style: AppText.tSmallDark),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUpPage(),
                          ),
                        );
                      },
                      child: Text("sign up", style: AppText.txSmallBlueDark),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
