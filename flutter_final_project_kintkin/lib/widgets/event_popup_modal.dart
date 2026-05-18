import 'package:flutter/material.dart';
import 'join_event_button.dart';

class EventPopupModal extends StatelessWidget {
  const EventPopupModal({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      transitionAnimationController: AnimationController(
        vsync: Navigator.of(context),
        duration: const Duration(milliseconds: 400),
      ),
      builder: (context) => const EventPopupModal(),
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
                            'https://images.unsplash.com/photo-1520156557489-31c63271fcd4?q=80&w=987&auto=format&fit=crop',
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
                              const Expanded(
                                child: Text(
                                  "Rock Climbing Meet-Up",
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
                            children: const [
                              CircleAvatar(
                                radius: 16,
                                backgroundColor: Color(0xFF4A90D9),
                                child: Icon(Icons.person,
                                    color: Colors.white, size: 18),
                              ),
                              SizedBox(width: 10),
                              Text(
                                "Bouldering Community",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black87),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),

                          // Description
                          const Text(
                            "Lorem ipsum dolor sit amet consectetur. Quam ipsum elit a placerat eu vulputate. "
                            "At facilisis aliquet elementum nunc odio commodo. Aliquam interdum libero ut egestas "
                            "dui gravida eu in nunc. Aenean nulla bibendum pellentesque molestie.",
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
                                  children: const [
                                    _DetailRow(
                                      icon: Icons.access_time_outlined,
                                      text: "10:00 – 15:00 WIB",
                                    ),
                                    SizedBox(height: 14),
                                    _DetailRow(
                                      icon: Icons.calendar_month_outlined,
                                      text: "Monday,\n3rd August 2026",
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const _DetailRow(
                                      icon: Icons.location_on_outlined,
                                      text: "Boulder Planet, Jakarta",
                                    ),
                                    const SizedBox(height: 6),
                                    const Padding(
                                      padding: EdgeInsets.only(left: 28),
                                      child: Text("Link :",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black54)),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(left: 28),
                                      child: Text(
                                        "https://maps.app.goo.gl/uauEDrB5f3Aa61BH8",
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
                              const Text(
                                "Boulder Planet Jakarta",
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
                child: JoinButton(),
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