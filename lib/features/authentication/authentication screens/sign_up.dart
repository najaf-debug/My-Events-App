// ignore_for_file: unused_field, prefer_final_fields, avoid_print

import 'package:flutter/material.dart';
import 'package:my_events_app/Utils/customs.dart';
import 'package:my_events_app/Utils/themes.dart';
import 'package:my_events_app/practice/repository/auth_provider.dart';
import 'package:my_events_app/widgets/custom_text_btn.dart';
import 'package:my_events_app/widgets/text_form_field.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool _isPasswordVisible = false;
  bool _isChecked = false;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  // Method to handle signup logic
  Future<void> _performSignup(BuildContext context) async {
    if (!_isChecked) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please accept Terms & Conditions')),
      );
      return;
    }

    if (_formKey.currentState!.validate()) {
      final auth = Provider.of<AuthProvider>(context, listen: false);
      try {
        await auth.signup(
          usernameController.text.trim(),
          emailController.text.trim(),
          passwordController.text.trim(),
        );

        if (context.mounted) {
          Navigator.pop(context);
        }
      } catch (e) {
        // Error is already handled in auth provider
        print('Signup error in UI: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunction.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(Sizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                AppTexts.SignUpTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: Sizes.spaceBtwSections),
              // Form
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Username
                    CustomTextField(
                      label: AppTexts.username,
                      prefixIcon: Icons.person_2_outlined,
                      controller: usernameController,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Username is required';
                        }
                        if (value.length < 3) {
                          return 'Username must be at least 3 characters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: Sizes.spaceBtwInputFields),

                    // Email
                    CustomTextField(
                      label: AppTexts.email,
                      prefixIcon: Icons.email,
                      controller: emailController,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Email is required';
                        }
                        if (!RegExp(
                          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                        ).hasMatch(value)) {
                          return 'Enter a valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: Sizes.spaceBtwInputFields),

                    // Password
                    CustomTextField(
                      label: AppTexts.password,
                      prefixIcon: Icons.password,
                      controller: passwordController,
                      obscureText: !_isPasswordVisible,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password is required';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: _togglePasswordVisibility,
                      ),
                    ),
                    const SizedBox(height: Sizes.spaceBtwSections),

                    // Terms&Conditions CheckBox
                    Row(
                      children: [
                        SizedBox(
                          height: 24,
                          width: 24,
                          child: Checkbox(
                            value: _isChecked,
                            onChanged: (value) {
                              setState(() {
                                _isChecked = value ?? false;
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: Sizes.spaceBtwItems),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: AppTexts.iAgreeTo,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),

                              TextSpan(
                                text: AppTexts.privacyPolicy,
                                style: Theme.of(context).textTheme.bodyMedium!
                                    .apply(
                                      color: dark ? Colors.white : Colors.black,
                                      decoration: TextDecoration.underline,
                                      decorationColor: dark
                                          ? Colors.white
                                          : const Color.fromARGB(
                                              255,
                                              52,
                                              148,
                                              226,
                                            ),
                                    ),
                              ),

                              TextSpan(
                                text: " and ",
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              TextSpan(
                                text: AppTexts.termsOfUse,
                                style: Theme.of(context).textTheme.bodyMedium!
                                    .apply(
                                      color: dark ? Colors.white : Colors.black,
                                      decoration: TextDecoration.underline,
                                      decorationColor: dark
                                          ? Colors.white
                                          : const Color.fromARGB(
                                              255,
                                              52,
                                              148,
                                              226,
                                            ),
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // Sign Up Button
                    Consumer<AuthProvider>(
                      builder: (context, auth, child) => SizedBox(
                        width: double.infinity,
                        child: auth.isLoading
                            ? const Center(child: CircularProgressIndicator())
                            : CustomButton(
                                text: AppTexts.createAccount,
                                onPressed: () {
                                  _performSignup(context);
                                },
                                borderRadius: 14,
                              ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // Divider
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Divider(
                      color: dark
                          ? const Color.fromARGB(255, 105, 105, 105)
                          : Colors.grey,
                      thickness: 0.5,
                      indent: 60,
                      endIndent: 5,
                    ),
                  ),

                  Text(
                    AppTexts.orSignUpWith,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  Flexible(
                    child: Divider(
                      color: dark
                          ? const Color.fromARGB(255, 105, 105, 105)
                          : Colors.grey,
                      thickness: 0.5,
                      indent: 5,
                      endIndent: 60,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              // Footer
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: Image(
                        width: Sizes.iconMd,
                        height: Sizes.iconMd,
                        image: const AssetImage(
                          "assets/images/google_icon.png",
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: Sizes.spaceBtwItems),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: Image(
                        width: Sizes.iconMd,
                        height: Sizes.iconMd,
                        image: const AssetImage(
                          "assets/images/facebook_icon.png",
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
