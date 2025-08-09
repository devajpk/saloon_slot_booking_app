import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_k/comman/screen_utilse/appcolor.dart';
import 'package:project_k/comman/screen_utilse/textstyle.dart';
import 'package:project_k/comman/widget/textfield.dart';
import 'package:project_k/feature/authentication/presentation/view_model/auth_bloc.dart';
import 'package:project_k/feature/authentication/presentation/view_model/auth_event.dart';
import 'package:project_k/feature/authentication/presentation/view_model/auth_state.dart';
import 'package:project_k/feature/dashboard/presentation/model/profile_model.dart';

class EditProfilePage extends StatefulWidget {
  final ProfileResponseModel data;

  const EditProfilePage({super.key, required this.data});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  File? _imageFile;
  final picker = ImagePicker();

  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController emailController;
  late TextEditingController shopNameController;
  late TextEditingController shopLicenseController;
  late TextEditingController addressController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.data.username ?? '');
    phoneController = TextEditingController(
      text: widget.data.phoneNumber ?? '',
    );
    emailController = TextEditingController(text: widget.data.email);
    shopNameController = TextEditingController(text: widget.data.shopName);
    shopLicenseController = TextEditingController(
      text: widget.data.licenseNumber,
    );
    addressController = TextEditingController(text: widget.data.shopAddress);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text("Edit Profile", style: AppText.appBartext),
        centerTitle: true,
        backgroundColor: AppColor.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              CustomTextField(controller: nameController, label: "Username"),
              const SizedBox(height: 10),
              CustomTextField(controller: phoneController, label: "Phone"),
              const SizedBox(height: 10),
              CustomTextField(controller: emailController, label: "Email"),
              const SizedBox(height: 10),
              if (widget.data.isBarber ?? false) ...[
                CustomTextField(
                  controller: shopNameController,
                  label: "Shop Name",
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: shopLicenseController,
                  label: "License Number",
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: addressController,
                  label: "Address",
                ),
                const SizedBox(height: 10),
              ],
              _buildImageSection(),
              const SizedBox(height: 20),
              BlocBuilder<AuthenticationBloc, AuthenticationState>(
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: () async {
                      print("suc ${nameController.text}");
                      if (!_formKey.currentState!.validate()) return;

                      final imageBase64 =
                          _imageFile != null
                              ? await _convertImageToBase64(_imageFile!)
                              : '';

                      context.read<AuthenticationBloc>().add(
                        UpdateProfileRequest(
                          context: context,
                          userId: widget.data.userId!,
                          username: nameController.text,
                          email: emailController.text,
                          phoneNumber: phoneController.text,
                          shopName: shopNameController.text,
                          licenseNumber: shopLicenseController.text,
                          shopAddress: addressController.text,
                          imageUrl: imageBase64,
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[800],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child:
                        state.isLoading
                            ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                            : const Text(
                              "Update",
                              style: TextStyle(color: Colors.white),
                            ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Shop Image", style: AppText.tMediumDark),
        const SizedBox(height: 10),
        Row(
          children: [
            if (_imageFile != null)
              Image.file(
                _imageFile!,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              )
            else if ((widget.data.shopImageUrl ?? '').isNotEmpty)
              Image.network(
                widget.data.shopImageUrl!,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              )
            else
              Container(
                width: 100,
                height: 100,
                color: Colors.grey[300],
                child: const Icon(Icons.image),
              ),
            const SizedBox(width: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.photo),
              label: const Text("Change Image"),
              onPressed: _pickImage,
            ),
          ],
        ),
      ],
    );
  }

  void _pickImage() async {
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _imageFile = File(picked.path);
      });
    }
  }

  Future<String> _convertImageToBase64(File file) async {
    final bytes = await file.readAsBytes();
    return base64Encode(bytes);
  }
}
