import 'package:flutter/material.dart';

import 'package:flutter_final_project_kintkin/AdminWidgets/StatisticsCard.dart';
import 'package:flutter_final_project_kintkin/AdminWidgets/api_status_card.dart';
import 'package:flutter_final_project_kintkin/AdminWidgets/event_leaderboard_card.dart';
import 'package:flutter_final_project_kintkin/Pages/user_db_screen.dart';


import '../AdminWidgets/adminDrawer.dart';
import '../services/admin_service.dart';

import 'package:intl/intl.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  int totalParticipants = 0;
  int activeEvents = 0;
  int totalRevenue = 0;
  int totalUsers = 0;

  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadDashboard();
  }

  Future<void> loadDashboard() async {
    final service = AdminService();

    try {
      final participants = await service.getTotalParticipants();
      final active = await service.getActiveEvents();
      final revenue = await service.getTotalRevenue();
      final users = await service.getTotalUsers();

      if (!mounted) return;
      
      setState(() {
        totalParticipants = participants;
        activeEvents = active;
        totalRevenue = revenue;
        totalUsers = users;
        loading = false;
      });
    } catch (e) {
      debugPrint('Dashboard Error: $e');

      if (!mounted) return;

      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final formattedRevenue = NumberFormat.decimalPattern('id_ID').format(totalRevenue);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 237, 237, 237),

      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black87,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        title: const Text(
          'Admin Panel',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(
                Icons.menu,
                color: Colors.black87,
              ),
              onPressed: () =>
                  Scaffold.of(context).openEndDrawer(),
            ),
          ),
        ],
      ),

      endDrawer: const Admindrawer(),

      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(32),
              child: Column(
                children: [
                  StatCard(
                    title: 'Total Participants Joined',
                    value: totalParticipants.toString(),
                    icon: Icons.groups,
                  ),

                  const SizedBox(height: 16),

                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          // onTap: () => Navigator.push(
                          //   // context,
                          //   // MaterialPageRoute(builder: (context) => EventScreen()),
                          // ),
                          child: StatCard(
                            title: 'Active Events',
                            value: '12',
                            icon: Icons.event_available,
                            isSmall: true,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => UserDbScreen()),  // ← closing ) was missing
                          ),
                          child: StatCard(
                            title: 'Users',
                            value: '4',
                            icon: Icons.person_2_rounded,
                            isSmall: true,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  StatCard(
                    title: 'Total Revenue',
                    value: 'Rp $formattedRevenue',
                    icon: Icons.account_balance_wallet,
                  ),

                  const SizedBox(height: 16),

                  const ApiStatusCard(),

                  const SizedBox(height: 16),

                  const EventLeaderboardCard(),
                ],
              ),
            ),
    );
  }
}