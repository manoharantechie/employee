import 'package:employee/bloc/emp_bloc.dart';
import 'package:employee/bloc/emp_event.dart';
import 'package:employee/bloc/emp_state.dart';
import 'package:employee/common/custom_widget.dart';

import 'package:employee/common/localization/localizations.dart';
import 'package:employee/common/theme/custom_theme.dart';
import 'package:employee/model/emp_model.dart';
import 'package:employee/screens/add_emp_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class EmployeeListScreen extends StatefulWidget {
  const EmployeeListScreen({super.key});

  @override
  State<EmployeeListScreen> createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  int len = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomTheme.of(context).primaryColor,
        title: Text(
          AppLocalizations.instance.text("loc_app_list"),
          style: CustomWidget(context: context).CustomSizedTextStyle(
              18.0,
              CustomTheme.of(context).focusColor,
              FontWeight.w500,
              'FontRegular'),
        ),
      ),
      body: BlocBuilder<EmpBloc, EmpState>(
        builder: (context, state) {
          if (state is EmpInitial) {
            context.read<EmpBloc>().add(const FetchEmps());
          }
          if (state is DisplayEmps) {
            len = state.empDetails.length;
             List<EmpDetails>listCur=[];
             List<EmpDetails>listpre=[];
             for(int m=0;m<state.empDetails.length;m++){
               if(state.empDetails[m].endDate=="No date"){
                 listCur.add(state.empDetails[m]);
               }
               else{
                 listpre.add(state.empDetails[m]);
               }
             }

            return Container(
                child: state.empDetails.isNotEmpty
                    ? Container(
                        color: CustomTheme.of(context).focusColor,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            listCur.length>0?           Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.all(10.0),
                              color: CustomTheme.of(context).dialogBackgroundColor ,
                             child: Text(
                               AppLocalizations.instance.text("loc_cur_emp_details"),
                               style: CustomWidget(context: context).CustomSizedTextStyle(
                                   15.0,
                                   CustomTheme.of(context).primaryColor,
                                   FontWeight.w500,
                                   'FontRegular'),
                             ),
                            ):Container(width: 0.0,),
                            Expanded(
                                child: ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    padding: const EdgeInsets.all(8),
                                    itemCount: listCur.length,
                                    itemBuilder: (context, i) {
                                      final item = i;
                                      return Dismissible(
                                        // Specify the direction to swipe and delete
                                        direction: DismissDirection.endToStart,
                                        key: UniqueKey(),
                                        onDismissed: (direction) {


                                          context
                                              .read<EmpBloc>()
                                              .add(DeleteEmp(
                                              id: listCur[i].id!));
                                          ScaffoldMessenger.of(
                                              context)
                                              .showSnackBar(
                                              const SnackBar(
                                                duration: Duration(
                                                    milliseconds: 500),
                                                content:
                                                Text("Employee Details removed Successfully"),
                                              ));

                                        },
                                        background: const ColoredBox(
                                          color: Colors.red,
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Padding(
                                              padding: EdgeInsets.all(16.0),
                                              child: Icon(Icons.delete, color: Colors.white),
                                            ),
                                          ),
                                        ),
                                        child: ListTile(title: GestureDetector(
                                          onTap: (){
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => AddEmpScreen(
                                                      edit: true,
                                                      empDetails: listCur[i]
                                                  ),
                                                ));
                                          },
                                          child: Container(
                                            color:
                                            CustomTheme.of(context).focusColor,

                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Padding(padding:EdgeInsets.only(left: 10.0,bottom: 5.0),child: Text(
                                                  listCur[i].empName
                                                      .toString(),
                                                  style: CustomWidget(
                                                      context: context)
                                                      .CustomSizedTextStyle(
                                                      16.0,
                                                      CustomTheme.of(context)
                                                          .disabledColor,
                                                      FontWeight.w500,
                                                      'FontRegular'),
                                                ),),

                                                Padding(padding:EdgeInsets.only(left: 10.0,bottom: 5.0),child: Text(
                                                  listCur[i].role
                                                      .toString(),
                                                  style: CustomWidget(
                                                      context: context)
                                                      .CustomSizedTextStyle(
                                                      14.0,
                                                      CustomTheme.of(context)
                                                          .hintColor,
                                                      FontWeight.w500,
                                                      'FontRegular'),
                                                ),),

                                                Padding(padding:EdgeInsets.only(left: 10.0,bottom: 5.0),child: Text(
                                                  "From "+DateFormat('dd MMM , yyyy')
                                                      .format(DateTime.parse(listCur[i].startDate))
                                                      .toString(),
                                                  style: CustomWidget(
                                                      context: context)
                                                      .CustomSizedTextStyle(
                                                      14.0,
                                                      CustomTheme.of(context)
                                                          .hintColor,
                                                      FontWeight.w500,
                                                      'FontRegular'),
                                                ),),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Container(
                                                  height:1,
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  color: CustomTheme.of(context)
                                                      .dialogBackgroundColor,
                                                )
                                              ],
                                            ),
                                          ),
                                        )),
                                      );

                                    })),
                           listpre.length>0? Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.all(10.0),
                              color: CustomTheme.of(context).dialogBackgroundColor ,
                              child: Text(
                                AppLocalizations.instance.text("loc_pre_emp_details"),
                                style: CustomWidget(context: context).CustomSizedTextStyle(
                                    15.0,
                                    CustomTheme.of(context).primaryColor,
                                    FontWeight.w500,
                                    'FontRegular'),
                              ),
                            ):Container(width: 0.0,),
                            Expanded(
                                child: ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    padding: const EdgeInsets.all(8),
                                    itemCount: listpre.length,
                                    itemBuilder: (context, i) {
                                      final item = i;
                                      return Dismissible(
                                        // Specify the direction to swipe and delete
                                        direction: DismissDirection.endToStart,
                                        key: UniqueKey(),
                                        onDismissed: (direction) {


                                          context
                                              .read<EmpBloc>()
                                              .add(DeleteEmp(
                                              id: listpre[i].id!));
                                          ScaffoldMessenger.of(
                                              context)
                                              .showSnackBar(
                                              const SnackBar(
                                                duration: Duration(
                                                    milliseconds: 500),
                                                content:
                                                Text("Employee Details removed Successfully"),
                                              ));

                                        },
                                        background: const ColoredBox(
                                          color: Colors.red,
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Padding(
                                              padding: EdgeInsets.all(16.0),
                                              child: Icon(Icons.delete, color: Colors.white),
                                            ),
                                          ),
                                        ),
                                        child: ListTile(title: GestureDetector(
                                          onTap: (){
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => AddEmpScreen(
                                                      edit: true,
                                                      empDetails: listpre[i]
                                                  ),
                                                ));
                                          },
                                          child: Container(
                                            color:
                                            CustomTheme.of(context).focusColor,

                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Padding(padding:EdgeInsets.only(left: 10.0,bottom: 5.0),child: Text(
                                                  listpre[i].empName
                                                      .toString(),
                                                  style: CustomWidget(
                                                      context: context)
                                                      .CustomSizedTextStyle(
                                                      16.0,
                                                      CustomTheme.of(context)
                                                          .disabledColor,
                                                      FontWeight.w500,
                                                      'FontRegular'),
                                                ),),

                                                Padding(padding:EdgeInsets.only(left: 10.0,bottom: 5.0),child: Text(
                                                  listpre[i].role
                                                      .toString(),
                                                  style: CustomWidget(
                                                      context: context)
                                                      .CustomSizedTextStyle(
                                                      14.0,
                                                      CustomTheme.of(context)
                                                          .hintColor,
                                                      FontWeight.w500,
                                                      'FontRegular'),
                                                ),),

                                                Padding(padding:EdgeInsets.only(left: 10.0,bottom: 5.0),child: Text(
                                                  DateFormat('dd MMM , yyyy')
                                                      .format(DateTime.parse(listpre[i].startDate))
                                                      .toString()+" - "+ DateFormat('dd MMM , yyyy')
                                                      .format(DateTime.parse(listpre[i].endDate))
                                                      .toString(),
                                                  style: CustomWidget(
                                                      context: context)
                                                      .CustomSizedTextStyle(
                                                      14.0,
                                                      CustomTheme.of(context)
                                                          .hintColor,
                                                      FontWeight.w500,
                                                      'FontRegular'),
                                                ),),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Container(
                                                  height:1,
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  color: CustomTheme.of(context)
                                                      .dialogBackgroundColor,
                                                )
                                              ],
                                            ),
                                          ),
                                        )),
                                      );

                                    })),
                          ],
                        ),
                      )
                    : norecords());
          }
          return Container(
            color: Colors.white,
            child: const Center(child: CircularProgressIndicator()),
          );
        },
      ),
      floatingActionButton: Container(
        margin: EdgeInsets.only(left: 30.0, right: 20.0),
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            len > 0
                ? Text(
                    AppLocalizations.instance.text("loc_swipe"),
                    style: CustomWidget(context: context).CustomSizedTextStyle(
                        15.0,
                        CustomTheme.of(context).hintColor,
                        FontWeight.w500,
                        'FontRegular'),
                  )
                : SizedBox(
                    width: 0.0,
                  ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddEmpScreen(
                        edit: false,
                        empDetails: EmpDetails(isImportant: true, empName: "", role: "", startDate: "", endDate: "", createdTime:DateTime.now())
                      ),
                    ));
              },
              child: Stack(
                children: [
                  Container(
                    height: 50.0,
                    width: 50.0,
                    decoration: BoxDecoration(
                        color: CustomTheme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(8)),
                    child: Center(
                      child: Icon(
                        Icons.add,
                        size: 30.0,
                        color: CustomTheme.of(context).focusColor,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget norecords() {
    return Container(
        color: CustomTheme.of(context).dialogBackgroundColor,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/icon/noemp.png',
              height: MediaQuery.of(context).size.height * 0.27,
            ),
            Text(
              AppLocalizations.instance.text("loc_app_no_record"),
              style: CustomWidget(context: context).CustomSizedTextStyle(
                  18.0,
                  CustomTheme.of(context).disabledColor,
                  FontWeight.w500,
                  'FontRegular'),
            ),
          ],
        ));
  }


}
