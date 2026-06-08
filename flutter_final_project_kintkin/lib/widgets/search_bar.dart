import 'package:flutter/material.dart';

class ExploreSearchBar extends StatelessWidget {
  final Function(String) onSearch;
  final VoidCallback? onClear;
  final TextEditingController controller;

  const ExploreSearchBar({
    super.key,
    required this.onSearch,
    required this.controller,
    this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: TextField(
          controller: controller,
          // This triggers every time the user types a letter
          onChanged: onSearch,
          style: const TextStyle(color: Colors.black87),
          decoration: InputDecoration(
            hintText: 'Search events or communities...',
            hintStyle: const TextStyle(color: Colors.black54),
            prefixIcon: const Icon(Icons.search, color: Colors.grey),
            // Show a clear button only if there's text
            suffixIcon: controller.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear, color: Colors.grey, size: 20),
                    onPressed: () {
                      controller.clear();
                      if (onClear != null) onClear!();
                      onSearch(''); // Trigger an empty search to reset the list
                    },
                  )
                : null,
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          ),
        ),
    );
  }
}