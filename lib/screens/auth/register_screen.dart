import 'package:flutter/material.dart';
import 'package:zanga/services/api_service.dart';

class RegisterScreen extends StatefulWidget {
  // CHANGED: Use StatefulWidget for form data
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState(); // CHANGED
}

class _RegisterScreenState extends State<RegisterScreen> {
  // CHANGED
  final _formKey = GlobalKey<FormState>(); // CHANGED: For validation
  String fullName = ''; // CHANGED
  String email = ''; // CHANGED
  String phone = ''; // CHANGED
  String password = ''; // CHANGED
  String confirmPassword = ''; // CHANGED
  bool isLoading = false; // CHANGED
  bool isAgreed = false;
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE3F2FD),
      appBar: AppBar(
        title: const Text('Create Your Account'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          // CHANGED: Wrap in Form
          key: _formKey, // CHANGED
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              Center(
                child: Stack(
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey,
                      child: Icon(Icons.person, size: 50, color: Colors.white),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue,
                        ),
                        child: const Icon(
                          Icons.camera_alt,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  prefixIcon: const Icon(Icons.person_outline),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onChanged: (value) => fullName = value, // CHANGED
              ),
              const SizedBox(height: 15),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: const Icon(Icons.email_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onChanged: (value) => email = value, // CHANGED
              ),
              const SizedBox(height: 15),
              TextFormField(
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  prefixIcon: const Icon(Icons.phone_android_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onChanged: (value) => phone = value, // CHANGED
              ),
              const SizedBox(height: 15),
              TextFormField(
                // obscureText: true,
                obscureText: !isPasswordVisible,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: const Icon(Icons.lock_outline),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        isPasswordVisible = !isPasswordVisible; // CHANGED
                      });
                    },
                  ),
                ),
                onChanged: (value) => password = value, // CHANGED
              ),
              const SizedBox(height: 15),
              TextFormField(
                //obscureText: true,
                obscureText: !isConfirmPasswordVisible,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  prefixIcon: const Icon(Icons.lock_outline),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      isConfirmPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        isConfirmPasswordVisible =
                            !isConfirmPasswordVisible; // CHANGED
                      });
                    },
                  ),
                ),
                onChanged: (value) => confirmPassword = value, // CHANGED
              ),
              const SizedBox(height: 25),
              Row(
                children: [
                  Checkbox(
                    value: isAgreed,
                    onChanged: (value) {
                      setState(() {
                        isAgreed = value!;
                      });
                    },
                  ),
                  const Expanded(
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(text: 'I agree to the '),
                          TextSpan(
                            text: 'Terms & Conditions',
                            style: TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          TextSpan(text: ' and '),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    if (password != confirmPassword) {
                      // CHANGED
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Passwords do not match'),
                        ), // CHANGED
                      );
                      return;
                    }
                    setState(() => isLoading = true); // CHANGED
                    final data = {
                      'fullName': fullName,
                      'email': email,
                      'phone': phone,
                      'password': password,
                      'confirmPassword': confirmPassword,
                    }; // CHANGED
                    final success = await ApiService.registerUser(
                      data,
                    ); // CHANGED
                    setState(() => isLoading = false); // CHANGED
                    if (success) {
                      Navigator.pushReplacementNamed(
                        context,
                        '/login',
                      ); // CHANGED
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Registration failed'),
                        ), // CHANGED
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2196F3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child:
                      isLoading // CHANGED
                          ? const CircularProgressIndicator(
                            color: Colors.white,
                          ) // CHANGED
                          : const Text(
                            'Create Account',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                ),
              ),
              const SizedBox(height: 20),
              SafeArea(
                child: Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                    child: const Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(text: 'Already have an account? '),
                          TextSpan(
                            text: 'Login',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
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
