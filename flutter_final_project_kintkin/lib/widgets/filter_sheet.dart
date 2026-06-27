import 'package:flutter/material.dart';

class FilterCategory {
  //VARIABLE buat di DBnya
  final String id;      
  final String label;
  final IconData icon;
 
  const FilterCategory({
    required this.id,
    required this.label,
    required this.icon,
  });
}

const List<FilterCategory> kFilterCategories = [
  FilterCategory(
    id: 'sports',
    label: 'Sports',
    icon: Icons.directions_run,
  ),

  FilterCategory(
    id: 'gaming',
    label: 'Gaming',
    icon: Icons.sports_esports,
  ),

  FilterCategory(
    id: 'music',
    label: 'Music',
    icon: Icons.music_note,
  ),

  FilterCategory(
    id: 'group activity',
    label: 'Group',
    icon: Icons.groups,
  ),

  FilterCategory(
    id: 'board games',
    label: 'Board Games',
    icon: Icons.casino,
  ),

  FilterCategory(
    id: 'cooking',
    label: 'Cooking',
    icon: Icons.restaurant,
  ),

  FilterCategory(
    id: 'art',
    label: 'Art',
    icon: Icons.palette,
  ),

  FilterCategory(
    id: 'others',
    label: 'Others',
    icon: Icons.style,
  ),
];

Future<Set<String>?> showFilterSheet(
  BuildContext context, {
  Set<String> initialSelected = const {},
}) {
  return showModalBottomSheet<Set<String>>(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (_) => _FilterSheet(initialSelected: initialSelected),
  );
}
 

class _FilterSheet extends StatefulWidget {
  final Set<String> initialSelected;
  const _FilterSheet({required this.initialSelected});
 
  @override
  State<_FilterSheet> createState() => _FilterSheetState();
}
 
class _FilterSheetState extends State<_FilterSheet> {
  late Set<String> _selected = {...widget.initialSelected};
 
  // ikut warna app kamu
  static const _navy = Color(0xFF003049);
  static const _red = Color(0xFF801A1A);
  static const _unselected = Color(0xFF8FA1B3);
 
  void _toggle(String id) {
    setState(() {
      _selected.contains(id) ? _selected.remove(id) : _selected.add(id);
    });
  }
 
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const Text(
              'Filter :',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: _navy,
              ),
            ),
            const SizedBox(height: 20),
            GridView.count(
              crossAxisCount: 4,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 30,
              crossAxisSpacing: 16,
              children: kFilterCategories.map((cat) {
                final isSelected = _selected.contains(cat.id);
                return GestureDetector(
                  onTap: () => _toggle(cat.id),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 150),
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: isSelected ? _navy : _unselected,
                          shape: BoxShape.circle,
                          border: isSelected
                              ? Border.all(color: _red, width: 2)
                              : null,
                        ),
                        child: Icon(cat.icon, color: Colors.white, size: 26),
                      ),
                      const SizedBox(height: 10),
                      Text(cat.label,
                          style: const TextStyle(fontSize: 9, color: _navy)),
                    ],
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            Align(
              alignment: Alignment.centerRight,
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context, _selected),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: _red, width: 1.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                ),
                child: const Text(
                  'Apply',
                  style: TextStyle(
                    color: _navy,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}