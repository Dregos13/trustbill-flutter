import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_theme.dart';
import '../core/auth/auth_provider.dart';
import '../core/auth/auth_state.dart';

class AppHeader extends ConsumerWidget implements PreferredSizeWidget {
  final String currentLocation;

  const AppHeader({super.key, required this.currentLocation});

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    String companyName = '';
    String userName = '';

    if (authState is AuthAuthenticated) {
      userName = authState.user.name;
      final activeCompany = authState.companies
          .where((c) => c.id == authState.activeCompanyId)
          .firstOrNull;
      companyName = activeCompany?.name ?? '';
    }

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isOnAccount = currentLocation.startsWith('/account');

    return Container(
      color: isDark ? darkHeader : AppColors.primary,
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          height: 56,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Image.asset(
                  'assets/images/trustinfacts-logo-light.png',
                  height: 26,
                  errorBuilder: (_, _, _) => const Text(
                    'TrustInFacts',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                if (companyName.isNotEmpty)
                  Expanded(
                    child: Text(
                      companyName,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.7),
                        fontSize: 13,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                else
                  const Spacer(),
                _AvatarButton(
                  name: userName,
                  isActive: isOnAccount,
                  onTap: () => context.go('/account'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AvatarButton extends StatelessWidget {
  final String name;
  final bool isActive;
  final VoidCallback onTap;

  const _AvatarButton({
    required this.name,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final initial = name.isNotEmpty ? name[0].toUpperCase() : '?';

    return SizedBox(
      width: 44,
      height: 44,
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Center(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            curve: Curves.easeOut,
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isActive ? Colors.white : Colors.transparent,
                width: 2,
              ),
            ),
            child: Container(
              width: 30,
              height: 30,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Center(
                child: Text(
                  initial,
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    height: 1,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
