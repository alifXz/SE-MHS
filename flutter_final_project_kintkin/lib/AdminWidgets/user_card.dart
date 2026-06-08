import 'package:flutter/material.dart';

class UserModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String role;
  final String status;
  final DateTime joinDate;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.role,
    required this.status,
    required this.joinDate,
  });
}

class UserCard extends StatelessWidget {
  final UserModel user;
  final VoidCallback? onView;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const UserCard({
    super.key,
    required this.user,
    this.onView,
    this.onEdit,
    this.onDelete,
  });

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return const Color(0xFF22C55E);
      case 'inactive':
      case 'banned':
        return const Color(0xFFF59E0B);
      default:
        return const Color(0xFF6B7280);
    }
  }

  String _displayStatus(String status) {
    if (status.toLowerCase() == 'banned') return 'Inactive';
    return status[0].toUpperCase() + status.substring(1);
  }

  Color _avatarColor() {
    final colors = [
      const Color(0xFF1B4F6B),
      const Color(0xFF801A1A),
      const Color(0xFF003049),
      const Color(0xFF333230),
    ];
    if (user.name.isEmpty) return colors[0];
    return colors[user.name.codeUnitAt(0) % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _statusColor(user.status);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      height: 165,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Container(
                width: 100,
                color: _avatarColor(),
                child: Center(
                  child: Text(
                    user.name.isNotEmpty ? user.name[0].toUpperCase() : '?',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(6, 14, 14, 12),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 44),
                        child: Text(
                          user.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1B4F6B).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          user.role,
                          style: const TextStyle(
                            fontSize: 11,
                            color: Color(0xFF1B4F6B),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const Spacer(),
                      _detailRow(Icons.email_outlined, user.email),
                      const SizedBox(height: 3),
                      _detailRow(Icons.phone_outlined, user.phone),
                      const SizedBox(height: 3),
                      _detailRow(
                        Icons.calendar_today_outlined,
                        '${user.joinDate.day}/${user.joinDate.month}/${user.joinDate.year}',
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          _actionIcon(
                            Icons.visibility_outlined,
                            const Color(0xFF1B4F6B),
                            onView,
                          ),
                          const SizedBox(width: 6),
                          _actionIcon(
                            Icons.edit_outlined,
                            const Color(0xFF333230),
                            onEdit,
                          ),
                          const SizedBox(width: 6),
                          _actionIcon(
                            Icons.delete_outline,
                            const Color(0xFF801A1A),
                            onDelete,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Tooltip(
                      message: _displayStatus(user.status),
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: statusColor,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          user.status.toLowerCase() == 'active'
                              ? Icons.check
                              : Icons.pause,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _detailRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 13, color: Colors.grey),
        const SizedBox(width: 5),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _actionIcon(IconData icon, Color color, VoidCallback? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 15, color: color),
      ),
    );
  }
}
