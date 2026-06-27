import 'package:flutter/material.dart';
import 'event_popup_modal.dart';
import 'package:flutter_final_project_kintkin/models/event_model.dart';

class ExploreCard extends StatelessWidget {
  final bool isCommunity;
  final EventModel event;

  const ExploreCard({
    super.key, 
    required this.isCommunity,
    required this.event,
  });

  IconData _getCategoryIcon() {
    switch (event.category.toLowerCase()) {
      case 'sports':
        return Icons.directions_run;

      case 'gaming':
        return Icons.sports_esports;

      case 'music':
        return Icons.music_note;

      case 'group activity':
        return Icons.groups;

      case 'board games':
        return Icons.casino;

      case 'cooking':
        return Icons.restaurant;

      case 'art':
        return Icons.palette;

      case 'others':
        return Icons.style;

      default:
        return Icons.event;
    }
  }

  @override
  Widget build(BuildContext context) {
    return isCommunity ? _buildCommunityCard() : _buildEventCard(context);
  }

  //Event Cards
  Widget _buildEventCard(BuildContext context) {
    return GestureDetector(
    onTap: () => EventPopupModal.show(context, event: event),
    child: Container(
      margin: const EdgeInsets.only(bottom: 16),
      height: 180,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Left Image
          Padding(
            padding: const EdgeInsets.all(5),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: SizedBox(
                width: 130,
                height: double.infinity,
                child: Image.network(
                  event.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          //Event Details
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Organizer row
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 10,
                            backgroundColor: Color(0xFF4A90D9),
                            child: Icon(Icons.person, color: Colors.white, size: 16),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              event.organizer,
                              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 11),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Text(
                        event.title,
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, height: 1.2),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.location_on_outlined, size: 14, color: Colors.grey),
                          SizedBox(width: 4),
                          Flexible(child: Text(event.location, style: TextStyle(fontSize: 12, color: Colors.grey))),
                        ],
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.access_time_outlined, size: 14, color: Colors.grey),
                          SizedBox(width: 4),
                          Text("${event.startTime.substring(0, 5)}" " - " "${event.endTime.substring(0, 5)}", style: TextStyle(fontSize: 12, color: Colors.grey)),
                        ],
                      ),
                    ],
                  ),
                  // Activity badge
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      width: 38,
                      height: 38,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFFD700),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(_getCategoryIcon(), color: Colors.black, size: 20),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
    );
  }

Widget _buildCommunityCard() {
  return Container(
    margin: const EdgeInsets.only(bottom: 16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.08),
          blurRadius: 16,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Image and Community Profile
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.bottomCenter,
          children: [
            // Banner image
            Padding(
              padding: const EdgeInsets.all(10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: SizedBox(
                  height: 120,
                  width: double.infinity,
                  child: Image.network(
                    'https://images.unsplash.com/photo-1520156557489-31c63271fcd4?q=80&w=987&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            // Overlapping avatar at bottom center
            Positioned(
              bottom: -28,
              child: CircleAvatar(
                radius: 30,
                backgroundColor: const Color(0xFF1B4F6B),
                child: const Icon(Icons.person, color: Colors.white, size: 30),
              ),
            ),
          ],
        ),

        const SizedBox(height: 36),

        // --- BOTTOM CONTENT ---
        Stack(
          children: [
            // Centered name + members
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 0, 14, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Bouldering Community",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.group, size: 22, color: Colors.black87),
                      SizedBox(width: 6),
                      Text(
                        "1,817 Members",
                        style: TextStyle(fontSize: 16, color: Colors.black87),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                ],
              ),
            ),

            // Yellow badge pinned to bottom-left
            Positioned(
              bottom: 16,
              left: 14,
              child: Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: Color(0xFFFFD700),
                  shape: BoxShape.circle,
                ),
                child: Icon(_getCategoryIcon(), color: Colors.black, size: 24),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
}