import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:boilerplate_flutter/component/route/routers.gr.dart';
import 'package:flutter/material.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.maybePop(),
          icon: Icon(
            Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Home'),
            ElevatedButton(
              onPressed: () => context.router.push(const AccountRoute()),
              child: const Text('Go To Account'),
            )
          ],
        ),
      ),
    );
  }
}
