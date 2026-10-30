import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/order_model.dart';
import '../providers/cart_provider.dart';

class OrderService {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static CollectionReference<Map<String, dynamic>> _col(String uid) =>
      _db.collection('users').doc(uid).collection('orders');

  static Future<String?> place(
      String uid, List<CartItem> items, double total) async {
    try {
      await _col(uid).add({
        'number': 1000 + Random().nextInt(9000),
        'status': 'Pending',
        'total': total,
        'createdAt': FieldValue.serverTimestamp(),
        'items': items
            .map((i) => {
                  'productId': i.product.id,
                  'name': i.product.name,
                  'qty': i.qty,
                  'price': i.product.price,
                })
            .toList(),
      });
      return null;
    } catch (_) {
      return 'Could not place the order. Please try again.';
    }
  }

  static Stream<List<OrderModel>> stream(String uid) {
    return _col(uid)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((s) => s.docs.map(OrderModel.fromDoc).toList());
  }

  static Future<String?> sendMessage({
    required String uid,
    required String name,
    required String email,
    required String subject,
    required String message,
  }) async {
    try {
      await _db.collection('messages').add({
        'uid': uid,
        'name': name,
        'email': email,
        'subject': subject,
        'message': message,
        'createdAt': FieldValue.serverTimestamp(),
      });
      return null;
    } catch (_) {
      return 'Could not send your message. Please try again.';
    }
  }
}
