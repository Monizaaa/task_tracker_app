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

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final authController = Get.find<AuthController>();

  late final TextEditingController _nameController;

  late final TextEditingController _emailController;

  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomAppBar(title: 'signUp'.tr),
                  const SizedBox(height: 40),
                  HeaderTitle(title: 'createAccount'.tr),
                  const SizedBox(height: 12),
                  Text('signupPrompt'.tr),
                  const SizedBox(height: 32),
                  CustomInputField(
                    controller: _nameController,
                    hintText: 'enterFullName'.tr,
                  ),
                  const SizedBox(height: 16),
                  CustomInputField(
                    controller: _emailController,
                    hintText: 'enterMail'.tr,
                  ),
                  const SizedBox(height: 16),
                  CustomInputField(
                    controller: _passwordController,
                    hintText: 'enterPassword'.tr,
                    isPassword: true,
                  ),
                  const SizedBox(height: 32),
                  CustomButton(
                    text: 'createAccount'.tr,
                    onPressed: () {
                      authController.register(
                        _emailController.text,
                        _passwordController.text,
                        _nameController.text,
                      );
                    },
                  ),
                  const SizedBox(height: 40),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'signUpWith'.tr,
                      style: TextStyle(
                        color:
                            Theme.of(
                              context,
                            ).extension<AppColorsExtension>()!.greyColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildSocialLogins(),
                  const SizedBox(height: 40),
                  _buildSignUpPrompt(),
                ],
              ),
            ),
          ),
        ],
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
          "haveAccount".tr,
          style: TextStyle(
            color: Theme.of(context).extension<AppColorsExtension>()!.greyColor,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text(
            'signIn'.tr,
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
