import 'package:flutter/material.dart';
import 'package:flutter_final_project_kintkin/Pages/main_screen.dart';
import 'home_screen.dart';

class PaymentcompleteScreen extends StatefulWidget {
  const PaymentcompleteScreen({super.key});

  @override
  State<PaymentcompleteScreen> createState() => _PaymentcompleteScreenState();
}

class _PaymentcompleteScreenState extends State<PaymentcompleteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4F9047),
      body: Padding(
        padding: const EdgeInsets.all(100),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check_circle_rounded, color: Colors.white, size: 300),
              Text(
                'Payment Successful',
                style: TextStyle(color: Colors.white, fontSize: 50),
              ),
              Spacer(),
              Container(
                height: 50,
                width: double.infinity,
                padding: EdgeInsets.only(left: 30, right: 30),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>((
                      Set<MaterialState> states,
                    ) {
                      if (states.contains(MaterialState.hovered)) {
                        return Colors.white;
                      }
                      return const Color(0xFF4F9047);
                    }),
                    foregroundColor: MaterialStateProperty.resolveWith<Color>((
                      Set<MaterialState> states,
                    ) {
                      if (states.contains(MaterialState.hovered)) {
                        return const Color(0xFF4F9047);
                      }
                      return Colors.white;
                    }),
                    side: MaterialStateProperty.resolveWith<BorderSide>((
                      Set<MaterialState> states,
                    ) {
                      return const BorderSide(color: Colors.white, width: 2);
                    }),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const MainScreen()),
                    );
                  },
                  child: Text('Continue'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
