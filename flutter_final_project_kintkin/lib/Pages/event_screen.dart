import 'package:flutter/material.dart';

// --- WIDGET IMPORTS ---
// Adjust the auth_logo path if yours is located somewhere else!
import '../widgets/auth_logo.dart'; 
import '../widgets/event_input.dart';
import '../widgets/event_category.dart';
import '../widgets/create_button.dart';

class CreateEventScreen extends StatefulWidget {
  const CreateEventScreen({super.key});

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  DateTime? _selectedDate;
  String? _selectedCategory;
  
  final TextEditingController _eventNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _mapsLinkController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(), 
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF344047),
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = "${picked.day.toString().padLeft(2, '0')} / ${picked.month.toString().padLeft(2, '0')} / ${picked.year}";
      });
    }
  }

  @override
  void dispose() {
    _eventNameController.dispose();
    _descriptionController.dispose();
    _mapsLinkController.dispose();
    _timeController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              
              // Logo Widget
              const AuthLogo(), 
              const SizedBox(height: 24),
              
              const Text(
                'Create Event',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1A1A),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Create your own event',
                style: TextStyle(fontSize: 16, color: Color(0xFF4A6472)),
              ),
              const SizedBox(height: 40),

              // Form Widgets
              EventName(
                label: 'Event name',
                hintText: 'Sports gathering',
                controller: _eventNameController,
              ),
              EventName(
                label: 'Description',
                hintText: 'Describe your event',
                controller: _descriptionController,
                maxLines: 3,
              ),
              
              CategoryDropdown(
                selectedValue: _selectedCategory,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedCategory = newValue;
                  });
                },
              ),

              EventName(
                label: 'Location Link',
                hintText: 'Paste Google Maps link here',
                controller: _mapsLinkController,
                suffixIcon: Icons.map_outlined,
              ),
              EventName(
                label: 'Time',
                hintText: '12 : 00',
                controller: _timeController,
                suffixIcon: Icons.access_time,
              ),

              EventName(
                label: 'Date',
                hintText: 'Select a date',
                controller: _dateController,
                suffixIcon: Icons.calendar_month_outlined,
                readOnly: true, 
                onTap: () => _selectDate(context),
              ),

              const SizedBox(height: 30),

              // Submit Button Widget
              SubmitEventButton(
                onPressed: () {
                  debugPrint("Name: ${_eventNameController.text}");
                  debugPrint("Category: $_selectedCategory");
                  debugPrint("Link: ${_mapsLinkController.text}");
                  
                  // TODO: Add your backend POST logic here
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}