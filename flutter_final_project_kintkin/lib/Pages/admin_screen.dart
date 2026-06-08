import 'package:flutter/material.dart';
import 'package:flutter_final_project_kintkin/AdminWidgets/StatisticsCard.dart';
import 'package:flutter_final_project_kintkin/AdminWidgets/api_status_card.dart';
import 'package:flutter_final_project_kintkin/AdminWidgets/event_leaderboard_card.dart';
import '../AdminWidgets/adminDrawer.dart';
class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 237, 237, 237),
      appBar:  AppBar(
        automaticallyImplyLeading: false,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black87),
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
              icon: const Icon(Icons.menu, color: Colors.black87),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
            ),
          ),
        ],
      ),
      endDrawer: const Admindrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            const StatCard(
              title: 'Total Participants Joined :',
              value: '20',
              icon: Icons.groups,
            ),
            const SizedBox(height: 16),
            const Row(
              children: [
                Expanded(
                  child: StatCard(
                    title: 'Active Events',
                    value: '12',
                    icon: Icons.event_available,
                    isSmall: true,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: StatCard(
                    title: 'Users',
                    value: '4',
                    icon: Icons.person_2_rounded,
                    isSmall: true,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const StatCard(
              title: 'Total Revenue :',
              value: 'Rp 16.000.000',
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