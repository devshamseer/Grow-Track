import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:grow_track/presentation/expense_details/expense_chart/expense_chart.dart';
import 'package:grow_track/presentation/expense_details/expense_details_page.dart';
import 'package:grow_track/presentation/home/home_page.dart';
import '../Observer/gorouter_observer.dart';

class AppRouter {
// GoRouter configuration
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static const root = '/';
  static const expenseDetails = '/ExpenseDetails';
  static const expenseDetailsChartById = '/expenseDetailsChartById';
  static const singleArticle = '/article';

  static GoRouter router = GoRouter(
 navigatorKey: navigatorKey,
 initialLocation: root,
// initialLocation: expenseDetailsChartById,
    observers: [MyNavigatorObserver()],
    redirect: (context, state) async {
log("redirect ${state.fullPath}");

    },
    routes: [
      
      GoRoute(
        name: root,
        path: root,
        builder: (context, state) {  
          return HomePage();
        },
      ),
      GoRoute(
        name: expenseDetails,
        path: expenseDetails,
        builder: (context, state) {
          return ExpenseDetailsPage(
            expTitel: state.extra as String,
          );

          // return ExpenseDetailsPage(expTitel: "Train Ticket",);
        },
      ),

//  GoRoute(
//         name: expenseDetailsChartById,
//         path: expenseDetailsChartById,
//         builder: (context, state) {
//           return  ExpenseChartPage(
            
//           );

//           // return ExpenseDetailsPage(expTitel: "Train Ticket",);
//         },
//       ),
       
    ],

//     redirect: (context, state) {
// if (1==2) {
//   return root;

// }else{
//   return allBlogs;
// }
    // },
  );


  // Method to close BottomSheet without context
  static void closeBottomSheet() {
    if (navigatorKey.currentState?.canPop() ?? false) {
      navigatorKey.currentState?.pop();
    }
  }

   // 📌 Navigate without context
 static void navigateTo(String route, {Object? extra}) {
    navigatorKey.currentState?.pushNamed(route, arguments: extra);
  }

    // 📌 Conditional Navigation
  static void navigateIf(bool condition, String route, {Object? extra}) {
    if (condition) {

      navigateTo(route, extra: extra);
    }
  }

    // ✅ Go back (Pop current screen)
  static void goBack() {
    if (navigatorKey.currentState?.canPop() ?? false) {
      navigatorKey.currentState?.pop();
    }
  }

    // ✅ Get current route name
  static String? getCurrentRoute() {
    return navigatorKey.currentContext?.widget.toStringShort();
  }


   // ✅ Replace current route (Remove current and push new)
  static void replaceWith(String route, {Object? extra}) {
    navigatorKey.currentState?.pushReplacementNamed(route, arguments: extra);
  }

  // ✅ Remove all routes and push new route (Clear navigation stack)
  static void clearStackAndNavigate(String route, {Object? extra}) {
    navigatorKey.currentState?.pushNamedAndRemoveUntil(route, (route) => false, arguments: extra);
  }

    // ✅ Show Snackbar Without Context
static void showSnackbar({required SnackBar snackBar,}) {
  ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
    snackBar,
  );
}


    // ✅ Logout and Clear Stack
  // static void logout() {
  //   navigatorKey.currentState?.pushNamedAndRemoveUntil(login, (route) => false);
  // }


// ✅ Show Confirmation Dialog Without Context
  static Future<bool> showExitAppDilog({required String title, required String message}) async {
    return await showDialog(
      context: navigatorKey.currentContext!,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text("Cancel")),
          TextButton(onPressed: () => SystemNavigator.pop(), child: const Text("Confirm")),
        ],
      ),
    ) ?? false;
  }
 // ✅ Back Button Handling - Prevent Accidental Exit
  static Future<bool> onWillPop() async {
    log("ExitApp Callling");
    bool shouldExit = await showExitAppDilog(
      title: "Exit App",
      message: "Are you sure you want to exit?",
    );
    return shouldExit;
  }


  // BLOC 🧱

  static BuildContext? currentStateContext(){
   return navigatorKey.currentState?.context;
  }


// Static method for navigation with optional extra parameter
  static void go({required String routerPath, Object? extra}) {
    // Use the routerPath to push the route with optional extra data

    log("Go Route ${routerPath}  extra ${extra.toString()}");
    navigatorKey.currentContext?.push(routerPath,extra: extra );
  }

 

}
