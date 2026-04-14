import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../cubit/auth_cubit.dart';
import '../../../core/constants/app_colors.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          state.maybeWhen(
            authenticated: (_) => context.go('/dashboard'),
            error: (msg) => ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(msg, style: TextStyle(color: Colors.white)), backgroundColor: AppColors.scoreRed),
            ),
            orElse: () {},
          );
        },
        builder: (context, state) {
          return Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Productivity', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: AppColors.primary)),
                  SizedBox(height: 48),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(labelText: 'Email', border: OutlineInputBorder()),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(labelText: 'Password', border: OutlineInputBorder()),
                    obscureText: true,
                  ),
                  SizedBox(height: 32),
                  state.maybeWhen(
                    loading: () => CircularProgressIndicator(),
                    orElse: () => ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        minimumSize: Size(double.infinity, 50),
                      ),
                      onPressed: () => context.read<AuthCubit>().signIn(
                        _emailController.text,
                        _passwordController.text,
                      ),
                      child: Text('Login', style: TextStyle(fontSize: 16)),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextButton(
                    onPressed: () => context.go('/signup'),
                    child: Text('Create Account'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
