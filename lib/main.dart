import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:grow_track/GoRouter/gorouter.dart';
import 'package:grow_track/Observer/bloc_observer.dart';
import 'package:grow_track/domain/db/model/expense.dart';
import 'package:grow_track/infrastructure/db/objectbox.dart';
import 'package:grow_track/services/blocservice/Mulit_bloc_provider_service.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'domain/core/dependencies_injection/injectable.dart';
import 'services/notifications/notifi_service.dart';

ObjectBox? objectBox;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones(); // Ensure timezone is initialized
  await configureDependencies();
  objectBox = await ObjectBox.create();
  // Initialize the NotificationService
  await NotificationService.initialize();
// objectBox.addExpense(Expense(uuid: "dfdf ${DateTime.now()}", title: "test", description: "Test-FustData", expTitel: "Train Ticket", amount: 200, createdDate: DateTime.now().toString(), sync: false));
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Mulit_bloc_provider_service(
        child: MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // builder: (context, child) {
      //   if (1 == 1) {
      //     // context.push(AppRouter.expenseDetails, extra: "");
       
      //     AppRouter.go(routerPath: AppRouter.expenseDetails,extra: "");
      //   }

      //   return Center(
      //     child: child,
      //   );
      // },
      routerConfig: AppRouter.router,
    ));
  }
}
