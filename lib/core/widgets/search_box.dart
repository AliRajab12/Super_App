import 'dart:async';

import 'package:somi/core/theme/colors.dart';
import 'package:flutter/material.dart';

class SearchBox extends StatefulWidget {
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final Duration? debounce;
  final String? hintText;
  final bool whiteBackground;
  final bool reducedHeight;

  const SearchBox({
    super.key,
    this.controller,
    this.onChanged,
    this.debounce = const Duration(milliseconds: 300),
    this.hintText,
    this.whiteBackground = true,
    this.reducedHeight = false,
  });

  const SearchBox.appBar({
    super.key,
    this.controller,
    this.onChanged,
    this.debounce = const Duration(milliseconds: 300),
    this.hintText,
  })  : whiteBackground = false,
        reducedHeight = true;

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  String? lastText = '';
  Timer? _searchDebounce;

  @override
  void dispose() {
    _searchDebounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 48),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: widget.reducedHeight ? 36 : 40,
            decoration: BoxDecoration(
              color:
                  widget.whiteBackground ? Colors.white : AppColors.background,
              borderRadius: BorderRadius.circular(100),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Row(
              children: [
                const Icon(Icons.search, size: 16),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    onChanged: _handleTextChange,
                    controller: widget.controller,
                    decoration: InputDecoration(
                      filled: false,
                      hintStyle: Theme.of(context).textTheme.labelMedium,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      hintText: widget.hintText,
                      contentPadding:
                          const EdgeInsets.only(top: 14, bottom: 16),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _handleTextChange(String newText) {
    if (widget.debounce == null) {
      widget.onChanged?.call(newText);
      return;
    }
    if (newText == lastText) return;
    lastText = newText;
    if (_searchDebounce?.isActive ?? false) _searchDebounce?.cancel();
    _searchDebounce = Timer(
      newText.isEmpty ? Duration.zero : widget.debounce!,
      () => widget.onChanged?.call(newText),
    );
  }
}
