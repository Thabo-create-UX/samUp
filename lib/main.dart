import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/auth_provider.dart';
import 'repositories/accommodation_repository.dart';
import 'router/app_router.dart';
import 'theme/theme.dart';

void main() => runApp(const StayFlowApp());

class StayFlowApp extends StatelessWidget {
  const StayFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => AccommodationRepository()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MaterialApp.router(
        title: 'StayFlow',
        routerConfig: AppRouter.router,
        theme: AppTheme.lightTheme,
      ),
    );
  }
}
