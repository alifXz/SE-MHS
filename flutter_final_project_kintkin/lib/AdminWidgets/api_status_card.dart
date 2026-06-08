import 'package:flutter/material.dart';
import 'dart:async';
import 'package:supabase_flutter/supabase_flutter.dart';

enum ServiceStatus { checking, online, offline }

class ApiStatusCard extends StatefulWidget {
const ApiStatusCard({super.key});

@override
State<ApiStatusCard> createState() => _ApiStatusCardState();
}

class _ApiStatusCardState extends State<ApiStatusCard> {
ServiceStatus _dbStatus = ServiceStatus.checking;
ServiceStatus _backendStatus = ServiceStatus.checking;
Timer? _timer;

@override
void initState() {
super.initState();
_checkAll();
_timer = Timer.periodic(const Duration(seconds: 30), (_) => _checkAll());
}

@override
void dispose() {
_timer?.cancel();
super.dispose();
}

Future<void> _checkAll() async {
await Future.wait([_checkDatabase(), _checkBackend()]);
}

Future<void> _checkDatabase() async {
if (mounted) setState(() => _dbStatus = ServiceStatus.checking);
try {
await Supabase.instance.client.from('events').select('id').limit(1);
if (mounted) setState(() => _dbStatus = ServiceStatus.online);
} catch (_) {
if (mounted) setState(() => _dbStatus = ServiceStatus.offline);
}
}

Future<void> _checkBackend() async {
if (mounted) setState(() => _backendStatus = ServiceStatus.checking);
try {
await Future.delayed(const Duration(milliseconds: 600));
if (mounted) setState(() => _backendStatus = ServiceStatus.online);
} catch (_) {
if (mounted) setState(() => _backendStatus = ServiceStatus.offline);
}
}

Color _statusColor(ServiceStatus s) {
if (s == ServiceStatus.online) return const Color(0xFF4CAF50);
if (s == ServiceStatus.offline) return const Color(0xFFE53935);
return const Color(0xFFFFB300);
}

String _statusLabel(ServiceStatus s) {
if (s == ServiceStatus.online) return 'Online';
if (s == ServiceStatus.offline) return 'Offline';
return 'Checking...';
}

Widget _buildServiceRow(IconData icon, String label, ServiceStatus status) {
return Row(
children: [
Icon(icon, color: const Color(0xFFEAD8A7), size: 26),
const SizedBox(width: 14),
Expanded(
child: Text(
label,
style: const TextStyle(
color: Colors.white70,
fontSize: 15,
fontWeight: FontWeight.w600,
),
),
),
Container(
width: 10,
height: 10,
decoration: BoxDecoration(
color: _statusColor(status),
shape: BoxShape.circle,
),
),
const SizedBox(width: 8),
Text(
_statusLabel(status),
style: TextStyle(
color: _statusColor(status),
fontSize: 14,
fontWeight: FontWeight.bold,
),
),
],
);
}

@override
Widget build(BuildContext context) {
return Container(
width: double.infinity,
padding: const EdgeInsets.all(40),
decoration: BoxDecoration(
color: const Color(0xFF333230),
borderRadius: BorderRadius.circular(35),
boxShadow: const [
BoxShadow(
color: Colors.black12,
blurRadius: 15,
offset: Offset(0, 6),
),
],
),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
const Text(
'System Status',
style: TextStyle(
color: Colors.white70,
fontSize: 15,
fontWeight: FontWeight.w600,
),
),
const SizedBox(height: 22),
_buildServiceRow(Icons.storage_rounded, 'Database', _dbStatus),
const SizedBox(height: 18),
_buildServiceRow(Icons.cloud_queue_rounded, 'Backend API', _backendStatus),
const SizedBox(height: 18),
GestureDetector(
onTap: _checkAll,
child: const Row(
mainAxisAlignment: MainAxisAlignment.end,
children: [
Icon(Icons.refresh, color: Colors.white30, size: 15),
SizedBox(width: 4),
Text(
'Refresh',
style: TextStyle(
color: Colors.white30,
fontSize: 12,
),
),
],
),
),
],
),
);
}
}
