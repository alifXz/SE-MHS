import 'package:flutter/material.dart';
import '../AdminWidgets/adminDrawer.dart';
class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDD835),
      appBar: AppBar(
        backgroundColor: const Color(0XFFF9A825),
        elevation: 3,
        shadowColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.blueGrey),
        title: const Text(
          'Wellcome !'
        ),
      ),
      drawer: const Admindrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const StatCard(

            )
          ],
        ),
      ),
    );
  }
}