import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_colors.dart';
import '../../core/auth/auth_provider.dart';

class SetupScreen extends ConsumerStatefulWidget {
  const SetupScreen({super.key});

  @override
  ConsumerState<SetupScreen> createState() => _SetupScreenState();
}

class _SetupScreenState extends ConsumerState<SetupScreen> {
  final _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;
  String? _error;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _handleContinue() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _loading = true;
      _error = null;
    });

    final clientId = _controller.text.trim().toLowerCase();

    try {
      await ref.read(authProvider.notifier).setClientId(clientId);
    } catch (e) {
      if (mounted) {
        setState(() {
          _loading = false;
          _error = 'No se pudo conectar con el servidor';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
                    'Configura tu servidor',
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
                          const Text(
                            'Introduce el identificador de tu empresa',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.gray700,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Tu administrador te proporcionara este dato.',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.gray400,
                            ),
                          ),
                          const SizedBox(height: 16),
                          if (_error != null) ...[
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: AppColors.dangerBg,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                _error!,
                                style: const TextStyle(
                                  color: AppColors.danger,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                          ],
                          TextFormField(
                            controller: _controller,
                            autocorrect: false,
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                              labelText: 'ID de empresa',
                              hintText: 'ej: demo',
                              suffixText: '.trustinfacts.com',
                              suffixStyle: TextStyle(
                                color: AppColors.gray400,
                                fontSize: 13,
                              ),
                            ),
                            validator: (v) {
                              if (v == null || v.trim().isEmpty) {
                                return 'Introduce el identificador';
                              }
                              if (!RegExp(r'^[a-zA-Z0-9\-]+$')
                                  .hasMatch(v.trim())) {
                                return 'Solo letras, numeros y guiones';
                              }
                              return null;
                            },
                            onFieldSubmitted: (_) => _handleContinue(),
                          ),
                          const SizedBox(height: 12),
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: AppColors.gray50,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.link,
                                    size: 16, color: AppColors.gray400),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    _controller.text.trim().isEmpty
                                        ? 'app.{id}.trustinfacts.com'
                                        : 'app.${_controller.text.trim().toLowerCase()}.trustinfacts.com',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: AppColors.gray500,
                                      fontFamily: 'monospace',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            height: 46,
                            child: ElevatedButton(
                              onPressed: _loading ? null : _handleContinue,
                              child: Text(
                                _loading ? 'Conectando...' : 'Continuar',
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
