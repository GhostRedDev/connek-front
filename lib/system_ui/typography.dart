import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// React-style Component: AppText
/// Props: children (text), variant, color, align, maxLines, overflow
class AppText extends StatelessWidget {
  final String text;
  final TextStyle? style; // Override style or use variant logic
  final TextAlign? textAlign;
  final Color? color;
  final int? maxLines;
  final TextOverflow? overflow;

  const AppText(
    this.text, {
    super.key,
    this.style,
    this.textAlign,
    this.color,
    this.maxLines,
    this.overflow,
  });

  /// H1: Large Heading
  factory AppText.h1(
    String text, {
    Color? color,
    TextAlign? textAlign,
    TextStyle? style,
  }) {
    return _AppTextVariant(
      text,
      variant: _AppTextVariantType.h1,
      color: color,
      textAlign: textAlign,
      style: style,
    );
  }

  /// H2: Heading
  factory AppText.h2(
    String text, {
    Color? color,
    TextAlign? textAlign,
    TextStyle? style,
  }) {
    return _AppTextVariant(
      text,
      variant: _AppTextVariantType.h2,
      color: color,
      textAlign: textAlign,
      style: style,
    );
  }

  /// H3: Subheading
  factory AppText.h3(
    String text, {
    Color? color,
    TextAlign? textAlign,
    TextStyle? style,
  }) {
    return _AppTextVariant(
      text,
      variant: _AppTextVariantType.h3,
      color: color,
      textAlign: textAlign,
      style: style,
    );
  }

  /// H4: Small Heading
  factory AppText.h4(
    String text, {
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    TextStyle? style,
  }) {
    return _AppTextVariant(
      text,
      variant: _AppTextVariantType.h4,
      color: color,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      style: style,
    );
  }

  /// Display: Giant Text
  factory AppText.display(
    String text, {
    Color? color,
    TextAlign? textAlign,
    TextStyle? style,
  }) {
    return _AppTextVariant(
      text,
      variant: _AppTextVariantType.display,
      color: color,
      textAlign: textAlign,
      style: style,
    );
  }

  /// Paragraph / Body
  factory AppText.p(
    String text, {
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    TextStyle? style,
  }) {
    return _AppTextVariant(
      text,
      variant: _AppTextVariantType.p,
      color: color,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      style: style,
    );
  }

  /// Bold Text
  factory AppText.large(
    String text, {
    Color? color,
    TextAlign? textAlign,
    TextStyle? style,
  }) {
    return _AppTextVariant(
      text,
      variant: _AppTextVariantType.large,
      color: color,
      textAlign: textAlign,
      style: style,
    );
  }

  /// Small Text
  factory AppText.small(
    String text, {
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    TextStyle? style,
  }) {
    return _AppTextVariant(
      text,
      variant: _AppTextVariantType.small,
      color: color,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      style: style,
    );
  }

  /// Muted (Gray) Text
  factory AppText.muted(
    String text, {
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    TextStyle? style,
  }) {
    return _AppTextVariant(
      text,
      variant: _AppTextVariantType.muted,
      color: color,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      style: style,
    );
  }

  /// Blockquote
  factory AppText.blockquote(
    String text, {
    Color? color,
    TextAlign? textAlign,
    TextStyle? style,
  }) {
    return _AppTextVariant(
      text,
      variant: _AppTextVariantType.blockquote,
      color: color,
      textAlign: textAlign,
      style: style,
    );
  }

  /// Code / Monospace
  factory AppText.code(
    String text, {
    Color? color,
    TextAlign? textAlign,
    TextStyle? style,
  }) {
    return _AppTextVariant(
      text,
      variant: _AppTextVariantType.code,
      color: color,
      textAlign: textAlign,
      style: style,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style?.copyWith(color: color),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}

enum _AppTextVariantType {
  h1,
  h2,
  h3,
  h4,
  p,
  large,
  small,
  muted,
  lead,
  display,
  blockquote,
  code,
}

class _AppTextVariant extends AppText {
  final _AppTextVariantType variant;

  const _AppTextVariant(
    super.text, {
    required this.variant,
    super.color,
    super.textAlign,
    super.maxLines,
    super.overflow,
    super.style,
  });

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    TextStyle? effectiveStyle;

    switch (variant) {
      case _AppTextVariantType.h1:
        effectiveStyle = theme.textTheme.h1;
        break;
      case _AppTextVariantType.h2:
        effectiveStyle = theme.textTheme.h2;
        break;
      case _AppTextVariantType.h3:
        effectiveStyle = theme.textTheme.h3;
        break;
      case _AppTextVariantType.h4:
        effectiveStyle = theme.textTheme.h4;
        break;
      case _AppTextVariantType.p:
        effectiveStyle = theme.textTheme.p;
        break;
      case _AppTextVariantType.large:
        effectiveStyle = theme.textTheme.large;
        break;
      case _AppTextVariantType.small:
        effectiveStyle = theme.textTheme.small;
        break;
      case _AppTextVariantType.muted:
        effectiveStyle = theme.textTheme.muted;
        break;
      case _AppTextVariantType.lead:
        effectiveStyle = theme.textTheme.lead;
        break;
      case _AppTextVariantType.display:
        // Display usually bigger than H1. Assuming h1 for now or larger if custom.
        effectiveStyle = theme.textTheme.h1.copyWith(
          fontSize: 48,
          letterSpacing: -1.0,
        );
        break;
      case _AppTextVariantType.blockquote:
        effectiveStyle = theme.textTheme.p.copyWith(
          fontStyle: FontStyle.italic,
          color: theme.colorScheme.mutedForeground,
        );
        break;
      case _AppTextVariantType.code:
        effectiveStyle = theme.textTheme.small.copyWith(
          fontFamily: 'monospace',
          backgroundColor: theme.colorScheme.muted.withOpacity(0.3),
        );
        break;
    }

    // Merge: default -> variant -> custom style -> custom color
    return Text(
      text,
      style: effectiveStyle.merge(style).copyWith(color: color),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
