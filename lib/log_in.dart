import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'contact_model.dart';

class Login extends StatefulWidget {
  final Function(ContactModel) onUserAdded;

   Login({super.key, required this.onUserAdded});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  File? file;

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _phoneController = TextEditingController();

  final ImagePicker picker = ImagePicker();

  File? pickerImage;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: const Color(0xff29384D),
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                      padding: pickerImage == null
                          ? EdgeInsets.all(25)
                          : EdgeInsets.all(0),
                      margin: const EdgeInsets.only(bottom: 12, right: 12),
                      width: 140,
                      height: 140,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(28),
                        border: Border.all(
                            color: const Color(0xffFFF1D4), width: 2),
                      ),
                      child: pickerImage == null
                          ? InkWell(
                              onTap: () async {
                                final XFile? image = await picker.pickImage(
                                    source: ImageSource.gallery);
                                if (image != null) {
                                  setState(() {
                                    pickerImage = File(image.path);
                                  });
                                }
                              },
                              child: SizedBox(
                                  width: 120,
                                  height: 120,
                                  child: Lottie.asset(
                                      "assets/animations/image_picker.json")),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(28),
                              child: Image.file(
                                pickerImage!,
                                width: 140,
                                height: 140,
                                fit: BoxFit.cover,
                              ),
                            )),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ValueListenableBuilder(
                        valueListenable: _nameController,
                        builder: (context, value, child) {
                          return Text(
                            value.text.isEmpty ? "User Name" : value.text,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          );
                        },
                      ),
                      Container(
                        width: 150,
                        margin: EdgeInsets.only(top: 10, bottom: 10),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white)),
                      ),
                      ValueListenableBuilder(
                        valueListenable: _emailController,
                        builder: (context, value, child) {
                          return Text(
                            value.text.isEmpty
                                ? "example@gmail.com"
                                : value.text,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          );
                        },
                      ),
                      Container(
                        width: 150,
                        margin: EdgeInsets.only(top: 10, bottom: 10),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white)),
                      ),
                      ValueListenableBuilder(
                        valueListenable: _phoneController,
                        builder: (context, value, child) {
                          return Text(
                            value.text.isEmpty
                                ? "+200000000000000"
                                : value.text,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          );
                        },
                      ),
                      Container(
                        width: 150,
                        margin: EdgeInsets.only(top: 10, bottom: 10),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white)),
                      ),
                    ],
                  ),
                ],
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildTextField(
                      hintText: "Enter User Name",
                      controller: _nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    _buildTextField(
                      hintText: "Enter User Email",
                      controller: _emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        String emailRegex =
                            r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';
                        if (!RegExp(emailRegex).hasMatch(value)) {
                          return 'Enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    _buildTextField(
                      hintText: "Enter User Phone",
                      controller: _phoneController,
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your phone number';
                        }
                        if (value.length != 11) {
                          return 'Phone number must be 11 digits';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            widget.onUserAdded(
                              ContactModel(
                                phone: _phoneController.text,
                                name: _nameController.text,
                                email: _emailController.text,
                                image: pickerImage,
                              ),
                            );
                            // Navigator.pop(context);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff1877F2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text(
                          "Enter User",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String hintText,
    required TextEditingController controller,
    required String? Function(String?) validator,
    bool obscureText = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white),
      ),
      child: TextFormField(
        controller: controller,
        style: const TextStyle(color: Colors.white),
        obscureText: obscureText,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
        ),
        validator: validator,
      ),
    );
  }
}
