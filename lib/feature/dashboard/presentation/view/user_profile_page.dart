import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_k/comman/screen_utilse/appcolor.dart';
import 'package:project_k/comman/screen_utilse/asset_image.dart';
import 'package:project_k/comman/screen_utilse/screen_utilze.dart';
import 'package:project_k/comman/screen_utilse/textstyle.dart';
import 'package:project_k/comman/screen_utilse/validation.dart';
import 'package:project_k/comman/shimmer/profile_shimmer.dart';
import 'package:project_k/comman/widget/alert_box.dart';
import 'package:project_k/comman/widget/textfield.dart';
import 'package:project_k/feature/authentication/presentation/view/sign_up_page.dart';
import 'package:project_k/feature/authentication/presentation/view_model/auth_bloc.dart';
import 'package:project_k/feature/authentication/presentation/view_model/auth_event.dart';
import 'package:project_k/feature/authentication/presentation/view_model/auth_state.dart';
import 'package:project_k/feature/dashboard/presentation/view/edit_profile.dart';
import 'package:project_k/feature/dashboard/presentation/view_model/bloc/home_bloc.dart';
import 'package:project_k/feature/dashboard/presentation/view_model/bloc/home_event.dart';
import 'package:project_k/feature/dashboard/presentation/view_model/bloc/home_state.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final ValueNotifier<bool> isOpen = ValueNotifier<bool>(false);
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state.isLoading) {
            return ProfileShimmer();
          }
          if (state.profile.isNotEmpty) {
            return Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/icons/WhatsApp Image 2025-08-01 at 22.07.11_3c9d564f.jpg',
                  ), // or NetworkImage
                  fit: BoxFit.cover, // cover entire container
                ),
              ),

              child: Column(
                children: [
                  kHeight30,
                  kHeight30,
                  kHeight30,
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage(AssetImages.profileIcon),
                    backgroundColor: Colors.transparent,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    context.read<HomeBloc>().state.profile[0].username ?? '',
                    style: AppText.extraBoldMediumDark,
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) =>
                                  EditProfilePage(data: state.profile[0]),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      "Edit profile",
                      style: AppText.smallBlack.copyWith(color: AppColor.white),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: AppColor.borderColor),
                      color: AppColor.extrayLightBackground,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        const Divider(height: 30),
                        ListTile(
                          leading: Icon(Icons.key, color: AppColor.black),
                          title: Text(
                            "Change password",
                            style: AppText.standardText,
                          ),
                          trailing: const Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                            color: AppColor.black,
                          ),
                          onTap: () {
                            showChangePasswordDialog(context);
                          },
                        ),
                        const Divider(),
                        ListTile(
                          leading: const Icon(
                            Icons.person_2_outlined,
                            color: AppColor.black,
                          ),
                          title: Text(
                            "Contact us",
                            style: AppText.standardText,
                          ),
                          trailing: const Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                            color: AppColor.black,
                          ),
                          onTap: () {},
                        ),
                        const Divider(),
                        TextButton.icon(
                          onPressed: () {
                            showLogoutConfirmation(context, () {
                              // Your logout logic here
                              context.read<AuthenticationBloc>().add(
                                Logout(context: context),
                              );
                            });
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: AppColor.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: const BorderSide(
                                color: AppColor.borderColor,
                              ),
                            ),
                          ),
                          icon: const Icon(Icons.logout, color: Colors.black),
                          label: const Text(
                            "Log out",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}

void showChangePasswordDialog(BuildContext context) {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  final TextEditingController oldPasswordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextField(
                controller: oldPasswordController,
                label: "Old password",
                validator: (value) => Validations.emtyValidation(value),
              ),
              const SizedBox(height: 10),
              CustomTextField(
                controller: passwordController,
                label: "new password",
                validator: (value) => Validations.emtyValidation(value),
              ),
              const SizedBox(height: 10),
              CustomTextField(
                controller: confirmPassword,
                label: "confirm password",
                validator:
                    (value) => Validations.conformPasswordValidation(
                      passwordController.text,
                      confirmPassword.text,
                    ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
            },
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              final newPassword = confirmPassword.text.trim();

              if (newPassword.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Password cannot be empty")),
                );
                return;
              }

              // Call your bloc or password change logic here
              print("New password: $newPassword");
              context.read<AuthenticationBloc>().add(
                ChangePassword(
                  currentPassword: oldPasswordController.text,
                  newPassword: newPassword,
                  context: context,
                ),
              );
              // Close dialog
            },
            child: const Text("Change Password"),
          ),
        ],
      );
    },
  );
}
