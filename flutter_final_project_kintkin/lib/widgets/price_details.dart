import 'package:flutter/material.dart';
import 'priceRow.dart';

Widget priceDetails({
  required int price,
  required int tax,
  required int serviceFee,
  required String Function(int) formatRupiah,
}) {
  final total = price + tax + serviceFee;

  return Column(
    children: [
      priceRow('Price', formatRupiah(price)),
      const SizedBox(height: 14),
      priceRow('Tax', formatRupiah(tax)),
      const SizedBox(height: 14),
      priceRow('Service Fees', formatRupiah(serviceFee)),
      const Padding(
        padding: EdgeInsets.symmetric(vertical: 18),
        child: Divider(height: 1, color: Color(0xFFE0E0E0)),
      ),
      priceRow('Total', formatRupiah(total), isBold: true),
    ],
  );
}