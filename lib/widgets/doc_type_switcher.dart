import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../core/theme/app_theme_tokens.dart';

/// Segmented switcher to move between the document chain:
/// Facturas (invoices) → Presupuestos (budgets) → Ventas (sales).
class DocTypeSwitcher extends StatelessWidget {
  /// One of 'invoices' | 'budgets' | 'sales'.
  final String active;

  const DocTypeSwitcher({super.key, required this.active});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _chip(context, 'Presupuestos', 'budgets', '/budgets'),
        const SizedBox(width: 8),
        _chip(context, 'Ventas', 'sales', '/sales'),
        const SizedBox(width: 8),
        _chip(context, 'Facturas', 'invoices', '/invoices'),
      ],
    );
  }

  Widget _chip(BuildContext context, String label, String key, String route) {
    final isActive = key == active;
    return Expanded(
      child: InkWell(
        onTap: isActive ? null : () => context.go(route),
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 9),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isActive ? context.appPrimary : context.appSurface,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isActive ? context.appPrimary : context.appBorder,
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: isActive ? Colors.white : context.appTextMuted,
            ),
          ),
        ),
      ),
    );
  }
}
