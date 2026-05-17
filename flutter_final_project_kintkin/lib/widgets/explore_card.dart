import 'package:flutter/material.dart';

class ExploreCard extends StatelessWidget {
  final bool isCommunity;
  const ExploreCard({super.key, required this.isCommunity});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Section
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              "https://images.unsplash.com/photo-1526676023131-d352423b0694?q=80&w=400",
              width: 120,
              height: 140,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
          // Details Section
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Row: Community Name + Icon
                Row(
                  children: [
                    const Icon(
                      Icons.account_circle,
                      size: 16,
                      color: Color(0xFF00334E),
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      "Bouldering Community",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.directions_run,
                      size: 18,
                      color: Colors.amber,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  "Rock Climbing Meet Up",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                _infoRow(Icons.location_on_outlined, "Boulder Planet, Jakarta"),
                const SizedBox(height: 4),
                _infoRow(Icons.access_time_outlined, "10:00 - 15:00 WIB"),
                if (!isCommunity) ...[
                  const SizedBox(height: 4),
                  _infoRow(
                    Icons.calendar_month_outlined,
                    "Monday, 3rd August 2026",
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 14, color: Colors.grey[600]),
        const SizedBox(width: 6),
        Text(text, style: TextStyle(fontSize: 11, color: Colors.grey[600])),
      ],
    );
  }
}
