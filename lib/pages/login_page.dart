import 'package:flutter/material.dart';

import '../helpers/auth_session_helper.dart';
import 'home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _showPassword = false;
  bool _rememberMe = false;
  bool _isSubmitting = false;
  String? _authError;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();

    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }

    setState(() {
      _isSubmitting = true;
      _authError = null;
    });

    try {
      await Future<void>.delayed(const Duration(milliseconds: 800));

      await AuthSessionHelper.saveLoginSession(
        token: 'sample_token_${DateTime.now().millisecondsSinceEpoch}',
        loginData: {
          'email': _emailController.text.trim(),
          'isLoggedIn': true,
          'rememberMe': _rememberMe,
        },
      );

      if (!mounted) {
        return;
      }

      setState(() {
        _isSubmitting = false;
      });

      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (_) => const Home()));
    } catch (_) {
      if (!mounted) {
        return;
      }
      setState(() {
        _isSubmitting = false;
        _authError = 'Login failed. Please try again.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewInsets = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF38BDF8), Color(0xFF0EA5E9), Color(0xFF0284C7)],
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                padding: EdgeInsets.only(bottom: viewInsets),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(14),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(24),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Color(0x33000000),
                                        blurRadius: 18,
                                        offset: Offset(0, 8),
                                      ),
                                    ],
                                  ),
                                  child: Image.asset(
                                    'assets/images/CITASys Logo.jpg',
                                    width: 102,
                                    height: 102,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                const Text(
                                  'ABSENSI APP',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 26,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0.4,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                const Text(
                                  'Employee Management System',
                                  style: TextStyle(
                                    color: Color(0xFFE0F2FE),
                                    fontSize: 13,
                                  ),
                                ),
                                const SizedBox(height: 26),
                                const Text(
                                  'Welcome Back!',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  'Please sign in to continue',
                                  style: TextStyle(
                                    color: Color(0xFFE0F2FE),
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          width: double.infinity,
                          padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(40),
                            ),
                          ),
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 500),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  _InputLabel(text: 'Email'),
                                  _InputField(
                                    controller: _emailController,
                                    hintText: 'name@citasys.com',
                                    prefixIcon: Icons.mail_outline,
                                    keyboardType: TextInputType.emailAddress,
                                    validator: (value) {
                                      final input = value?.trim() ?? '';
                                      if (input.isEmpty) {
                                        return 'Email is required';
                                      }
                                      final regex = RegExp(
                                        r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
                                      );
                                      if (!regex.hasMatch(input)) {
                                        return 'Please enter a valid email';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 14),
                                  _InputLabel(text: 'Password'),
                                  _InputField(
                                    controller: _passwordController,
                                    hintText: 'Enter your password',
                                    prefixIcon: Icons.lock_outline,
                                    obscureText: !_showPassword,
                                    validator: (value) {
                                      final input = value ?? '';
                                      if (input.isEmpty) {
                                        return 'Password is required';
                                      }
                                      if (input.length < 6) {
                                        return 'Password must be at least 6 characters';
                                      }
                                      return null;
                                    },
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _showPassword = !_showPassword;
                                        });
                                      },
                                      icon: Icon(
                                        _showPassword
                                            ? Icons.visibility_off_outlined
                                            : Icons.visibility_outlined,
                                        color: const Color(0xFF9CA3AF),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 14),
                                  Row(
                                    children: [
                                      Transform.scale(
                                        scale: 0.95,
                                        child: Checkbox(
                                          value: _rememberMe,
                                          activeColor: const Color(0xFF0284C7),
                                          onChanged: (value) {
                                            setState(() {
                                              _rememberMe = value ?? false;
                                            });
                                          },
                                        ),
                                      ),
                                      const Text(
                                        'Remember me',
                                        style: TextStyle(
                                          color: Color(0xFF4B5563),
                                        ),
                                      ),
                                      const Spacer(),
                                      TextButton(
                                        onPressed: () {},
                                        child: const Text(
                                          'Forgot password?',
                                          style: TextStyle(
                                            color: Color(0xFF0284C7),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  if (_authError != null) ...[
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 10,
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFFEF2F2),
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: const Color(0xFFFECACA),
                                        ),
                                      ),
                                      child: Text(
                                        _authError!,
                                        style: const TextStyle(
                                          color: Color(0xFFB91C1C),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                  ],
                                  SizedBox(
                                    height: 52,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(14),
                                        gradient: const LinearGradient(
                                          colors: [
                                            Color(0xFF0EA5E9),
                                            Color(0xFF0284C7),
                                          ],
                                        ),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Color(0x330284C7),
                                            blurRadius: 14,
                                            offset: Offset(0, 6),
                                          ),
                                        ],
                                      ),
                                      child: ElevatedButton(
                                        onPressed: _isSubmitting
                                            ? null
                                            : _submit,
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.transparent,
                                          shadowColor: Colors.transparent,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              14,
                                            ),
                                          ),
                                        ),
                                        child: _isSubmitting
                                            ? const SizedBox(
                                                width: 20,
                                                height: 20,
                                                child:
                                                    CircularProgressIndicator(
                                                      strokeWidth: 2,
                                                      color: Colors.white,
                                                    ),
                                              )
                                            : const Text(
                                                'Sign In',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.white,
                                                ),
                                              ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 18),
                                  const Row(
                                    children: [
                                      Expanded(
                                        child: Divider(
                                          color: Color(0xFFE5E7EB),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 12,
                                        ),
                                        child: Text(
                                          'or',
                                          style: TextStyle(
                                            color: Color(0xFF6B7280),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Divider(
                                          color: Color(0xFFE5E7EB),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 18),
                                  OutlinedButton.icon(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.fingerprint,
                                      size: 22,
                                    ),
                                    label: const Text(
                                      'Sign In with Fingerprint',
                                    ),
                                    style: OutlinedButton.styleFrom(
                                      foregroundColor: const Color(0xFF374151),
                                      side: const BorderSide(
                                        color: Color(0xFFE5E7EB),
                                        width: 2,
                                      ),
                                      minimumSize: const Size(
                                        double.infinity,
                                        52,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(14),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Center(
                                    child: RichText(
                                      text: const TextSpan(
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xFF6B7280),
                                        ),
                                        children: [
                                          TextSpan(
                                            text: 'Don\'t have an account? ',
                                          ),
                                          TextSpan(
                                            text: 'Contact Admin',
                                            style: TextStyle(
                                              color: Color(0xFF0284C7),
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  const Center(
                                    child: Text(
                                      '© 2026 ABSENSI APP. All rights reserved.',
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: Color(0xFF9CA3AF),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _InputLabel extends StatelessWidget {
  const _InputLabel({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Color(0xFF374151),
        ),
      ),
    );
  }
}

class _InputField extends StatelessWidget {
  const _InputField({
    required this.controller,
    required this.hintText,
    required this.prefixIcon,
    this.validator,
    this.keyboardType,
    this.obscureText = false,
    this.suffixIcon,
  });

  final TextEditingController controller;
  final String hintText;
  final IconData prefixIcon;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: const Color(0xFFF9FAFB),
        prefixIcon: Icon(prefixIcon, color: const Color(0xFF9CA3AF)),
        suffixIcon: suffixIcon,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 16,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFFE5E7EB), width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFF0284C7), width: 2),
        ),
      ),
    );
  }
}
