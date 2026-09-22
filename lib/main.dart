import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'providers/accommodation_provider.dart';
import 'providers/auth_provider.dart';
import 'repositories/accommodation_repository.dart';
import 'router/app_router.dart';
import 'services/accommodation_service.dart';
import 'theme/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://lspjefjnnkupectwjywk.supabase.co',
    publishableKey: 'sb_publishable_xPyhljI8-5mrX_yP_GSkjA_9AqIW1sZ',
  );

  runApp(const StayFlowApp());
}

class StayFlowApp extends StatelessWidget {
  const StayFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Repository
        Provider<AccommodationRepository>(
          create: (_) => AccommodationRepository(),
        ),

        // Accommodation service
        ProxyProvider<AccommodationRepository, AccommodationService>(
          update: (_, repository, _) {
            return AccommodationService(
              repository: repository,
            );
          },
        ),

        // Accommodation provider
        ChangeNotifierProxyProvider<AccommodationService,
            AccommodationProvider>(
          create: (context) {
            final service = context.read<AccommodationService>();

            return AccommodationProvider(
              service: service,
            );
          },
          update: (context, service, previous) {
  return previous ??
      AccommodationProvider(
        service: service,
      );
},
        ),

        // Authentication
        ChangeNotifierProvider<AuthProvider>(
          create: (_) => AuthProvider(),
        ),
      ],
      child: MaterialApp.router(
        title: 'StayFlow',
        routerConfig: AppRouter.router,
        theme: AppTheme.lightTheme,
      ),
    );
  }
}