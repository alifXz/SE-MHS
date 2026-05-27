import 'package:flutter/material.dart';
import '../widgets/priceRow.dart';
import 'package:flutter_final_project_kintkin/models/event_model.dart';

Widget buildPaymentDetails(EventModel event) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Detail Transaksi",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1B3A4A)),
        ),
        const SizedBox(height: 12),
        buildDetailRow("Harga Tiket", event.price),
        buildDetailRow("Biaya Layanan", 5000),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Divider(),
        ),
        buildDetailRow("Total Pembayaran", event.price + 5000, isTotal: true),
      ],
    );
  }