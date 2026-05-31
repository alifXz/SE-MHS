import 'package:flutter/material.dart';

import '../widgets/auth_logo.dart';
import '../widgets/event_input.dart';
import '../widgets/event_category.dart';
import '../widgets/create_button.dart';

import '../services/supabase_service.dart';

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

  final TextEditingController _locationController = TextEditingController();

  final TextEditingController _mapsLinkController = TextEditingController();

  final TextEditingController _startTimeController = TextEditingController();

  final TextEditingController _endTimeController = TextEditingController();

  final TextEditingController _dateController = TextEditingController();

  final TextEditingController _organizerController = TextEditingController();

  final TextEditingController _imageUrlController = TextEditingController();

  final TextEditingController _venuePartnerController = TextEditingController();

  final TextEditingController _priceController = TextEditingController();

  bool _isLoading = false;

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

      controller.text = "$hour:$minute";
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
          "${picked.year}-"
          "${picked.month.toString().padLeft(2, '0')}-"
          "${picked.day.toString().padLeft(2, '0')}";
      });
    }
  }

  Future<void> _createEvent() async {

    // validation
    if (_eventNameController.text.trim().isEmpty ||
        _descriptionController.text.trim().isEmpty ||
        _locationController.text.trim().isEmpty ||
        _mapsLinkController.text.trim().isEmpty ||
        _startTimeController.text.trim().isEmpty ||
        _endTimeController.text.trim().isEmpty ||
        _dateController.text.trim().isEmpty ||
        _organizerController.text.trim().isEmpty ||
        _imageUrlController.text.trim().isEmpty ||
        _venuePartnerController.text.trim().isEmpty ||
        _priceController.text.trim().isEmpty ||
        _selectedCategory == null) {

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all fields'),
          backgroundColor: Colors.red,
        ),
      );

      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {

      await SupabaseService().createEvent(
        title: _eventNameController.text.trim(),
        category: _selectedCategory!,
        organizer: _organizerController.text.trim(),
        location: _locationController.text.trim(),
        locationLink: _mapsLinkController.text.trim(),
        description: _descriptionController.text.trim(),
        imageUrl: _imageUrlController.text.trim(),
        startTime: _startTimeController.text.trim(),
        endTime: _endTimeController.text.trim(),
        eventDate: _dateController.text.trim(),
        venuePartner: _venuePartnerController.text.trim(),
        price: int.parse(_priceController.text.trim()),
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Event created successfully!'),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pop(context);

    } catch (e) {

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to create event: $e'),
          backgroundColor: Colors.red,
        ),
      );

    } finally {

      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,


      body: SafeArea(
        
      


        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 30,
            vertical: 20,
          ),

          child: Column(
            
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
    
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.topLeft,
                child: Positioned(
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
              ),

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
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF4A6472),
                ),
              ),

              const SizedBox(height: 40),

              // EVENT NAME
              EventName(
                label: 'Event name',
                hintText: 'Sports gathering',
                controller: _eventNameController,
              ),

              // DESCRIPTION
              EventName(
                label: 'Description',
                hintText: 'Describe your event',
                controller: _descriptionController,
                maxLines: 3,
              ),

              // ORGANIZER
              EventName(
                label: 'Organizer',
                hintText: 'Kith & Kin',
                controller: _organizerController,
              ),

              // IMAGE URL
              EventName(
                label: 'Image URL',
                hintText: 'https://images.unsplash.com/...',
                controller: _imageUrlController,
              ),

              // VENUE PARTNER
              EventName(
                label: 'Venue Partner',
                hintText: 'Binus University',
                controller: _venuePartnerController,
              ),

              // PRICE
              EventName(
                label: 'Price',
                hintText: '50000',
                controller: _priceController,
                keyboardType: TextInputType.number,
              ),

              // CATEGORY
              CategoryDropdown(
                selectedValue: _selectedCategory,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedCategory = newValue;
                  });
                },
              ),

              // LOCATION NAME
              EventName(
                label: 'Location',
                hintText: 'BINUS Alam Sutera',
                controller: _locationController,
              ),

              // LOCATION LINK
              EventName(
                label: 'Location Link',
                hintText: 'Paste Google Maps link here',
                controller: _mapsLinkController,
                suffixIcon: Icons.map_outlined,
              ),

              // START TIME
              EventName(
                label: 'Start Time',
                hintText: 'Select start time',
                controller: _startTimeController,
                suffixIcon: Icons.access_time,
                readOnly: true,
                onTap: () => _selectTime(context, _startTimeController),
              ),

              // END TIME
              EventName(
                label: 'End Time',
                hintText: 'Select end time',
                controller: _endTimeController,
                suffixIcon: Icons.access_time,
                readOnly: true,
                onTap: () => _selectTime(context, _endTimeController),
              ),

              // DATE
              EventName(
                label: 'Date',
                hintText: 'Select a date',
                controller: _dateController,
                suffixIcon: Icons.calendar_month_outlined,
                readOnly: true,
                onTap: () => _selectDate(context),
              ),

              const SizedBox(height: 30),

              // SUBMIT BUTTON
              _isLoading
                  ? const CircularProgressIndicator()
                  : SubmitEventButton(
                      onPressed: _createEvent,
                    ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}