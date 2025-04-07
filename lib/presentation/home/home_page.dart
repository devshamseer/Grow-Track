import 'dart:developer' as developer;
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grow_track/application/expense_bloc/expense_bloc.dart';
import 'package:grow_track/domain/core/dependencies_injection/injectable.dart';
import 'package:grow_track/domain/utils/amount/amouont_utils.dart';
import 'package:grow_track/domain/utils/cards/cards_icon_utils.dart';
import 'package:grow_track/presentation/componets/create_expense.dart';
import 'package:grow_track/services/local_auth/biomimetic_auth_service.dart';
import 'package:grow_track/theme/app_colors.dart';
import 'package:intl/intl.dart';
import 'package:progressive_image/progressive_image.dart';
import 'package:awesome_card/awesome_card.dart';

import '../../GoRouter/gorouter.dart';
import '../../domain/db/model/expense.dart';
import '../../main.dart';
import '../../services/notifications/notifi_service.dart';
import '../../theme/app_icons.dart';
import '../widgets/expense_intro_card_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // log("callling Exp Page Start");
      context
          .read<ExpenseBloc>()
          .add(ExpenseEvent.getGroupedExpensesWithTotal());

      AppRouter.currentStateContext()!.read<ExpenseBloc>().add(ExpenseEvent.getAllAmountExpenses());
    }); 
    return PopScope(
 canPop: false,
     onPopInvoked: (didPop) { 
       AppRouter.onWillPop();
     },
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: Container(
          height: 65,
          width: 65,
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xFF313847)),
            color: Color(0xFF232935),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: GestureDetector(
              onTap: () {
                createExpenseBottomSheet(context);
              },
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: 35,
              ),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          height: 60,
          child: Row(
            children: [
              IconButton(
                  onPressed: () {
                    objectBox!.deleteAllExpenses();
                  },
                  icon: Icon(
                    Icons.dns_rounded,
                    color: Colors.white,
                    size: 30,
                  )),
              IconButton(
                  onPressed: () async {     
//        NotificationService().showNotification(
//   id: 1,
//   title: "Hello!",
//   body: "This is a test notification.",
// );

// DateTime scheduledTime = DateTime.now().add(Duration(seconds: 10));
// NotificationService().scheduleReminderNotification(
//   id: 3,
//   title: "Scheduled Notification",
//   body: "This will appear after 10 seconds.",
//   scheduledTime: scheduledTime,

// );

// Show instant notification
// await NotificationService.showInstantNotification(
//   title: "🚀 Instant Notification",
//   body: "This is an instant notification!",
// );

// Show notification with image
// await NotificationService.showNotificationWithImage(
//   title: "📸 Image Notification",
//   body: "This notification contains an image.",
//   imageUrl: "https://tinypng.com/images/social/website.jpg",
// );

// Show notification with actions
// await NotificationService.showInstantNotification(
//                 title: "Test Notification",
//                 body: "This is a manual test notification!",
//               );

// NotificationService().showNotificationWithActions(
//   id: 4,
//   title: "Action Notification",
//   body: "Click an action button!",
// );

// NotificationService.showNotification(
//                 id: 1,
//                 title: "Quick Notification",
//                 body: "This is a quick notification.",
//               );


NotificationService.showImageNotification( title: "dsfsdfcv", body: "4564fghdggfd", imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTwT9lD5J9I6pBjPuJKI04LpEp1qvtLq6ZvCg&s");

                  },
                  icon: Icon(
                    Icons.now_wallpaper_outlined,
                    color: Colors.white,
                    size: 30,
                  )),
              IconButton(
                  onPressed: () {

                    Biometricauth.checkBiometric();
                  },
                  icon: Icon(
                    Icons.fingerprint_rounded,
                    color: Colors.white,
                    size: 30,
                  )),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.file_upload_outlined,
                    color: Colors.white,
                    size: 30,
                  )),
            ],
          ),
        ),
        backgroundColor: AppColors.backgroundColor,
        body:
      
            //  compite==false
            //     ? Center(
            //         child: LoadingAnimationWidget.dotsTriangle(
            //           color: Colors.white,
            //           size: 100,
            //         ),
            //       )
            //     :
      
            SafeArea(
          // child: Column(
          //   children: [
          //     Text('Mongodeb'),
          //     ElevatedButton(
          //         onPressed: () async {
          //           setState(() {});
      
          //           var id = Mongodart.ObjectId();
      
          //           final datass = MongodbModel(
          //               id: id.$oid,
          //               date: '12/3/2023',
          //               toduTitel: 'Hello',
          //               toduData: 'helllo sssr');
          //           var result = await MongodbConcter.insert(datass);
          //           print(result.toString());
          //         },
          //         child: Text('ADD data')),
          //     FutureBuilder(
          //       future: MongodbConcter.getData(),
          //       // future: MongodbConcter.getData(),
          //       builder: (BuildContext context, AsyncSnapshot snapshot) {
          //         if (snapshot.connectionState == ConnectionState.waiting) {
          //           return CircularProgressIndicator();
          //         } else {
          //           if (snapshot.hasData) {
          //             return Flexible(
          //               child: ListView.builder(
          //                 shrinkWrap: true,
          //                 primary: false,
          //                 itemCount: snapshot.data.length,
          //                 itemBuilder: (BuildContext context, int index) {
          //                   return Container(
          //                     child: showdatacard(
          //                         MongodbModel.fromJson(snapshot.data[index])),
          //                   );
          //                 },
          //               ),
          //             );
          //           } else {
          //             return Text('Nodata');
          //           }
          //         }
          //       },
          //     ),
          //   ],
          // ),
      
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 18, right: 18, top: 17),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Expense',
                      style: GoogleFonts.getFont('Maven Pro',
                          color: AppColors.textColor1,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onLongPress: () {
                        HapticFeedback.heavyImpact();
                      },
                      child: Container(
                        child: Center(
                          child: Container(
                            height: 45,
                            width: 45,
                            decoration: BoxDecoration(shape: BoxShape.circle),
                            child: Center(
                              child: ClipOval(
                                child: ProgressiveImage(
                                  fit: BoxFit.cover,
                                  placeholder: NetworkImage(
                                      'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80'),
                                  // size: 1.87KB
                                  thumbnail: NetworkImage(
                                      'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80'),
                                  // size: 1.29MB
                                  image: NetworkImage(
                                      'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80'),
                                  height: 50,
                                  width: 50,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              // Padding(
              //     padding: const EdgeInsets.only(left: 12, right: 12, top: 18),
              //     child: Serchbar_widget()),
      
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 18, top: 15),
                child: Container(
                  height: 55,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color(0xFF171C26),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 12, right: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                // showDialog(
                                //   context: context,
                                //   builder: (context) {
                                //     return coin_qrcod_generator_widget(
                                //         UserData:
                                //             SecureDataTransfer().reverseString(
                                //       inputString:
                                //           '${UserDatas["_id"].toString()}~*#',
                                //     ));
                                //   },
                                // );
                              },
                              child: Hero(
                                tag: 'top',
                                child: Icon(
                                  Icons.currency_bitcoin_rounded,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Image.asset(
                              '${ImageIconPathSet.basePath}/money.png',
                              height: 20,
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            BlocBuilder<ExpenseBloc, ExpenseState>(
                              builder: (context, state) {
                                return Row(
                                  children: [ 
                                
                                    Text(   
                                       '₹ ${AmountUtils.formatAmount (amount:  state.tottelAmount!.fullTotelAmount)}',
                                                             
                                                                style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                                              ),
                                  ],
                                );
                              },
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 12,
              ),
      
              Stack(
                children: [
                  CreditCard(
                      cardNumber: "5450 7879 4864 7854",
                      // cardExpiry: DateFormat("dd/MM/yyyy").format(DateTime.parse(
                      //   UserDatas["CreatedDate"].toString().trim(),
                      // ).toLocal()),
                      cardExpiry: '',
                      // cardHolderName:
                      //     "₹ ${NumberFormat('#,##,###').format(tottalExpAmount['totalAmount']).toString()}",
                      cardHolderName: "df",
                      cvv: "456",
                      // bankName: UserDatas["username"],
                      bankName: "df",
                      cardType: CardType
                          .visa, // Optional if you want to override Card Type
                      showBackSide: false,
                      frontBackground: CardBackgrounds.custom(0xFF171C26),
                      backBackground: CardBackgrounds.custom(0xFF171C26),
                      showShadow: false,
                      textExpDate: 'Created Date',
                      textName: 'Name',
                      textExpiry: 'MM/YY'),
                ],
              ),
              SizedBox(
                height: 12,
              ),
              // Flexible(
              //   child: Padding(
              //     padding: const EdgeInsets.only(
              //         top: 12.0, left: 12.0, right: 12.0, bottom: 9),
              //     child: GridView.builder(
              //         gridDelegate:
              //             const SliverGridDelegateWithFixedCrossAxisCount(
              //                 crossAxisCount: 2,
              //                 crossAxisSpacing: 15,
              //                 mainAxisSpacing: 15,
              //                 mainAxisExtent: 220),
              //         itemCount: 300,
              //         itemBuilder: (BuildContext context, int index) {
              //           return Expanse_card_widget();
              //         }),
              //   ),
              // ),
      
              ElevatedButton(
                  onPressed: () {
                    // objectBox.deleteAllExpenses();
                    context.read<ExpenseBloc>().add(
                        ExpenseEvent.getExpensesByCategory(
                            expTitle: "Train Ticket"));
                  },
                  child: Text('data')),
      
              ElevatedButton(
                onPressed: () {
                  Random random = Random(); // Initialize the Random object
      
                  for (int i = 0; i < 1000; i++) {
                    // Calculate which item from the list to use based on the index
                    int index =
                        i % 18; // To loop through the first 18 items repeatedly
      
                    objectBox!.addExpense(
                      Expense(
                        uuid: "dfdf ${DateTime.now()}_$i", // Ensure unique uuid
                        title: "test${i}",
                        description: "Test-FustData",
                        expTitel:
                            "${CardIconsUtils.ExpCardData[index].titel}", // Dynamic expTitel from the list
                        amount: random
                            .nextInt(501)
                            .toDouble(), // Random amount between 0 and 500
                        createdDate: DateTime.now().toString(),
                        sync: false,
                      ),
                    );
                  }
                },
                child: Text('Add 100 Expenses'),
              ),
      
              BlocBuilder<ExpenseBloc, ExpenseState>(
                builder: (context, state) {
            
                  if (state.GroupedExpensesWithTotal.length == 0) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 80),
                      child: Center(
                        child: Image.asset(
                          "${ImageIconPathSet.basePath}/empty-box.png",
                          width: 190,
                          height: 190,
                        ),
                      ),
                    );
                  }
                  return Padding(
                    padding: const EdgeInsets.only(left: 12, right: 12),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      //  itemCount:5,
                      // itemCount: CardIconsUtils.ExpCardData.length,
                      itemCount: state.GroupedExpensesWithTotal.length,
      
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // Number of columns
                          crossAxisSpacing: 1.0, // Spacing between columns
                          mainAxisSpacing: 1.0, // Spacing between rows
                          mainAxisExtent: 170),
                      itemBuilder: (BuildContext context, int index) {
                        //  developer.log(state.expandsList[index].toString());
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Expense_indro_cred_widget(
                            ImageIcon:
                                //  '${CardIconsUtils.ExpCardData[index].imageIcon}',
      
                                '${CardIconsUtils.getImageIconByTitle(title: state.GroupedExpensesWithTotal[index].expTitel!)}',
                            Titel: state.GroupedExpensesWithTotal[index].expTitel,
                            // Descrpriton: "",
                            // Amount: fileterTypeAmouont(
                            //     type: cardsData().ExpCardData[index]['Titel']),
      
                            Descrpriton: "",
                            Amount:
                                state.GroupedExpensesWithTotal[index].totalAmount,
                            onPressed: () {
                              context.push(AppRouter.expenseDetails,
                                  extra: state
                                      .GroupedExpensesWithTotal[index].expTitel);
                            },
                          ),
                        );
                      },
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
