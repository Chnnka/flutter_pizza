import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:user_repository/src/entities/entities.dart';
import 'package:user_repository/src/models/models.dart';
import 'package:user_repository/src/pizza_repo.dart';

class FirebasePizzaRepo implements PizzaRepo {
  final pizzaCollection = FirebaseFirestore.instance.collection('pizzas');

  @override
  Future<List<Pizza>> getPizzas() async {
    try {
      return await pizzaCollection.get().then((value) => value.docs
          .map((e) => Pizza.fromEntity(PizzaEntity.fromDocument(e.data())))
          .toList());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
