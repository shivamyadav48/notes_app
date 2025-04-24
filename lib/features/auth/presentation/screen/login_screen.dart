import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_providers.dart';
import '../../../../config/router/app_router.dart';
import 'package:go_router/go_router.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  bool _isLoading = false;


  final Color appYellow = const Color(0xFFFFDE21);

  Future<void> _handleGoogleSignIn(BuildContext context) async {
    setState(() => _isLoading = true);

    try {
      final login = ref.read(loginUseCaseProvider);
      final user = await login();

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Welcome ${user.name}"),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
        ),
      );

      context.goNamed(AppRoutes.notesList);
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Login failed: $e"),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Create contrasting colors based on the yellow
    final darkColor =
        Colors.grey[850]; // Dark text that contrasts well with yellow

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              appYellow,
              appYellow.withOpacity(0.7),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/app2.png',
                    width: 80,
                    height: 80,
                  ),
                  const SizedBox(height: 20),

                  // App Name
                  Text(
                    'DriveNotes',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: darkColor,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),

                  // Tagline
                  Text(
                    'Sync your notes seamlessly across devices',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: darkColor?.withOpacity(0.8),
                    ),
                  ),
                  const SizedBox(height: 60),

                  // Login Card
                  Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFFFFDE21).withOpacity(0.1),
                            Colors.white,
                          ],
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          children: [
                            Text(
                              'Get Started',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                            ),
                            const SizedBox(height: 24),

                            // Sign in with Google Button
                            SizedBox(
                              width: double.infinity,
                              height: 52,
                              child: ElevatedButton.icon(
                                icon: Icon(
                                  FontAwesomeIcons.google,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                label: _isLoading
                                    ? SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: Colors.black87,
                                        ),
                                      )
                                    : Text(
                                        "Sign in with Google",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                        ),
                                      ),
                                onPressed: _isLoading
                                    ? null
                                    : () => _handleGoogleSignIn(context),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFFFFDE21),
                                  foregroundColor: Colors.black87,
                                  elevation: 2,
                                  shadowColor:
                                      Color(0xFFFFDE21).withOpacity(0.5),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 16),


                            Row(
                              children: [
                                Expanded(
                                    child: Divider(color: Colors.grey[300])),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: Text(
                                    "or",
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                Expanded(
                                    child: Divider(color: Colors.grey[300])),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),
                  Text(
                    'By signing in, you agree to our Terms and Privacy Policy',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: darkColor?.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
