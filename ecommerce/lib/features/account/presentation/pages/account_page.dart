import 'package:flutter/material.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Account')),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: Chanuka'),
            Text('Email: chanukahasaranga@gmail.com'),
            SizedBox(height: 20),
            Text('About: Test'),
          ],
        ),
      ),
    );
  }
}
