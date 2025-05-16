import 'package:flutter/material.dart';

class LoginSignupPage extends StatefulWidget {
  const LoginSignupPage({super.key});

  @override
  State<LoginSignupPage> createState() => _LoginSignupPageState();
}

class _LoginSignupPageState extends State<LoginSignupPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  String? _errorMessage;
  bool _isLoading = false;
  bool _isLoginMode = true;

  // ... (rest of your validation methods, _toggleMode, _submitForm, dispose) ...
  // No changes needed in the methods above for this step

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(_isLoginMode ? 'Amazons Login' : 'Amazons Sign Up'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.wifi),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Wi-Fi status: Connected (mock)')),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(25.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                // --- YOUR IMAGE LOGO ---
                Image.asset(
                  'images/logo.png', // <-- REPLACE 'your_logo.png' WITH YOUR ACTUAL FILENAME
                  height: 80, // Adjust height as needed
                  width: 150, // You can also set width

                   fit: BoxFit.contain, // How the image should be inscribed into the space
                ),
                const SizedBox(height: 20), // Spacing after logo

                Text(
                  _isLoginMode ? 'Welcome Back!' : 'Create Account',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.displayLarge?.copyWith(
                    color: theme.primaryColor,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  _isLoginMode ? 'Login to continue' : 'Fill in the details to join',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleMedium,
                ),
                const SizedBox(height: 40),

                // ... (rest of your form fields and buttons) ...
                // No changes needed below for this step

                // --- Email Text Field ---
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    hintText: 'Email Address',
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: _validateEmail,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                const SizedBox(height: 20),

                // --- Password Text Field ---
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    hintText: 'Password',
                    prefixIcon: Icon(Icons.lock_outline),
                  ),
                  obscureText: true,
                  validator: _validatePassword,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                const SizedBox(height: 20),

                // --- Phone Number Text Field (Conditional) ---
                if (!_isLoginMode)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: TextFormField(
                      controller: _phoneController,
                      decoration: const InputDecoration(
                        hintText: 'Phone Number',
                        prefixIcon: Icon(Icons.phone_outlined),
                      ),
                      keyboardType: TextInputType.phone,
                      validator: _validatePhoneNumber,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                  ),

                // --- Error Message Display ---
                if (_errorMessage != null && !_isLoading)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: Text(
                      _errorMessage!,
                      style: TextStyle(
                          color: theme.colorScheme.error,
                          fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                  ),

                // --- Loading Indicator or Main Action Button ---
                _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                        onPressed: _submitForm,
                        child: Text(_isLoginMode ? 'Login' : 'Create Account'),
                      ),
                const SizedBox(height: 15),

                // --- Toggle Mode Button ---
                if (!_isLoading)
                  TextButton(
                    onPressed: _toggleMode,
                    child: Text(
                      _isLoginMode
                          ? "Don't have an account? Sign Up"
                          : "Already have an account? Login",
                      style: TextStyle(color: theme.primaryColor),
                    ),
                  ),
                const SizedBox(height: 10),

                // --- Forgot Password (Only in Login Mode) ---
                if (_isLoginMode && !_isLoading)
                  Padding( // Added padding for better spacing
                    padding: const EdgeInsets.only(top: 8.0),
                    child: TextButton(
                        onPressed: (){
                          // Navigate to the Forgot Password page
                          Navigator.pushNamed(context, '/forgot-password');
                        },
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(color: theme.primaryColor),
                        )
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Paste your existing _validateEmail, _validatePassword, _validatePhoneNumber,
  // _toggleMode, and _submitForm methods here if they were not fully included above.
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  String? _validatePhoneNumber(String? value) {
    // This validator is only active when the field is present (i.e., signup mode)
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    }
    if (value.length < 10) { // Basic length check
      return 'Phone number must be at least 10 digits';
    }
    if (!RegExp(r'^[0-9]+$').hasMatch(value)) { // Digits only
      return 'Please enter a valid phone number (digits only)';
    }
    return null;
  }

  void _toggleMode() {
    setState(() {
      _isLoginMode = !_isLoginMode;
      _errorMessage = null; // Clear errors when switching modes
      _formKey.currentState?.reset(); // Optional: reset form fields
      _emailController.clear();
      _passwordController.clear();
      _phoneController.clear();
    });
  }

  Future<void> _submitForm() async {
    setState(() {
      _errorMessage = null;
    });

    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      await Future.delayed(const Duration(seconds: 1)); // Simulate network

      String password = _passwordController.text;
      String email = _emailController.text;
      String actionType = _isLoginMode ? "Login" : "Sign Up";

      if (password.startsWith('gym')) {
        print('$actionType successful for: $email');
        if (!_isLoginMode) {
          print('Phone Number: ${_phoneController.text}');
        }
        if (mounted) { // Check if the widget is still in the tree
          Navigator.pushReplacementNamed(context, '/home');
        }
      } else {
        setState(() {
          _errorMessage = 'Password must start with "gym" to $actionType.';
        });
      }

      setState(() {
        _isLoading = false;
      });
    }
  }
}