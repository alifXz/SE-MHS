import 'package:flutter/material.dart';
import 'package:flutter_final_project_kintkin/models/event_model.dart';
import 'package:flutter_final_project_kintkin/services/auth_service.dart';
import 'package:flutter_final_project_kintkin/services/event_service.dart';
import 'package:flutter_final_project_kintkin/widgets/app_drawer.dart';
import '../widgets/basic_card.dart';

class ActivityHistory extends StatefulWidget {
  const ActivityHistory({super.key});

  @override
  State<ActivityHistory> createState() => _ActiviryHistoryState();
}

class _ActiviryHistoryState extends State<ActivityHistory> {
  List<EventModel> _history = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    final service = EventService();
    
    final history = AuthService.isAdmin
      ? await service.getPastEvents()
      : await service.getUserHistory();

    if (!mounted) return;

    setState(() {
      _history = history;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 34, vertical: 15),
            child: Row(
              children: [
                // Back button
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
                const SizedBox(width: 16),
                const Text(
                  "Activity History",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.notifications_none, color: Colors.black),
                ),
                Builder(
                  builder: (context) => IconButton(
                    onPressed: () => Scaffold.of(context).openDrawer(),
                    icon: const Icon(Icons.menu, color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: _loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _history.isEmpty
            ? const Center(
                child: Text(
                  'No Past Activities Found',
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
              )  
            : ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                itemCount: _history.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: SizedBox(
                    height: 280,
                    child: BasicCard(event: _history[index]),
                  ),
                ),
              ),
    );
  }
}