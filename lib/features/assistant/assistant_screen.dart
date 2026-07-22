import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme_tokens.dart';
import 'assistant_provider.dart';

class AssistantScreen extends ConsumerStatefulWidget {
  const AssistantScreen({super.key});

  @override
  ConsumerState<AssistantScreen> createState() => _AssistantScreenState();
}

class _AssistantScreenState extends ConsumerState<AssistantScreen> {
  final _controller = TextEditingController();
  final _scroll = ScrollController();
  final _focus = FocusNode();
  bool _hasText = false;

  static const _suggestions = <String>[
    '¿Cuánto he facturado este mes?',
    'Mis últimas 5 facturas',
    'Facturas pendientes de cobro',
    'Buscar un cliente por nombre',
  ];

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      final has = _controller.text.trim().isNotEmpty;
      if (has != _hasText) setState(() => _hasText = has);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scroll.dispose();
    _focus.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scroll.hasClients) {
        _scroll.animateTo(
          _scroll.position.maxScrollExtent,
          duration: const Duration(milliseconds: 240),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _send([String? preset]) {
    final text = (preset ?? _controller.text).trim();
    if (text.isEmpty) return;
    _controller.clear();
    ref.read(assistantProvider.notifier).send(text);
    _focus.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(assistantProvider);

    // Auto-scroll cuando llega un mensaje nuevo o cambia el estado "escribiendo".
    ref.listen<AssistantState>(assistantProvider, (prev, next) {
      if (prev == null ||
          prev.messages.length != next.messages.length ||
          prev.sending != next.sending) {
        _scrollToBottom();
      }
    });

    return Scaffold(
      backgroundColor: context.appBackground,
      appBar: AppBar(
        backgroundColor: context.appPrimary,
        foregroundColor: Colors.white,
        elevation: 0,
        titleSpacing: 0,
        title: Row(
          children: [
            const Icon(Icons.auto_awesome, size: 20),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Asistente',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                ),
                Text(
                  state.sending ? 'Escribiendo…' : 'IA · consulta tus datos',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: Colors.white.withValues(alpha: 0.75),
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          if (!state.isEmpty)
            IconButton(
              tooltip: 'Nueva conversación',
              icon: const Icon(Icons.add_comment_outlined),
              onPressed: () => ref.read(assistantProvider.notifier).reset(),
            ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: state.isEmpty && !state.sending
                ? _EmptyState(onSuggestion: _send)
                : _MessageList(scroll: _scroll, state: state),
          ),
          _InputBar(
            controller: _controller,
            focus: _focus,
            canSend: _hasText && !state.sending,
            onSend: _send,
          ),
        ],
      ),
    );
  }
}

// ── Empty state ──────────────────────────────────────────────────────────────

class _EmptyState extends StatelessWidget {
  final void Function(String) onSuggestion;
  const _EmptyState({required this.onSuggestion});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(24, 48, 24, 24),
      children: [
        Center(
          child: Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.primary, AppColors.primaryLight],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: const Icon(Icons.auto_awesome, color: Colors.white, size: 34),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'Hola, soy tu asistente',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w800,
                color: context.appText,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          'Pregúntame en lenguaje natural sobre tus facturas y clientes. '
          'De momento soy solo lectura.',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: context.appTextMuted,
                height: 1.4,
              ),
        ),
        const SizedBox(height: 28),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          alignment: WrapAlignment.center,
          children: [
            for (final s in _AssistantScreenState._suggestions)
              _SuggestionChip(label: s, onTap: () => onSuggestion(s)),
          ],
        ),
      ],
    );
  }
}

class _SuggestionChip extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _SuggestionChip({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: context.appPrimarySoft,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: context.appPrimary.withValues(alpha: 0.2)),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: context.appPrimary,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}

// ── Message list ─────────────────────────────────────────────────────────────

class _MessageList extends StatelessWidget {
  final ScrollController scroll;
  final AssistantState state;
  const _MessageList({required this.scroll, required this.state});

  @override
  Widget build(BuildContext context) {
    final count = state.messages.length + (state.sending ? 1 : 0);
    return ListView.builder(
      controller: scroll,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      itemCount: count,
      itemBuilder: (context, i) {
        if (state.sending && i == state.messages.length) {
          return const _TypingBubble();
        }
        return _MessageBubble(message: state.messages[i]);
      },
    );
  }
}

