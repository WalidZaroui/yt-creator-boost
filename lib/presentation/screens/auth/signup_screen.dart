import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:yt_creator_boost/config/router/app_route.dart';

import '../../../config/router/app_route_constants.dart';
import '../../bloc/auth/signup/signup_cubit.dart';
import '../../bloc/auth/signup/signup_state.dart';
import '../../widgets/base_widgets/custom_text_field.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: SafeArea(
        child: BlocListener<SignupCubit, SignupState>(
          listener: (context, state) {
            if (state.status.isSuccess) {
              context.go(AppRoutePath.dashboard);
            } else if (state.status.isFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage ?? 'Sign up failed'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: SingleChildScrollView(
            padding: EdgeInsets.all(24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),

                // Header
                Center(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(20.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100.r),
                        ),
                        child: Icon(
                          Icons.rocket_launch,
                          size: 48.w,
                          color: Colors.red,
                        ),
                      ),
                      SizedBox(height: 24.h),
                      Text(
                        'Join the Community!',
                        style: TextStyle(
                          fontSize: 28.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'Create your account and start growing\nyour YouTube channel',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 32.h),

                // Signup Form
                Container(
                  padding: EdgeInsets.all(24.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Name Field
                      BlocBuilder<SignupCubit, SignupState>(
                        buildWhen: (previous, current) => previous.name != current.name,
                        builder: (context, state) {
                          return CustomTextField(
                            label: 'Full Name',
                            hintText: 'Enter your full name',
                            onChanged: context.read<SignupCubit>().nameChanged,
                            errorText: state.name.displayError?.message,
                            prefixIcon: Icons.person_outline,
                          );
                        },
                      ),

                      SizedBox(height: 16.h),

                      // Email Field
                      BlocBuilder<SignupCubit, SignupState>(
                        buildWhen: (previous, current) => previous.email != current.email,
                        builder: (context, state) {
                          return CustomTextField(
                            label: 'Email',
                            hintText: 'Enter your email',
                            keyboardType: TextInputType.emailAddress,
                            onChanged: context.read<SignupCubit>().emailChanged,
                            errorText: state.email.displayError?.message,
                            prefixIcon: Icons.email_outlined,
                          );
                        },
                      ),

                      SizedBox(height: 16.h),

                      // Password Field
                      BlocBuilder<SignupCubit, SignupState>(
                        buildWhen: (previous, current) =>
                        previous.password != current.password ||
                            previous.isPasswordVisible != current.isPasswordVisible,
                        builder: (context, state) {
                          return CustomTextField(
                            label: 'Password',
                            hintText: 'Create a strong password',
                            obscureText: !state.isPasswordVisible,
                            onChanged: context.read<SignupCubit>().passwordChanged,
                            errorText: state.password.displayError?.message,
                            prefixIcon: Icons.lock_outline,
                            suffixIcon: IconButton(
                              icon: Icon(
                                state.isPasswordVisible
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                              ),
                              onPressed: context.read<SignupCubit>().togglePasswordVisibility,
                            ),
                          );
                        },
                      ),

                      SizedBox(height: 16.h),

                      // Confirm Password Field
                      BlocBuilder<SignupCubit, SignupState>(
                        buildWhen: (previous, current) =>
                        previous.confirmPassword != current.confirmPassword ||
                            previous.isConfirmPasswordVisible != current.isConfirmPasswordVisible ||
                            previous.passwordsMatch != current.passwordsMatch,
                        builder: (context, state) {
                          String? errorText = state.confirmPassword.displayError?.message;
                          if (state.confirmPassword.value.isNotEmpty && !state.passwordsMatch) {
                            errorText = 'Passwords do not match';
                          }

                          return CustomTextField(
                            label: 'Confirm Password',
                            hintText: 'Re-enter your password',
                            obscureText: !state.isConfirmPasswordVisible,
                            onChanged: context.read<SignupCubit>().confirmPasswordChanged,
                            errorText: errorText,
                            prefixIcon: Icons.lock_outline,
                            suffixIcon: IconButton(
                              icon: Icon(
                                state.isConfirmPasswordVisible
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                              ),
                              onPressed: context.read<SignupCubit>().toggleConfirmPasswordVisibility,
                            ),
                          );
                        },
                      ),

                      SizedBox(height: 32.h),

                      // Sign Up Button
                      BlocBuilder<SignupCubit, SignupState>(
                        buildWhen: (previous, current) =>
                        previous.status != current.status ||
                            previous.isValid != current.isValid,
                        builder: (context, state) {
                          return SizedBox(
                            height: 56.h,
                            child: ElevatedButton(
                              onPressed: state.isValid && !state.status.isInProgress
                                  ? context.read<SignupCubit>().signUpWithCredentials
                                  : null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.r),
                                ),
                                elevation: 0,
                              ),
                              child: state.status.isInProgress
                                  ? SizedBox(
                                height: 24.h,
                                width: 24.w,
                                child: const CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                                  : Text(
                                'Create Account',
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          );
                        },
                      ),

                      SizedBox(height: 24.h),

                      // Divider
                      Row(
                        children: [
                          Expanded(
                            child: Divider(color: Colors.grey.shade300),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: Text(
                              'Or sign up with',
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(color: Colors.grey.shade300),
                          ),
                        ],
                      ),

                      SizedBox(height: 24.h),

                      // Google Sign Up
                      BlocBuilder<SignupCubit, SignupState>(
                        buildWhen: (previous, current) => previous.status != current.status,
                        builder: (context, state) {
                          return SizedBox(
                            height: 56.h,
                            child: OutlinedButton.icon(
                              onPressed: state.status.isInProgress
                                  ? null
                                  : context.read<SignupCubit>().signUpWithGoogle,
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(
                                  color: Colors.grey.shade300,
                                  width: 1,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.r),
                                ),
                                backgroundColor: Colors.white,
                              ),
                              icon: Icon(
                                Icons.g_mobiledata,
                                size: 24.w,
                                color: Colors.red,
                              ),
                              label: Text(
                                'Continue with Google',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey.shade800,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 24.h),

                // Sign In Link
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account? ",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16.sp,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          context.go(AppRoutePath.login);
                        },
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
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
      ),
    );
  }
}