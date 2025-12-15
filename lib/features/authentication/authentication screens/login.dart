// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:my_events_app/Utils/customs.dart';
import 'package:my_events_app/Utils/themes.dart';
import 'package:my_events_app/features/authentication/authentication%20screens/sign_up.dart';
import 'package:my_events_app/practice/mock_api/shared_prefs.dart';
import 'package:my_events_app/practice/repository/auth_provider.dart';
import 'package:my_events_app/practice/repository/auth_repository.dart';
import 'package:my_events_app/widgets/custom_text_btn.dart';
import 'package:my_events_app/widgets/my_nav_bar.dart';
import 'package:my_events_app/widgets/text_form_field.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isChecked = false;
  bool _obscurePassword = true; // To toggle password visibility
  final authRepo = AuthRepository();
  final emailCntrlr = TextEditingController();
  final passCntrlr = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Load saved email if "Remember Me" was checked before
    _loadSavedEmail();
  }

  // Load saved email from storage
  Future<void> _loadSavedEmail() async {
    // Replace with your actual storage service call
    final storage = StorageService();
    final savedEmail = await storage.getSavedEmail();
    if (savedEmail != null) {
      setState(() {
        emailCntrlr.text = savedEmail;
        _isChecked = true;
      });
    }

    // For now, I'll add a placeholder. Replace with your actual implementation:
    try {
      // This is where you'd call your storage service
      // For example:
      // final storage = StorageService();
      // final savedEmail = await storage.getSavedEmail();
      // final rememberMe = await storage.getRememberMe();
      // if (savedEmail != null && rememberMe) {
      //   setState(() {
      //     emailCntrlr.text = savedEmail;
      //     _isChecked = true;
      //   });
      // }
    } catch (e) {
      print('Error loading saved email: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final dark = AppHelperFunction.isDarkMode(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Mock Auth")),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: Sizes.appBarHeight,
            left: Sizes.defaultSpace,
            bottom: Sizes.defaultSpace,
            right: Sizes.defaultSpace,
          ),
          child: Column(
            children: [
              /// Logo, title & Sub-Title
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image(
                    height: 150,
                    image: AssetImage(
                      dark ? Appimages.lightAppLogo : Appimages.darkAppLogo,
                    ),
                  ),
                  Text(
                    AppTexts.loginTitle,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  SizedBox(height: Sizes.sm),
                  Text(
                    AppTexts.loginSubTitle,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),

              /// Form
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: Sizes.spaceBtwSections,
                  ),
                  child: Column(
                    children: [
                      // Email
                      CustomTextField(
                        label: AppTexts.email,
                        prefixIcon: Icons.email,
                        controller: emailCntrlr,
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

                      SizedBox(height: Sizes.spaceBtwInputFields),

                      // Password with toggle visibility
                      CustomTextField(
                        label: AppTexts.password,
                        prefixIcon: Icons.password,
                        controller: passCntrlr,
                        obscureText: _obscurePassword,
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
                            _obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                      ),

                      SizedBox(height: Sizes.spaceBtwInputFields / 2),

                      // remember me & forget Password
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: _isChecked,
                                onChanged: (value) {
                                  setState(() {
                                    _isChecked = value ?? false;
                                  });
                                },
                              ),
                              const Text(AppTexts.rememberMe),
                            ],
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text(AppTexts.forgetPassword),
                          ),
                        ],
                      ),
                      const SizedBox(height: Sizes.spaceBtwSections),

                      // Sign In button
                      Consumer<AuthProvider>(
                        builder: (context, auth, child) => SizedBox(
                          width: double.infinity,
                          child: auth.isLoading
                              ? const Center(child: CircularProgressIndicator())
                              : CustomButton(
                                  text: AppTexts.signIn,
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      // Save email if "Remember Me" is checked
                                      final storage = StorageService();
                                      if (_isChecked &&
                                          emailCntrlr.text.isNotEmpty) {
                                        await storage.saveRememberMe(
                                          true,
                                          emailCntrlr.text.trim(),
                                        );
                                      } else {
                                        await storage.clearRememberMe();
                                      }

                                      // Rest of your login code...
                                    }
                                    if (_formKey.currentState!.validate()) {
                                      // Save email if "Remember Me" is checked
                                      if (_isChecked &&
                                          emailCntrlr.text.isNotEmpty) {
                                        // Replace with your actual storage service call
                                        // Example:
                                        // final storage = StorageService();
                                        // await storage.saveRememberMe(true, emailCntrlr.text.trim());
                                      } else {
                                        // Clear saved credentials if unchecked
                                        // Example:
                                        // final storage = StorageService();
                                        // await storage.clearRememberMe();
                                      }

                                      // Call login without await
                                      auth
                                          .login(
                                            emailCntrlr.text.trim(),
                                            passCntrlr.text.trim(),
                                          )
                                          .then((_) {
                                            // Check if widget is still mounted
                                            if (!context.mounted) return;

                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                builder: (_) =>
                                                    const MyNavBar(),
                                              ),
                                            );
                                          });
                                    }
                                  },
                                ),
                        ),
                      ),
                      const SizedBox(height: Sizes.spaceBtwItems),

                      // Create Account Button
                      SizedBox(
                        width: double.infinity,
                        child: CustomButton(
                          text: AppTexts.createAccount,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignUp(),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
