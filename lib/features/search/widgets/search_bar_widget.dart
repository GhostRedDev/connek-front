import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/widgets/layout.dart';

class SearchBarWidget extends ConsumerStatefulWidget {
  final Function(String) onSubmitted;
  final Function(String)? onChanged;
  final String? initialValue;
  final String? hintText;

  const SearchBarWidget({
    super.key,
    required this.onSubmitted,
    this.onChanged,
    this.initialValue,
    this.hintText,
  });

  @override
  ConsumerState<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends ConsumerState<SearchBarWidget> {
  late TextEditingController _textController;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: widget.initialValue);
    _focusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    // Hide navbar when focused, show when unfocused
    ref.read(navbarVisibilityProvider.notifier).state = !_focusNode.hasFocus;
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _textController.dispose();
    _focusNode.dispose();
    // Ensure navbar is visible when widget is disposed (e.g. navigating away)
    // ref.read(navbarVisibilityProvider.notifier).state = true;
    // Commented out to prevent "referencing provider after dispose" if context is gone.
    // Safest is to handle this logic where the page/widget is destroyed or effectively rely on layout state reset if needed.
    // For now, let's leave it as is, or use addPostFrameCallback check if mounted.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor =
        Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black;
    final hintColor = Theme.of(context).hintColor;
    final fillColor = isDark
        ? const Color(0xFF22262B).withOpacity(0.5)
        : Colors.grey.shade200;
    final iconColor = isDark ? Colors.white70 : Colors.grey.shade600;

    return Container(
      width: double.infinity,
      height: 50,
      decoration: const BoxDecoration(),
      child: SizedBox(
        width: 200,
        child: TextFormField(
          controller: _textController,
          focusNode: _focusNode,
          onFieldSubmitted: (val) {
            widget.onSubmitted(val);
          },
          onChanged: (val) {
            if (widget.onChanged != null) widget.onChanged!(val);
          },
          autofocus: false,
          enabled: true,
          obscureText: false,
          style: GoogleFonts.inter(
            color: textColor,
            fontWeight: FontWeight.w400,
          ),
          cursorColor: textColor,
          decoration: InputDecoration(
            isDense: true,
            hintText: widget.hintText ?? 'Search for a service or business',
            hintStyle: GoogleFonts.inter(
              color: hintColor,
              fontWeight: FontWeight.w400,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: isDark ? Colors.white24 : Colors.grey.shade300,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(100),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent, width: 2),
              borderRadius: BorderRadius.circular(100),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red, width: 2),
              borderRadius: BorderRadius.circular(100),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red, width: 2),
              borderRadius: BorderRadius.circular(100),
            ),
            prefixIcon: Icon(Icons.search, color: iconColor),
            filled: true,
            fillColor: fillColor,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 12,
            ),
          ),
        ),
      ),
    );
  }
}
