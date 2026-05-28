import 'package:flutter/material.dart';
import 'join_event_button.dart';
import 'package:flutter_final_project_kintkin/models/event_model.dart';

class EventPopupModal extends StatelessWidget {
  final EventModel event;

  const EventPopupModal({
    super.key,
    required this.event,
  });

  static void show(
    BuildContext context, {
      required EventModel event
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      transitionAnimationController: AnimationController(
        vsync: Navigator.of(context),
        duration: const Duration(milliseconds: 400),
      ),
      builder: (context) => EventPopupModal(event: event),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 1.0,
      minChildSize: 0.5,
      maxChildSize: 1.0,
      builder: (context, scrollController) {
        return Container(
          color: Colors.white,
          child: Stack(
            children: [
              SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
                    //BUAT GAMBAR
                    Stack(
                      children: [
                        SizedBox(
                          height: 300,
                          width: double.infinity,
                          child: Image.network(
                            event.imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                        

                        //BACK BUTTON
                        Positioned(
                          top: 20,
                          left: 16,
                          child: SafeArea(
                            child: GestureDetector(
                              onTap: () => Navigator.of(context).pop(),
                              child: Container(
                                width: 42,
                                height: 42,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF1B4F6B),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.arrow_back, color: Colors.white, size: 22),
                              ),
                            ),
                          ),
                        ),

                        // ACTIVITY BADGE (YANG KUNING2
                        Positioned(
                          bottom: 16,
                          left: 16,
                          child: Container(
                            width: 48,
                            height: 48,
                            decoration: const BoxDecoration(
                              color: Color(0xFFFFC107),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.directions_run,
                                color: Colors.black, size: 26),
                          ),
                        ),
                      ],
                    ),

                    // Body
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Title + type badge
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  event.title,
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      height: 1.2),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 14, vertical: 7),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF1B3A4A),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Text(
                                  "Meet Up",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),

                          // Organizer
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 16,
                                backgroundColor: Color(0xFF4A90D9),
                                child: Icon(Icons.person,
                                    color: Colors.white, size: 18),
                              ),
                              SizedBox(width: 10),
                              Text(
                                event.organizer,
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black87),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),

                          // Description
                          Text(
                            event.description,
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                                height: 1.65),
                          ),
                          const SizedBox(height: 20),

                          // Time / Date / Location
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _DetailRow(
                                      icon: Icons.access_time_outlined,
                                      text: "${event.startTime.substring(0, 5)}" " - " "${event.endTime.substring(0, 5)}",
                                    ),
                                    SizedBox(height: 14),
                                    _DetailRow(
                                      icon: Icons.calendar_month_outlined,
                                      text: event.eventDate,
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _DetailRow(
                                      icon: Icons.location_on_outlined,
                                      text: event.location,
                                    ),
                                    const SizedBox(height: 6),
                                    const Padding(
                                      padding: EdgeInsets.only(left: 28),
                                      child: Text("Link :",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black54)),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 28),
                                      child: Text(
                                        event.locationLink,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Color(0xFF1565C0),
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),

                          // Venue Partner
                          const Text(
                            "Venue Partner :",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE8F0F8),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Icon(Icons.business,
                                    color: Color(0xFF4A7AB5), size: 22),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                event.venuePartner,
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(width: 6),
                              const Icon(Icons.verified,
                                  color: Color(0xFF4A90D9), size: 18),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Pinned Join button
             Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: JoinButton(event: event),
              ),
            ],
          ),
        );
      },
    );
  }
}

// Private reusable detail row
class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _DetailRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: Colors.black54),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
                fontSize: 13, fontWeight: FontWeight.w600, height: 1.4),
          ),
        ),
      ],
    );
  }
}