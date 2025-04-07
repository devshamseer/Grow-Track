

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grow_track/application/expense_bloc/expense_bloc.dart';
import 'package:grow_track/domain/db/model/expense.dart';
import 'package:grow_track/domain/utils/Date/date_utils.dart';
import 'package:grow_track/domain/utils/amount/amouont_utils.dart';
import 'package:grow_track/presentation/expense_details/componets/create_expense.dart';
import 'package:grow_track/presentation/expense_details/componets/update_expense.dart';
import 'package:grow_track/presentation/expense_details/controller/expense_details_controller.dart';
import 'package:grow_track/presentation/widgets/search_bar_widget.dart';
import 'package:grow_track/theme/app_colors.dart';
import 'package:grow_track/theme/app_icons.dart';
import 'package:intl/intl.dart';
import 'package:bouncing_button/bouncing_button.dart';
class ExpenseDetailsPage extends StatelessWidget {
  final String expTitel;

  ExpenseDetailsPage({super.key, required this.expTitel});

  final TextEditingController serchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context
          .read<ExpenseBloc>()
          .add(ExpenseEvent.getTottelAmountExpensesById(expTitel: expTitel));
      // log("callling Exp Page Start");
      context
          .read<ExpenseBloc>()
          .add(ExpenseEvent.getExpensesByIdList(expTitel: expTitel));
    });
    return Scaffold(
      bottomNavigationBar: Container(
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Color(0xFF171C26), borderRadius: BorderRadius.circular(1)),
        child: Padding(
          padding: const EdgeInsets.only(left: 19),
          child: Row(
            children: [
              Text(
                'Total:',
                style: GoogleFonts.getFont('Maven Pro',
                    color: AppColors.textColor1,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 5,
              ),
              BlocBuilder<ExpenseBloc, ExpenseState>(
                builder: (context, state) {
                  return Container(
                    height: 35,
                    padding: EdgeInsets.only(left: 12, right: 12),
                    decoration: BoxDecoration(
                      //  color: Colors.amber,
                      border:
                          Border.all(color: Color.fromARGB(255, 135, 146, 167)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        // '₹${EXPLIST['totalCount']}',
                        " ${'₹ ${AmountUtils.formatAmount(amount: state.tottelAmount!.detailsAmount)}'}",
                        style: TextStyle(color: Colors.red, fontSize: 15),
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: GestureDetector(
        onTap: () async {
          createExpenseBottomSheetById(context: context, expTitel: expTitel);
        },
        child: Container(
          height: 65,
          width: 65,
          decoration: BoxDecoration(
            border: Border.all(color: Color(0xFF313847)),
            color: Color(0xFF232935),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Icon(
              Icons.add,
              color: Colors.white,
              size: 35,
            ),
          ),
        ),
      ),
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 18, right: 18, top: 17),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    ' ${expTitel}',
                    style: GoogleFonts.getFont('Maven Pro',
                        color: AppColors.textColor1,
                        fontSize: 29,
                        fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onLongPress: () {
                      // );
                    },
                    onTap: () {
                      //  updateAmount();
                      // setState(() {
                      //   totalm;
                      // });
                    },
                    child: Container(
                      child:
                          Center(child: BlocBuilder<ExpenseBloc, ExpenseState>(
                        builder: (context, state) {
                          return Container(
                            height: 45,
                            width: 45,
                            decoration: BoxDecoration(shape: BoxShape.circle),
                            child: Center(
                                child: Text(
                              '${state.ExpensesByIdList.length}',
                              style: TextStyle(color: Colors.white),
                            )),
                          );
                        },
                      )),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(left: 12, right: 12, top: 18),
                child: SearchBarWidget(
                  onChanged: (serchValue) {  
                    context.read<ExpenseBloc>().add(ExpenseEvent.sercheExpens(serchQery: serchValue,expTitel: expTitel));
                  },
                  controller: serchController,
                )),
            SizedBox(
              height: 12,
            ),

        
            Flexible(child: BlocBuilder<ExpenseBloc, ExpenseState>(
              builder: (context, state) {
                return Scrollbar(
                  child: ListView.builder(
                    itemCount: state.ExpensesByIdList.length,
                    itemBuilder: (BuildContext context, int index) {
                      //  tottalamont=MongodbModel.fromJson(snapshot.data[index]);

                      return Padding(
                        padding: const EdgeInsets.only(
                            left: 12, right: 12, top: 12, bottom: 15),
                        child: ExpensCardWithAnimation(
                        ExpenseList:state.ExpensesByIdList[index] ,
                          expTitel: state.ExpensesByIdList[index].expTitel,
                          // context: context,
                          Tittle: "${state.ExpensesByIdList[index].title}",
                          EXPID: "${state.ExpensesByIdList[index].uuid}",
                          image: "df",
                          index: index,
                          Descrptin:
                              "${state.ExpensesByIdList[index].description}",
                          amount:   state.ExpensesByIdList[index].amount,
                          date: APPDateUtils.formatTimestamp(
                              timestamp:
                                  state.ExpensesByIdList[index].createdDate),
                        ),
                      );
                    },
                  ),
                );
              },
            )),
          ],
        ),
      ),
    );
  }
}

// expens_card(
//     {Tittle,
//     Descrptin,
//     date,
//     amount,
//     index,
//     EXPID,
//     image,
//     required BuildContext context,
//     required expTitel, required Expense ExpenseList}) {
//   // var ss=getingdd[0]['amount'].fold(0, (a, b) => a + b);
//   // var ss = [];

//   return Container(
//     height: 230,
//     width: double.infinity,
//     decoration: BoxDecoration(
//         color: Color(0xFF171C26), borderRadius: BorderRadius.circular(30)),
//     child: Stack(
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Container(
//             height: 70,
//             width: 300,
//             // color: Colors.green,
//             child: ListTile(
//               title: Text(
//                 Tittle.toString().trim(),
//                 style: TextStyle(
//                     color: AppColors.textColor1,
//                     fontSize: 21,
//                     fontWeight: FontWeight.bold),
//               ),
//               subtitle: Text(
//                 Descrptin.toString().trim(),
//                 style: TextStyle(
//                     color: Color.fromARGB(255, 135, 146, 167),
//                     fontSize: 17,
//                     fontWeight: FontWeight.bold),
//               ),
//             ),
//           ),
//         ),
//         Align(
//             child: Padding(
//           padding: const EdgeInsets.only(top: 100, left: 15, right: 15),
//           child: Divider(
//             color: Color.fromARGB(255, 135, 146, 167),
//           ),
//         )),
//         Align(
//           alignment: Alignment.bottomCenter,
//           child: Padding(
//             padding: const EdgeInsets.only(left: 19, right: 15, bottom: 16),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   date.toString(),
//                   style: TextStyle(
//                       //color: Color.fromARGB(255, 135, 146, 167),
//                       color: Colors.white,
//                       fontSize: 15),
//                 ),
//                 GestureDetector(
//                   onTap: () {},
//                   child: Container(
//                     height: 35,
//                     // width: 70,
//                     padding: EdgeInsets.only(left: 15, right: 15),
//                     decoration: BoxDecoration(
//                       //  color: Colors.amber,
//                       border:
//                           Border.all(color: Color.fromARGB(255, 135, 146, 167)),
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Center(
//                       child: Text(
//                         //'₹${12}',
//                         "₹ ${AmountUtils.formatAmount(amount: amount)}",
//                         style: TextStyle(
//                             // color: Color.fromARGB(255, 135, 146, 167),
//                             color: Colors.orange,
//                             fontSize: 15),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         Positioned(
//           right: 12,
//           top: 12,
//           child: Container(
//             padding: EdgeInsets.all(2),
//             decoration: BoxDecoration(
//                 color: Color.fromARGB(255, 255, 255, 255),
//                 borderRadius: BorderRadius.circular(18)),
//             child: Column(
//               children: [
//                 SizedBox(
//                   height: 2,
//                 ),
//                 InkWell(
//                   onTap: () {
//                     HapticFeedback.mediumImpact();
//                     ExpenseDetailsPageController.titelController.text=ExpenseList.title;
//                      ExpenseDetailsPageController.descriptionController.text=ExpenseList.description;
//                       ExpenseDetailsPageController.amountController.text=ExpenseList.amount.toString();
//                     updateExpenseBottomSheetById(
//                         context: context, expId: EXPID, expTitel: expTitel);
//                   },
//                   child: Image.asset(
//                     color: Colors.black,
//                     '${ImageIconPathSet.basePath}/pen-circle.png',
//                     height: 40,
//                   ),
//                 ),
//                 InkWell(
//                   onTap: () {
//                     context.read<ExpenseBloc>().add(ExpenseEvent.deleteExpenseByUuid(uuid: ExpenseList.uuid));

//                           context
//           .read<ExpenseBloc>() 
//           .add(ExpenseEvent.getTottelAmountExpensesById(expTitel: expTitel));
//       // log("callling Exp Page Start");
//       context
//           .read<ExpenseBloc>()
//           .add(ExpenseEvent.getExpensesByIdList(expTitel: expTitel));
//                   },
//                   child: Padding(
//                     padding: const EdgeInsets.only(
//                       top: 50,
//                     ),
//                     child: Image.asset(
//                       '${ImageIconPathSet.basePath}/delete.png',
//                       height: 40,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     ),
//   );
// }



class ExpensCardWithAnimation extends StatefulWidget {
  final dynamic ExpenseList; // Assuming it's an Expense model
  final String Tittle;
  final String Descrptin;
  final String date;
  final double amount;
  final int index;
  final String EXPID;
  final String image;
  final String expTitel;

  const ExpensCardWithAnimation({
    required this.Tittle,
    required this.Descrptin,
    required this.date,
    required this.amount,
    required this.index,
    required this.EXPID,
    required this.image,
    required this.expTitel,
    required this.ExpenseList,
  });

  @override
  _ExpensCardWithAnimationState createState() => _ExpensCardWithAnimationState();
}

class _ExpensCardWithAnimationState extends State<ExpensCardWithAnimation> with SingleTickerProviderStateMixin {


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Color(0xFF171C26), borderRadius: BorderRadius.circular(30)),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 70,
              width: 300,
              child: ListTile(
                title: Text(
                  widget.Tittle.trim(),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 21,
                      fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  widget.Descrptin.trim(),
                  style: TextStyle(
                      color: Color.fromARGB(255, 135, 146, 167),
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          Align(
              child: Padding(
            padding: const EdgeInsets.only(top: 100, left: 15, right: 15),
            child: Divider(
              color: Color.fromARGB(255, 135, 146, 167),
            ),
          )),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(left: 19, right: 15, bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.date,
                    style: TextStyle(
                        color: Colors.white, fontSize: 15),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 35,
                      padding: EdgeInsets.only(left: 15, right: 15),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Color.fromARGB(255, 135, 146, 167)),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          "₹ ${AmountUtils.formatAmount(amount: widget.amount)  }",
                          style: TextStyle(
                              color: Colors.orange, fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: 12,
            top: 12,
            child: Container(
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(18)),
              child: Column(
                children: [
                  SizedBox(height: 2),
                  InkWell(
                    onTap: () {
                      HapticFeedback.mediumImpact();
                      // Assuming the ExpenseDetailsPageController exists
                      ExpenseDetailsPageController.titelController.text =
                          widget.ExpenseList.title;
                      ExpenseDetailsPageController.descriptionController.text =
                          widget.ExpenseList.description;
                      ExpenseDetailsPageController.amountController.text =
                          widget.ExpenseList.amount.toString();
                      updateExpenseBottomSheetById(
                        context: context,
                        expId: widget.EXPID,
                        expTitel: widget.expTitel,
                      );
                    },
                    child: Image.asset(
                      color: Colors.black,
                      '${ImageIconPathSet.basePath}/pen-circle.png',
                      height: 40,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      context.read<ExpenseBloc>().add(
                          ExpenseEvent.deleteExpenseByUuid(
                              uuid: widget.ExpenseList.uuid));
    
                      context.read<ExpenseBloc>().add(
                          ExpenseEvent.getTottelAmountExpensesById(
                              expTitel: widget.expTitel));
                      context.read<ExpenseBloc>().add(
                          ExpenseEvent.getExpensesByIdList(
                              expTitel: widget.expTitel));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Image.asset(
                        '${ImageIconPathSet.basePath}/delete.png',
                        height: 40,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