class _MessageBubble extends StatelessWidget {
  final ChatMessage message;
  const _MessageBubble({required this.message});

  String? _toolsLabel(List<String> tools) {
    final groups = <String>{};
    for (final t in tools) {
      if (t.contains('invoice')) {
        groups.add('facturas');
      } else if (t.contains('client')) {
        groups.add('clientes');
      }
    }
    return groups.isEmpty ? null : 'Consultó: ${groups.join(', ')}';
  }

  @override
  Widget build(BuildContext context) {
    final isUser = message.role == ChatRole.user;
    final toolsLabel = isUser ? null : _toolsLabel(message.toolsUsed);

    final bg = isUser
        ? context.appPrimary
        : message.isError
            ? context.statusDangerSoft
            : context.appSurfaceRaised;
    final fg = isUser
        ? Colors.white
        : message.isError
            ? context.statusDanger
            : context.appText;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment:
            isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment:
                isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (!isUser) ...[
                _Avatar(isError: message.isError),
                const SizedBox(width: 8),
              ],
              Flexible(
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.76,
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: bg,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(16),
                      topRight: const Radius.circular(16),
                      bottomLeft: Radius.circular(isUser ? 16 : 4),
                      bottomRight: Radius.circular(isUser ? 4 : 16),
                    ),
                    border: isUser
                        ? null
                        : Border.all(
                            color: message.isError
                                ? context.statusDanger.withValues(alpha: 0.25)
                                : context.appBorder,
                          ),
                  ),
                  child: (isUser || message.isError)
                      ? Text(
                          message.text,
                          style: TextStyle(color: fg, fontSize: 15, height: 1.4),
                        )
                      : MarkdownText(text: message.text, color: fg),
                ),
              ),
            ],
          ),
          if (toolsLabel != null)
            Padding(
              padding: const EdgeInsets.only(left: 40, top: 4),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.search, size: 12, color: context.appTextSubtle),
                  const SizedBox(width: 4),
                  Text(
                    toolsLabel,
                    style: TextStyle(
                      fontSize: 11,
                      color: context.appTextSubtle,
                      fontWeight: FontWeight.w500,
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

class _Avatar extends StatelessWidget {
  final bool isError;
  const _Avatar({this.isError = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        gradient: isError
            ? null
            : const LinearGradient(
                colors: [AppColors.primary, AppColors.primaryLight],
              ),
        color: isError ? context.statusDangerSoft : null,
        borderRadius: BorderRadius.circular(9),
      ),
      child: Icon(
        isError ? Icons.error_outline : Icons.auto_awesome,
        size: 16,
        color: isError ? context.statusDanger : Colors.white,
      ),
    );
  }
}

class _TypingBubble extends StatelessWidget {
  const _TypingBubble();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          const _Avatar(),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: context.appSurfaceRaised,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
                bottomLeft: Radius.circular(4),
                bottomRight: Radius.circular(16),
              ),
              border: Border.all(color: context.appBorder),
            ),
            child: const _TypingDots(),
          ),
        ],
      ),
    );
  }
}

class _TypingDots extends StatefulWidget {
  const _TypingDots();

  @override
  State<_TypingDots> createState() => _TypingDotsState();
}

