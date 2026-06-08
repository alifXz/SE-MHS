import 'package:flutter/material.dart';
import '../widgets/auth_logo.dart';
import '../widgets/event_input.dart';
import '../widgets/event_category.dart';
import '../widgets/create_button.dart';

class EditEventPage extends StatefulWidget {
  final Map<String, dynamic> event;

  const EditEventPage({super.key, required this.event});

  @override
  State<EditEventPage> createState() => _EditEventPageState();
}

class _EditEventPageState extends State<EditEventPage> {
  DateTime? _selectedDate;
  String? _selectedCategory;

  late final TextEditingController _eventNameController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _locationController;
  late final TextEditingController _mapsLinkController;
  late final TextEditingController _startTimeController;
  late final TextEditingController _endTimeController;
  late final TextEditingController _dateController;
  late final TextEditingController _organizerController;
  late final TextEditingController _imageUrlController;
  late final TextEditingController _venuePartnerController;
  late final TextEditingController _priceController;

  @override
  void initState() {
    super.initState();
    _eventNameController = TextEditingController(text: widget.event['title'] ?? '');
    _descriptionController = TextEditingController(text: widget.event['description'] ?? '');
    _locationController = TextEditingController(text: widget.event['location'] ?? '');
    _mapsLinkController = TextEditingController(text: widget.event['location_link'] ?? '');
    _startTimeController = TextEditingController(text: widget.event['start_time'] ?? '');
    _endTimeController = TextEditingController(text: widget.event['end_time'] ?? '');
    _dateController = TextEditingController(text: widget.event['event_date'] ?? '');
    _organizerController = TextEditingController(text: widget.event['organizer'] ?? '');
    _imageUrlController = TextEditingController(text: widget.event['image_url'] ?? '');
    _venuePartnerController = TextEditingController(text: widget.event['venue_partner'] ?? '');
    _priceController = TextEditingController(text: widget.event['price']?.toString() ?? '');
    _selectedCategory = widget.event['category'];

    if (widget.event['event_date'] != null) {
      _selectedDate = DateTime.tryParse(widget.event['event_date'].toString());
    }
  }

  @override
  void dispose() {
    _eventNameController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    _mapsLinkController.dispose();
    _startTimeController.dispose();
    _endTimeController.dispose();
    _dateController.dispose();
    _organizerController.dispose();
    _imageUrlController.dispose();
    _venuePartnerController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  Future<void> _selectTime(
    BuildContext context,
    TextEditingController controller,
  ) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      final hour = picked.hour.toString().padLeft(2, '0');
      final minute = picked.minute.toString().padLeft(2, '0');
      controller.text = '$hour:$minute';
    }
  }

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
        _dateController.text =
            '${picked.year}-'
            '${picked.month.toString().padLeft(2, '0')}-'
            '${picked.day.toString().padLeft(2, '0')}';
      });
    }
  }

  void _saveChanges() {
    Navigator.pop(context, true);
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
              Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    width: 42,
                    height: 42,
                    decoration: const BoxDecoration(
                      color: Color(0xFF1B4F6B),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                ),
              ),

              const AuthLogo(),

              const SizedBox(height: 24),

              const Text(
                'Edit Event',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1A1A),
                ),
              ),

              const SizedBox(height: 40),

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

              EventName(
                label: 'Organizer',
                hintText: 'Kith & Kin',
                controller: _organizerController,
              ),

              EventName(
                label: 'Image URL',
                hintText: 'https://images.unsplash.com/...',
                controller: _imageUrlController,
              ),

              EventName(
                label: 'Venue Partner',
                hintText: 'Binus University',
                controller: _venuePartnerController,
              ),

              EventName(
                label: 'Price',
                hintText: '50000',
                controller: _priceController,
                keyboardType: TextInputType.number,
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
                label: 'Location',
                hintText: 'BINUS Alam Sutera',
                controller: _locationController,
              ),

              EventName(
                label: 'Location Link',
                hintText: 'Paste Google Maps link here',
                controller: _mapsLinkController,
                suffixIcon: Icons.map_outlined,
              ),

              EventName(
                label: 'Start Time',
                hintText: 'Select start time',
                controller: _startTimeController,
                suffixIcon: Icons.access_time,
                readOnly: true,
                onTap: () => _selectTime(context, _startTimeController),
              ),

              EventName(
                label: 'End Time',
                hintText: 'Select end time',
                controller: _endTimeController,
                suffixIcon: Icons.access_time,
                readOnly: true,
                onTap: () => _selectTime(context, _endTimeController),
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

              SubmitEventButton(onPressed: _saveChanges),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}