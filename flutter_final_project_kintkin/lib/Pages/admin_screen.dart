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
      appBar: AppBar(
        backgroundColor:Color.fromARGB(255, 107, 107, 107),
        elevation: 4,
        shadowColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.blueGrey),
        title: const Text(
          'Welcome !',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w500,
            fontSize: 22,
          ),
        ),
      ),
      drawer: const Admindrawer(),
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
                    title: 'Communities',
                    value: '4',
                    icon: Icons.forum,
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