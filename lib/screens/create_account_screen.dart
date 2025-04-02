import 'package:flutter/material.dart';

class CreateAccountScreen extends StatefulWidget {
  @override
  _CreateAccountScreenState createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String email = '';
  String password = '';

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // TODO: Save to backend or local storage
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Account created for $name')),
      );

      Navigator.pop(context); // Return to login or previous screen
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Account')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Name
              TextFormField(
                decoration: InputDecoration(labelText: 'Name'),
                onSaved: (val) => name = val!.trim(),
                validator: (val) =>
                    val == null || val.trim().isEmpty ? 'Enter your name' : null,
              ),
              SizedBox(height: 16),

              // Email
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                onSaved: (val) => email = val!.trim(),
                validator: (val) =>
                    val != null && val.contains('@') ? null : 'Enter a valid email',
              ),
              SizedBox(height: 16),

              // Password
              TextFormField(
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                onSaved: (val) => password = val!,
                validator: (val) =>
                    val != null && val.length >= 6 ? null : 'Min 6 characters',
              ),
              SizedBox(height: 24),

              // Button
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Create Account'),
              ),
              SizedBox(height: 12),

              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Already have an account? Log in"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
