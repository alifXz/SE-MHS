import 'package:flutter/material.dart';
import 'package:flutter_final_project_kintkin/AdminWidgets/user_card.dart';

class UserDbScreen extends StatefulWidget {
  const UserDbScreen({super.key});

  @override
  State<UserDbScreen> createState() => _UserDbScreenState();
}

class _UserDbScreenState extends State<UserDbScreen> {
  bool _isLoading = false;

  final List<UserModel> _allUsers = [
    UserModel(
      id: 'USR001',
      name: 'Alice Johnson',
      email: 'alice@example.com',
      phone: '+62 811 1111 1111',
      role: 'Admin',
      status: 'active',
      joinDate: DateTime(2023, 1, 10),
    ),
    UserModel(
      id: 'USR002',
      name: 'Bob Smith',
      email: 'bob@example.com',
      phone: '+62 822 2222 2222',
      role: 'User',
      status: 'inactive',
      joinDate: DateTime(2023, 5, 22),
    ),
    UserModel(
      id: 'USR003',
      name: 'Clara Lee',
      email: 'clara@example.com',
      phone: '+62 833 3333 3333',
      role: 'Moderator',
      status: 'active',
      joinDate: DateTime(2023, 8, 3),
    ),
    UserModel(
      id: 'USR004',
      name: 'David Kim',
      email: 'david@example.com',
      phone: '+62 844 4444 4444',
      role: 'User',
      status: 'banned',
      joinDate: DateTime(2024, 2, 14),
    ),
    UserModel(
      id: 'USR005',
      name: 'Eva Martinez',
      email: 'eva@example.com',
      phone: '+62 855 5555 5555',
      role: 'User',
      status: 'active',
      joinDate: DateTime(2024, 4, 1),
    ),
    UserModel(
      id: 'USR006',
      name: 'Frank Chen',
      email: 'frank@example.com',
      phone: '+62 866 6666 6666',
      role: 'Moderator',
      status: 'inactive',
      joinDate: DateTime(2024, 6, 19),
    ),
  ];

  String _selectedRole = 'All';
  String _selectedStatus = 'All';

  List<String> get _roles {
    final roles = _allUsers
        .map((u) => u.role)
        .where((r) => r != 'Moderator')
        .toSet()
        .toList()
      ..sort();
    return ['All', ...roles];
  }

  List<UserModel> get _filteredUsers {
    return _allUsers.where((u) {
      final roleMatch = _selectedRole == 'All' || u.role == _selectedRole;
      final statusMatch =
          _selectedStatus == 'All' || u.status == _selectedStatus;
      return roleMatch && statusMatch;
    }).toList();
  }

  Future<void> _onRefresh() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1));
    setState(() => _isLoading = false);
  }

  void _showDeleteDialog(UserModel user) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Delete User'),
        content: Text('Are you sure you want to delete ${user.name}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${user.name} deleted')),
              );
            },
            child: const Text(
              'Delete',
              style: TextStyle(color: Color(0xFF801A1A)),
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctx, setSheetState) {
            return Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Filter Users',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setSheetState(() {
                            _selectedRole = 'All';
                            _selectedStatus = 'All';
                          });
                          setState(() {});
                        },
                        child: const Text(
                          'Reset',
                          style: TextStyle(color: Color(0xFF801A1A)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Role',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: _roles.map((role) {
                      final selected = _selectedRole == role;
                      return ChoiceChip(
                        label: Text(role),
                        selected: selected,
                        selectedColor: const Color(0xFF333230),
                        labelStyle: TextStyle(
                          color: selected ? Colors.white : Colors.black87,
                          fontWeight: FontWeight.w500,
                        ),
                        onSelected: (_) {
                          setSheetState(() => _selectedRole = role);
                          setState(() {});
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Status',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: ['All', 'active', 'inactive'].map((s) {
                      final selected = _selectedStatus == s;
                      final label = s == 'All'
                          ? 'All'
                          : s[0].toUpperCase() + s.substring(1);
                      return ChoiceChip(
                        label: Text(label),
                        selected: selected,
                        selectedColor: const Color(0xFF333230),
                        labelStyle: TextStyle(
                          color: selected ? Colors.white : Colors.black87,
                          fontWeight: FontWeight.w500,
                        ),
                        onSelected: (_) {
                          setSheetState(() => _selectedStatus = s);
                          setState(() {});
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF333230),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () => Navigator.pop(ctx),
                      child: const Text(
                        'Apply',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredUsers;
    final hasActiveFilters =
        _selectedRole != 'All' || _selectedStatus != 'All';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 34, vertical: 15),
            child: Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
                const SizedBox(width: 16),
                const Text(
                  'User Database',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const Spacer(),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.filter_list, color: Colors.black),
                      onPressed: _showFilterSheet,
                    ),
                    if (hasActiveFilters)
                      Positioned(
                        top: 10,
                        right: 10,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Color(0xFF801A1A),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          if (hasActiveFilters)
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 4, 24, 0),
              child: Row(
                children: [
                  Text(
                    '${filtered.length} user${filtered.length != 1 ? 's' : ''}',
                    style: const TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () => setState(() {
                      _selectedRole = 'All';
                      _selectedStatus = 'All';
                    }),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 3),
                      decoration: BoxDecoration(
                        color: const Color(0xFF801A1A).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Clear filters',
                            style: TextStyle(
                              color: Color(0xFF801A1A),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 4),
                          Icon(Icons.close, size: 12, color: Color(0xFF801A1A)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _onRefresh,
              color: const Color(0xFF333230),
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : filtered.isEmpty
                      ? ListView(
                          children: const [
                            SizedBox(height: 120),
                            Center(
                              child: Column(
                                children: [
                                  Icon(Icons.person_off_outlined,
                                      size: 48, color: Colors.grey),
                                  SizedBox(height: 12),
                                  Text(
                                    'No users found',
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 15),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
                          itemCount: filtered.length,
                          itemBuilder: (context, index) {
                            final user = filtered[index];
                            return UserCard(
                              user: user,
                              onView: () {},
                              onEdit: () {},
                              onDelete: () => _showDeleteDialog(user),
                            );
                          },
                        ),
            ),
          ),
        ],
      ),
    );
  }
}
