import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class StoreDetailScreen extends StatelessWidget {
  const StoreDetailScreen({@PathParam('storeName') this.storeName});

  final String? storeName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text(storeName ?? ''),
    );
  }
}
