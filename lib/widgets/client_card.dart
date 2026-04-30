import 'package:flutter/material.dart';
import '../core/theme/app_theme_tokens.dart';

class ClientCard extends StatelessWidget {
  final String name;
  final String taxId;
  final String? email;
  final VoidCallback? onTap;

  const ClientCard({
    super.key,
    required this.name,
    required this.taxId,
    this.email,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final initial = name.isNotEmpty ? name[0].toUpperCase() : '?';

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: context.appSurface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: context.appBorder),
        boxShadow: [
          BoxShadow(
            color: context.appShadow,
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: context.appPrimarySoft,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    initial,
                    style: TextStyle(
                      color: context.appPrimary,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: context.appText,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        [taxId, if (email != null && email!.isNotEmpty) email]
                            .join(' · '),
                        style: TextStyle(
                          fontSize: 12,
                          color: context.appTextMuted,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right,
                    size: 20, color: context.appTextSubtle),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
