import 'package:flutter/material.dart';
import 'package:flutter_final_project_kintkin/models/user_model.dart';

class UserCard extends StatelessWidget {
  final UserModel user;
  final VoidCallback? onDelete;

  const UserCard({
    super.key,
    required this.user,
    this.onDelete,
  });

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
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      height: 190,
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
            padding: const EdgeInsets.all(14),
            child: Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _avatarColor(),
                boxShadow: [
                  BoxShadow(
                    color: _avatarColor().withValues(alpha: 0.35),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  user.name.isNotEmpty ? user.name[0].toUpperCase() : '?',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(6, 14, 14, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '#${user.id}',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey.shade400,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.4,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    user.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
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
                  // handle nullable phoneNumber
                  _detailRow(Icons.phone_outlined, user.phoneNumber ?? 'No phone'),
                  const SizedBox(height: 3),
                  // handle nullable joinDate
                  _detailRow(
                    Icons.calendar_today_outlined,
                    user.joinDate != null
                        ? '${user.joinDate!.day}/${user.joinDate!.month}/${user.joinDate!.year}'
                        : 'Unknown',
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _actionIcon(
                        Icons.delete_outline,
                        const Color(0xFF801A1A),
                        onDelete,
                      ),
                    ],
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