class _TypingDotsState extends State<_TypingDots>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c =
      AnimationController(vsync: this, duration: const Duration(milliseconds: 1000))
        ..repeat();

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 34,
      height: 8,
      child: AnimatedBuilder(
        animation: _c,
        builder: (context, _) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(3, (i) {
              final t = (_c.value - i * 0.2) % 1.0;
              final scale = 0.6 + 0.4 * (1 - (t - 0.5).abs() * 2).clamp(0.0, 1.0);
              return Transform.scale(
                scale: scale,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: context.appTextSubtle,
                    shape: BoxShape.circle,
                  ),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}

// ── Input bar ────────────────────────────────────────────────────────────────

class _InputBar extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focus;
  final bool canSend;
  final void Function([String?]) onSend;

  const _InputBar({
    required this.controller,
    required this.focus,
    required this.canSend,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.appSurface,
        border: Border(top: BorderSide(color: context.appBorder)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Micrófono — la voz llega en una fase posterior.
              IconButton(
                icon: const Icon(Icons.mic_none_rounded),
                color: context.appTextMuted,
                tooltip: 'Voz (próximamente)',
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('🎤 La voz llegará muy pronto'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
              ),
              Expanded(
                child: Container(
                  constraints: const BoxConstraints(maxHeight: 120),
                  decoration: BoxDecoration(
                    color: context.appBackground,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: context.appBorder),
                  ),
                  child: TextField(
                    controller: controller,
                    focusNode: focus,
                    minLines: 1,
                    maxLines: 5,
                    textInputAction: TextInputAction.newline,
                    style: TextStyle(color: context.appText, fontSize: 15),
                    decoration: InputDecoration(
                      hintText: 'Escribe tu mensaje…',
                      hintStyle: TextStyle(color: context.appTextSubtle),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              _SendButton(enabled: canSend, onTap: () => onSend()),
            ],
          ),
        ),
      ),
    );
  }
}

class _SendButton extends StatelessWidget {
  final bool enabled;
  final VoidCallback onTap;
  const _SendButton({required this.enabled, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: enabled ? context.appPrimary : context.appBorder,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: const Icon(Icons.arrow_upward_rounded),
        color: enabled ? Colors.white : context.appTextSubtle,
        onPressed: enabled ? onTap : null,
      ),
    );
  }
}

// ── Markdown ligero ───────────────────────────────────────────────────────────
// Renderiza el subconjunto de Markdown que suele devolver el LLM: **negrita**,
// *cursiva*, `código`, títulos (#/##/###) y listas con - o *. Sin dependencias.

class MarkdownText extends StatelessWidget {
  final String text;
  final Color color;
  const MarkdownText({super.key, required this.text, required this.color});

  static final _inlineRe =
      RegExp(r'\*\*(.+?)\*\*|`(.+?)`|\*(.+?)\*|_(.+?)_');
  static final _headingRe = RegExp(r'^(#{1,6})\s+(.*)$');
  static final _bulletRe = RegExp(r'^\s*[-*]\s+(.*)$');

  List<InlineSpan> _inline(String input, TextStyle base) {
    final spans = <InlineSpan>[];
    var last = 0;
    for (final m in _inlineRe.allMatches(input)) {
      if (m.start > last) {
        spans.add(TextSpan(text: input.substring(last, m.start), style: base));
      }
      if (m.group(1) != null) {
        spans.add(TextSpan(
          text: m.group(1),
          style: base.copyWith(fontWeight: FontWeight.w700),
        ));
      } else if (m.group(2) != null) {
        spans.add(TextSpan(
          text: m.group(2),
          style: base.copyWith(
            fontFamily: 'monospace',
            fontSize: (base.fontSize ?? 15) - 1,
          ),
        ));
      } else if (m.group(3) != null) {
        spans.add(TextSpan(
          text: m.group(3),
          style: base.copyWith(fontStyle: FontStyle.italic),
        ));
      } else if (m.group(4) != null) {
        spans.add(TextSpan(
          text: m.group(4),
          style: base.copyWith(fontStyle: FontStyle.italic),
        ));
      }
      last = m.end;
    }
    if (last < input.length) {
      spans.add(TextSpan(text: input.substring(last), style: base));
    }
    return spans;
  }

  @override
  Widget build(BuildContext context) {
    final base = TextStyle(color: color, fontSize: 15, height: 1.4);
    final lines = text.split('\n');
    final children = <Widget>[];

    for (final raw in lines) {
      final line = raw.trimRight();

      if (line.trim().isEmpty) {
        children.add(const SizedBox(height: 6));
        continue;
      }

      final heading = _headingRe.firstMatch(line);
      if (heading != null) {
        final level = heading.group(1)!.length;
        final size = level <= 1 ? 18.0 : (level == 2 ? 16.5 : 15.5);
        children.add(Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: Text.rich(TextSpan(
            children: _inline(
              heading.group(2)!,
              base.copyWith(fontWeight: FontWeight.w800, fontSize: size),
            ),
          )),
        ));
        continue;
      }

      final bullet = _bulletRe.firstMatch(line);
      if (bullet != null) {
        children.add(Padding(
          padding: const EdgeInsets.only(bottom: 2),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('•  ', style: base),
              Expanded(
                child: Text.rich(TextSpan(children: _inline(bullet.group(1)!, base))),
              ),
            ],
          ),
        ));
        continue;
      }

      children.add(Text.rich(TextSpan(children: _inline(line, base))));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: children,
    );
  }
}
