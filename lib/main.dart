import 'package:flutter/material.dart';
import 'package:productos_app/Presentation/screens/screens.dart';
import 'package:productos_app/infraestructure/services/services.dart';
import 'package:provider/provider.dart';

import 'Presentation/providers/chat_provider.dart';
import 'infraestructure/services/auth_service.dart';
import 'infraestructure/services/notifications_service.dart';

void main() => runApp(const AppState());

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ( _ ) => AuthService() ),
        ChangeNotifierProvider(
          create: (_) => ProductsService(),
        ),
        ChangeNotifierProvider(create: (_) => ChatProvider())
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        // theme: AppTheme().getTheme(),
        title: 'Productos App',
        initialRoute: 'checking',
        routes: {
          'checking': ( _ ) => CheckAuthScreen(),
          'login': (_) =>  LoginScreen(),
          'home': (_) =>  HomeScreen(),
          'product': (_) =>  ProductScreen(),
          'chat': (_) =>  ChatScreen(),
          'register': ( _ ) => RegisterScreen(),
        },
        scaffoldMessengerKey: NotificationsService.messengerKey,
        theme: ThemeData.light().copyWith(
            scaffoldBackgroundColor: Colors.grey[300],
            appBarTheme: const AppBarTheme(elevation: 0, color: Colors.indigo),
            floatingActionButtonTheme: const FloatingActionButtonThemeData(
                backgroundColor: Colors.indigo, elevation: 0)));
  }
}
