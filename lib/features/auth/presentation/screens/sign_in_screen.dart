import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_tracker_app/core/theme/app_theme.dart';
import 'package:task_tracker_app/core/widgets/custom_app_bar.dart';
import 'package:task_tracker_app/core/widgets/custom_button.dart';
import 'package:task_tracker_app/core/widgets/custom_input_field.dart';
import 'package:task_tracker_app/core/widgets/decorative_circles_widget.dart';
import 'package:task_tracker_app/core/widgets/header_title.dart';
import 'package:task_tracker_app/core/widgets/social_button.dart';
import 'package:task_tracker_app/features/auth/presentation/controllers/auth_controller.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final authController = Get.find<AuthController>();
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _emailController;

  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    _emailController.text = 'albert@example.com';
    _passwordController.text = 'password123';
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          DecorativeCirclesWidget(width: Get.height, height: Get.width),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomAppBar(title: 'signIn'.tr, hideBackButton: true),
                    const SizedBox(height: 40),
                    HeaderTitle(title: 'welcome'.tr),
                    const SizedBox(height: 12),
                    Text('loginPrompt'.tr),
                    const SizedBox(height: 32),
                    CustomInputField(
                      controller: _emailController,
                      hintText: 'enterMail'.tr,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'emailIsRequired'.tr;
                        }
                        if (!GetUtils.isEmail(value)) {
                          return 'enterValidEmail'.tr;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    CustomInputField(
                      controller: _passwordController,
                      hintText: 'enterPassword'.tr,
                      isPassword: true, // This will obscure the text
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'passwordIsRequired'.tr;
                        }
                        return null;
                      },
                    ),
                    Obx(() {
                      if (authController.errorMessage != null) {
                        return Padding(
                          padding: const EdgeInsets.only(
                            top: 16.0,
                            bottom: 8.0,
                          ),
                          child: Center(
                            child: Text(
                              authController.errorMessage!,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.error,
                              ),
                            ),
                          ),
                        );
                      }
                      return const SizedBox(height: 32);
                    }),
                    Obx(
                      () => CustomButton(
                        text: 'signIn'.tr,
                        isLoading: authController.isLoading,
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            authController.login(
                              _emailController.text.trim(),
                              _passwordController.text,
                            );
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 40),
                    _buildSignInWithPrompt(),
                    const SizedBox(height: 16),
                    _buildSocialLogins(),
                    const SizedBox(height: 40),
                    _buildSignUpPrompt(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignInWithPrompt() {
    return Align(
      alignment: Alignment.center,
      child: Text(
        'signInWith'.tr,
        style: TextStyle(
          color: Theme.of(context).extension<AppColorsExtension>()!.greyColor,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildSocialLogins() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SocialButton(
          iconPath: 'assets/icons/apple_logo.svg',
          width: 21,
          height: 26,
          onPressed: () {},
        ),
        const SizedBox(width: 24),
        SocialButton(
          iconPath: 'assets/icons/google_logo.svg',
          width: 25,
          height: 25,
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildSignUpPrompt() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "notRegisteredYet".tr,
          style: TextStyle(
            color: Theme.of(context).extension<AppColorsExtension>()!.greyColor,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        TextButton(
          onPressed: () {
            Get.toNamed('/sign_up');
          },
          child: Text(
            'signUp'.tr,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
