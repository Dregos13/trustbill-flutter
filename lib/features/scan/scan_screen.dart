import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme_tokens.dart';
import 'scan_provider.dart';

class ScanScreen extends ConsumerStatefulWidget {
  const ScanScreen({super.key});

  @override
  ConsumerState<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends ConsumerState<ScanScreen> {
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final currentType = ref.read(scanProvider).scanType;
      ref.read(scanProvider.notifier).reset();
      ref.read(scanProvider.notifier).setScanType(currentType);
    });
  }

  Future<void> _pickImage(ImageSource source) async {
    final file = await _picker.pickImage(
      source: source,
      maxWidth: 2000,
      maxHeight: 2000,
      imageQuality: 90,
    );
    if (file == null) return;

    final bytes = await file.readAsBytes();
    final mimeType = file.name.toLowerCase().endsWith('.png')
        ? 'image/png'
        : 'image/jpeg';

    ref.read(scanProvider.notifier).scanImage(bytes, mimeType);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(scanProvider);
    final isExpense = state.scanType == ScanType.expense;

    ref.listen<ScanState>(scanProvider, (prev, next) {
      if (next.result != null && prev?.result == null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) context.push('/scan/review');
        });
      }
    });

    final typeColor = isExpense ? const Color(0xFF0EA5E9) : AppColors.primary;
    final typeIcon = isExpense ? Icons.receipt_long : Icons.description_outlined;
    final typeLabel = isExpense ? 'Escanear gasto' : 'Escanear factura emitida';
    final typeSubtitle = isExpense
        ? 'Factura o ticket de proveedor'
        : 'Factura emitida a cliente';

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(typeLabel),
        backgroundColor: typeColor,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.pop(),
        ),
      ),
      body: state.isScanning
          ? _ScanningView(color: typeColor)
          : state.error != null
              ? _ErrorView(
                  error: state.error!,
                  color: typeColor,
                  onRetry: () {
                    final type = ref.read(scanProvider).scanType;
                    ref.read(scanProvider.notifier).reset();
                    ref.read(scanProvider.notifier).setScanType(type);
                  },
                )
              : _SelectSourceView(
                  icon: typeIcon,
                  color: typeColor,
                  subtitle: typeSubtitle,
                  onCamera: () => _pickImage(ImageSource.camera),
                  onGallery: () => _pickImage(ImageSource.gallery),
                ),
    );
  }
}

// ── Source selection ──────────────────────────────────────────────────────────

class _SelectSourceView extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String subtitle;
  final VoidCallback onCamera;
  final VoidCallback onGallery;

  const _SelectSourceView({
    required this.icon,
    required this.color,
    required this.subtitle,
    required this.onCamera,
    required this.onGallery,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          const SizedBox(height: 48),
          Container(
            width: 96,
            height: 96,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 48, color: color),
          ),
          const SizedBox(height: 20),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Haz una foto o selecciona una imagen de tu galería\npara extraer los datos automáticamente.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.gray500,
                  height: 1.5,
                ),
          ),
          const SizedBox(height: 48),
          _SourceButton(
            icon: Icons.camera_alt_outlined,
            label: 'Usar cámara',
            description: 'Haz una foto del documento',
            color: color,
            isPrimary: true,
            onTap: onCamera,
          ),
          const SizedBox(height: 12),
          _SourceButton(
            icon: Icons.photo_library_outlined,
            label: 'Galería',
            description: 'Selecciona una imagen existente',
            color: color,
            isPrimary: false,
            onTap: onGallery,
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 32),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.lock_outline, size: 13, color: AppColors.gray400),
                const SizedBox(width: 6),
                Text(
                  'Los documentos se procesan de forma segura',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.gray400,
                        fontSize: 11,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SourceButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final String description;
  final Color color;
  final bool isPrimary;
  final VoidCallback onTap;

  const _SourceButton({
    required this.icon,
    required this.label,
    required this.description,
    required this.color,
    required this.isPrimary,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: isPrimary ? color : color.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(14),
          border: isPrimary ? null : Border.all(color: color.withValues(alpha: 0.25)),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: isPrimary
                    ? Colors.white.withValues(alpha: 0.2)
                    : color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                color: isPrimary ? Colors.white : color,
                size: 22,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: isPrimary ? Colors.white : color,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 12,
                      color: isPrimary
                          ? Colors.white.withValues(alpha: 0.75)
                          : AppColors.gray500,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: isPrimary ? Colors.white.withValues(alpha: 0.7) : color.withValues(alpha: 0.5),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Scanning state ────────────────────────────────────────────────────────────

class _ScanningView extends StatelessWidget {
  final Color color;
  const _ScanningView({required this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 56,
            height: 56,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              color: color,
            ),
          ),
          const SizedBox(height: 28),
          Text(
            'Analizando documento...',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'El OCR está extrayendo los datos',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.gray500,
                ),
          ),
        ],
      ),
    );
  }
}

// ── Error state ───────────────────────────────────────────────────────────────

class _ErrorView extends StatelessWidget {
  final String error;
  final Color color;
  final VoidCallback onRetry;

  const _ErrorView({
    required this.error,
    required this.color,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: context.statusDangerSoft,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(Icons.error_outline, color: context.statusDanger),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    error,
                    style: TextStyle(color: context.statusDanger, fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton.icon(
              onPressed: onRetry,
              style: ElevatedButton.styleFrom(
                backgroundColor: color,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              icon: const Icon(Icons.refresh),
              label: const Text('Intentar de nuevo'),
            ),
          ),
        ],
      ),
    );
  }
}
