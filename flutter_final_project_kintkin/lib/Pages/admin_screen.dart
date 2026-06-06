import 'package:flutter/material.dart';
import 'package:flutter_final_project_kintkin/AdminWidgets/StatisticsCard.dart';
import '../AdminWidgets/adminDrawer.dart';
class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 237, 237, 237),
      appBar: AppBar(
        backgroundColor:Color.fromARGB(255, 255, 255, 255),
        elevation: 0,
        shadowColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.blueGrey),
        title: const Text(
          'Wellcome !',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w500,
            fontSize: 22,
          ),
        ),
      ),
      drawer: const Admindrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
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
          ],
        ),
      ),
    );
  }
}