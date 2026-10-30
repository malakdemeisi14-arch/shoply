import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  final String id;
  final int number;
  final String status;
  final double total;
  final DateTime date;
  final List<Map<String, dynamic>> items;

  const OrderModel({
    required this.id,
    required this.number,
    required this.status,
    required this.total,
    required this.date,
    required this.items,
  });

  bool get isCompleted => status == 'Delivered';

  factory OrderModel.fromDoc(QueryDocumentSnapshot<Map<String, dynamic>> d) {
    final m = d.data();
    final rawItems = (m['items'] as List?) ?? [];
    return OrderModel(
      id: d.id,
      number: (m['number'] as num?)?.toInt() ?? 0,
      status: (m['status'] ?? 'Pending') as String,
      total: (m['total'] as num?)?.toDouble() ?? 0,
      date: (m['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      items: rawItems.map((e) => Map<String, dynamic>.from(e as Map)).toList(),
    );
  }
}
