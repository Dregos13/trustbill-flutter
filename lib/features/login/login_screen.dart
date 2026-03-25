import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_colors.dart';
import '../../core/auth/auth_provider.dart';
import '../../core/auth/auth_state.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _rememberCredentials = false;
  bool _loadedSaved = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _loadSavedCredentials() async {
    if (_loadedSaved) return;
    _loadedSaved = true;
    final saved =
        await ref.read(authProvider.notifier).getSavedCredentials();
    if (saved != null && mounted) {
      setState(() {
        _emailController.text = saved['email']!;
        _passwordController.text = saved['password']!;
        _rememberCredentials = true;
      });
    }
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;
    await ref.read(authProvider.notifier).login(
          _emailController.text.trim(),
          _passwordController.text,
          rememberCredentials: _rememberCredentials,
        );
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final isLoading = authState is AuthLoading;
    final error =
        authState is AuthUnauthenticated ? authState.error : null;
    final clientId =
        authState is AuthUnauthenticated ? authState.clientId : '';

    // Load saved credentials once when screen renders
    if (authState is AuthUnauthenticated && !_loadedSaved) {
      _loadSavedCredentials();
    }

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.primary, AppColors.primaryDark],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/trustinfacts-logo-light.png',
                    height: 40,
                    errorBuilder: (_, __, ___) => const Text(
                      'TrustInFacts',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 28,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Inicia sesion para continuar',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.7),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.15),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Server indicator
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color: AppColors.gray50,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.dns_outlined,
                                    size: 16, color: AppColors.gray400),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    'app.$clientId.trustinfacts.com',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: AppColors.gray500,
                                      fontFamily: 'monospace',
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    ref
                                        .read(authProvider.notifier)
                                        .resetSetup();
                                  },
                                  child: Text(
                                    'Cambiar',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          if (error != null) ...[
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: AppColors.dangerBg,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                error,
                                style: const TextStyle(
                                  color: AppColors.danger,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                          ],
                          TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            autocorrect: false,
                            decoration: const InputDecoration(
                              labelText: 'Email',
                              hintText: 'tu@email.com',
                            ),
                            validator: (v) {
                              if (v == null || v.trim().isEmpty) {
                                return 'Introduce tu email';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: const InputDecoration(
                              labelText: 'Contrasena',
                            ),
                            validator: (v) {
                              if (v == null || v.isEmpty) {
                                return 'Introduce tu contrasena';
                              }
                              return null;
                            },
                            onFieldSubmitted: (_) => _handleLogin(),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              SizedBox(
                                width: 24,
                                height: 24,
                                child: Checkbox(
                                  value: _rememberCredentials,
                                  onChanged: (v) {
                                    setState(() {
                                      _rememberCredentials = v ?? false;
                                    });
                                  },
                                  activeColor: AppColors.primary,
                                ),
                              ),
                              const SizedBox(width: 8),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _rememberCredentials =
                                        !_rememberCredentials;
                                  });
                                },
                                child: const Text(
                                  'Recordar credenciales',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: AppColors.gray600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            height: 46,
                            child: ElevatedButton(
                              onPressed: isLoading ? null : _handleLogin,
                              child: Text(
                                isLoading ? 'Entrando...' : 'Entrar',
                                style: const TextStyle(fontSize: 15),
                              ),
                            ),
                          ),
                        ],
                      ),
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
