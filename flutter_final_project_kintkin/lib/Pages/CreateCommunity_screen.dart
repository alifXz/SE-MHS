// import 'package:flutter/material.dart';
// import 'package:flutter_final_project_kintkin/widgets/auth_logo.dart';
// import 'package:flutter_final_project_kintkin/widgets/create_button.dart';
// import 'package:flutter_final_project_kintkin/widgets/event_category.dart';
// import 'package:flutter_final_project_kintkin/widgets/event_input.dart';


// class CreatecommunityScreen extends StatefulWidget {
//   const CreatecommunityScreen({super.key});

//   @override
//   State<CreatecommunityScreen> createState() => _CreatecommunityScreenState();
// }

// class _CreatecommunityScreenState extends State<CreatecommunityScreen> {
//    String? _selectedInterest; 
 
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _descriptionController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _imageUrlController = TextEditingController();
 
//   bool _isLoading = false;

//   Future<void> _createCommunity() async {
//     // Input
//     if (_nameController.text.trim().isEmpty ||
//         _descriptionController.text.trim().isEmpty ||
//         _emailController.text.trim().isEmpty ||
//         _passwordController.text.trim().isEmpty ||
//         _imageUrlController.text.trim().isEmpty ||
//         _selectedInterest == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Please fill all fields'),
//           backgroundColor: Colors.red,
//         ),
//       );
//       return;
//     }
 
//     setState(() {
//       _isLoading = true;
//     });

//     try {

//       //Supabase 


//       if (!mounted) return;
 
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Community created successfully!'),
//           backgroundColor: Colors.green,
//         ),
//       );
 
//       Navigator.pop(context);
//     } catch (e) {
//       if (!mounted) return;
 
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Failed to create community: $e'),
//           backgroundColor: Colors.red,
//         ),
//       );
//     } finally {
//       if (mounted) {
//         setState(() {
//           _isLoading = false;
//         });
//       }
//     }
//   }
 
//   @override
//   void dispose() {
//     _nameController.dispose();
//     _descriptionController.dispose();
//     _emailController.dispose();
//     _passwordController.dispose();
//     _imageUrlController.dispose();
//     super.dispose();
//   }
  

//   @override
//   Widget build(BuildContext context) {
//      return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.symmetric(
//             horizontal: 30,
//             vertical: 20,
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               const SizedBox(height: 20),
//               Align(
//                 alignment: Alignment.topLeft,
//                 child: GestureDetector(
//                   onTap: () => Navigator.of(context).pop(),
//                   child: Container(
//                     width: 42,
//                     height: 42,
//                     decoration: const BoxDecoration(
//                       color: Color(0xFF1B4F6B),
//                       shape: BoxShape.circle,
//                     ),
//                     child: const Icon(
//                       Icons.arrow_back,
//                       color: Colors.white,
//                       size: 22,
//                     ),
//                   ),
//                 ),
//               ),
 
//               const AuthLogo(),
 
//               const SizedBox(height: 24),
 
//               const Text(
//                 'Create Your Own Community!',
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                   color: Color(0xFF1A1A1A),
//                 ),
//               ),
 
//               const SizedBox(height: 40),
 
             
//               EventName(
//                 label: 'Community Name',
//                 hintText: 'Community Name',
//                 controller: _nameController,
//               ),
 
//               SizedBox(),
//               EventName(
//                 label: 'Community Description',
//                 hintText: 'Community Description...',
//                 controller: _descriptionController,
//                 maxLines: 3,
//               ),
 
            
//               CategoryDropdown(
//                 selectedValue: _selectedInterest,
//                 onChanged: (String? newValue) {
//                   setState(() {
//                     _selectedInterest = newValue;
//                   });
//                 },
//               ),
 
              
//               EventName(
//                 label: 'Email',
//                 hintText: 'Email...',
//                 controller: _emailController,
//                 keyboardType: TextInputType.emailAddress,
//               ),
 
             
//               EventName(
//                 label: 'Password',
//                 hintText: 'Password',
//                 controller: _passwordController,
//                 obscureText: true,
//               ),
 
              
//               EventName(
//                 label: 'Community Profile',
//                 hintText: 'https://images.unsplash.com/...',
//                 controller: _imageUrlController,
//               ),
 
//               const SizedBox(height: 30),
 
              
//               _isLoading
//                   ? const CircularProgressIndicator()
//                   : SubmitEventButton(
//                       onPressed: _createCommunity,
//                     ),
 
//               const SizedBox(height: 20),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

