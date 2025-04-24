import 'auth_service.dart';
import 'components/Button.dart';
import 'package:task/login.dart';
import 'package:flutter/material.dart';
import 'package:task/utils/input_styles.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isAgreedToPrivacy = false;
  bool _isLoading = false;

  Future<void> _handleRegister() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    if (!_isAgreedToPrivacy) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You must accept the privacy terms')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final success = await AuthService().register(
        _emailController.text.trim(),
        _passwordController.text,
      );

      if (success) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AccountSuccessPage()),
        );
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Registration failed")));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("An error occurred: ${e.toString()}")),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(''),
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const Login()),
            );
          },
          child: const Icon(Icons.arrow_back, color: Colors.black, size: 30),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30.0),
                    child: Column(
                      children: const [
                        Text(
                          "Let's Get Started!",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w900,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Create an account to get all features',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                _buildTextField(_nameController, 'Enter your name', (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                }),
                const SizedBox(height: 20),
                _buildTextField(
                  _emailController,
                  'Enter your email',
                  (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an email address';
                    }
                    final emailRegex = RegExp(
                      r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$',
                    );
                    if (!emailRegex.hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 20),
                _buildTextField(
                  _passwordController,
                  'Enter your password',
                  (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                  obscureText: !_isPasswordVisible,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () => setState(
                      () => _isPasswordVisible = !_isPasswordVisible,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                _buildTextField(
                  _confirmPasswordController,
                  'Confirm your password',
                  (value) {
                    if (value != _passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                  obscureText: !_isConfirmPasswordVisible,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isConfirmPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () => setState(
                      () => _isConfirmPasswordVisible =
                          !_isConfirmPasswordVisible,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                CheckboxListTile(
                  title: RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: 'I accept the ',
                          style: TextStyle(fontSize: 12.0, color: Colors.black),
                        ),
                        TextSpan(
                          text: 'Privacy Policy and Terms of Service',
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  value: _isAgreedToPrivacy,
                  onChanged: (bool? value) =>
                      setState(() => _isAgreedToPrivacy = value ?? false),
                  controlAffinity: ListTileControlAffinity.leading,
                ),
                const SizedBox(height: 10),
                _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Color.fromARGB(255, 27, 102, 215),
                          ),
                        ),
                      )
                    : CustomButton(
                        text: 'Log In',
                        onPressed: _handleRegister,
                        isLoading: _isLoading,
                      ),

                const SizedBox(height: 20),
                Center(
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: RichText(
                      text: const TextSpan(
                        text: 'Already have an account? ',
                        style: TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                            text: 'Login here',
                            style: TextStyle(
                              color: Color(0xFF191919),
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
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
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String hint,
    String? Function(String?) validator, {
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    Widget? suffixIcon,
  }) {
    return TextFormField(
      controller: controller,
      decoration: inputDecoration(hint).copyWith(suffixIcon: suffixIcon),
      validator: validator,
      obscureText: obscureText,
      keyboardType: keyboardType,
    );
  }
}

class AccountSuccessPage extends StatelessWidget {
  const AccountSuccessPage({super.key});

  Future<void> _logout(BuildContext context) async {
    const storage = FlutterSecureStorage();
    await storage.delete(key: 'token');

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const Login()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account Created'),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              Image.asset('assets/icons/tick.png', height: 150.0, width: 150.0),
              const SizedBox(height: 20),
              const Text(
                'Your account has been successfully created!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              // ElevatedButton(
              //   onPressed: () => _logout(context),
              //   style: ElevatedButton.styleFrom(
              //     backgroundColor: const Color(0xFF191919),
              //     foregroundColor: Colors.white,
              //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              //     minimumSize: const Size(double.infinity, 50),
              //     padding: const EdgeInsets.symmetric(vertical: 16.0),
              //   ),
              //   child: const Text('Go to Login', style: TextStyle(fontSize: 16.0)),
              // ),
              CustomButton(
                onPressed: () => AuthService().signOut(),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.logout),
                    SizedBox(width: 8),
                    Text('Go to Login', style: TextStyle(fontSize: 16.0)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
