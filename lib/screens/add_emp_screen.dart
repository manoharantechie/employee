import 'package:employee/bloc/emp_bloc.dart';
import 'package:employee/bloc/emp_event.dart';
import 'package:employee/bloc/emp_state.dart';
import 'package:employee/common/custom_widget.dart';
import 'package:employee/common/date/widget/date_picker.dart';
import 'package:employee/common/localization/localizations.dart';
import 'package:employee/common/theme/custom_theme.dart';
import 'package:employee/model/emp_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class AddEmpScreen extends StatefulWidget {
  final EmpDetails empDetails;
  final bool edit;

  const AddEmpScreen({super.key, required this.edit, required this.empDetails});

  @override
  State<AddEmpScreen> createState() => _AddEmpScreenState();
}

class _AddEmpScreenState extends State<AddEmpScreen> {
  int _selectedIndex = 0;
  TextEditingController empName = TextEditingController();
  FocusNode empFocus = FocusNode();
  String role = "Select Role";
  String start_date = "Today", end_date = "No date";
  List<String> roleList = [
    'Project Manager',
    'Flutter Developer',
    'QA Tester',
    'Product Owner'
  ];
  String calSelData = "No Date";

  ScrollController controller = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.edit) {
      empName.text = widget.empDetails.empName;
      role = widget.empDetails.role;
      start_date = widget.empDetails.startDate;
      end_date = widget.empDetails.endDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomTheme.of(context).primaryColor,
        title: Text(
          AppLocalizations.instance.text("loc_add_emp_details"),
          style: CustomWidget(context: context).CustomSizedTextStyle(
              18.0,
              CustomTheme.of(context).focusColor,
              FontWeight.w500,
              'FontRegular'),
        ),
        leadingWidth: 0.0,
        leading: Container(
          width: 0.0,
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: CustomTheme.of(context).focusColor,
        child: addEmpUI(),
      ),
      bottomNavigationBar: Container(
          width: MediaQuery.of(context).size.width,
          height: 70.0,
          decoration: BoxDecoration(
              border: Border(
            top: BorderSide(
              //                    <--- top side
              color: CustomTheme.of(context).highlightColor,
              width: 1.0,
            ),
          )),
          child: Column(
            children: [
              const SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.only(
                          left: 15.0, right: 15.0, top: 8.0, bottom: 8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.0),
                        color: CustomTheme.of(context).highlightColor,
                      ),
                      child: Center(
                        child: Text(
                          AppLocalizations.instance.text("loc_cancel"),
                          style: CustomWidget(context: context)
                              .CustomSizedTextStyle(
                                  16.0,
                                  CustomTheme.of(context).primaryColor,
                                  FontWeight.w500,
                                  'FontRegular'),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  BlocBuilder<EmpBloc, EmpState>(
                    builder: (context, state) {
                      return GestureDetector(
                        onTap: () {
                          if (widget.edit) {
                            context.read<EmpBloc>().add(
                                  UpdateEmp(
                                    empDetails: EmpDetails(
                                      id: widget.empDetails.id,
                                      empName: empName.text.toString(),
                                      isImportant: true,
                                      role: role,
                                      startDate: start_date == "Today"
                                          ? DateTime.now()
                                              .toString()
                                              .substring(0, 10)
                                          : start_date,
                                      endDate: end_date,
                                      createdTime: DateTime.now(),
                                    ),
                                  ),
                                );

                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              duration: Duration(seconds: 1),
                              content:
                                  Text("Employee Details updated successfully"),
                            ));
                            context.read<EmpBloc>().add(const FetchEmps());
                            Navigator.pop(context);
                          } else {
                            print(end_date);
                            if (empName.text.isNotEmpty &&
                                role != "Select Role") {
                              context.read<EmpBloc>().add(
                                    AddEmp(
                                      empName: empName.text.toString(),
                                      isImportant: true,
                                      role: role,
                                      startDate: start_date == "Today"
                                          ? DateTime.now()
                                              .toString()
                                              .substring(0, 10)
                                          : start_date,
                                      endDate: end_date,
                                      createdTime: DateTime.now(),
                                    ),
                                  );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                duration: Duration(seconds: 1),
                                content:
                                    Text("Employee Details added successfully"),
                              ));
                              context.read<EmpBloc>().add(const FetchEmps());
                              Navigator.pop(context);
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(
                                    "Employee Name or Role fields must not be blank"
                                        .toUpperCase()),
                              ));
                            }
                            ;
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                              left: 18.0, right: 18.0, top: 8.0, bottom: 8.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6.0),
                            color: CustomTheme.of(context).primaryColor,
                          ),
                          child: Center(
                            child: Text(
                              widget.edit
                                  ? AppLocalizations.instance.text("loc_update")
                                  : AppLocalizations.instance.text("loc_save"),
                              style: CustomWidget(context: context)
                                  .CustomSizedTextStyle(
                                      16.0,
                                      CustomTheme.of(context).focusColor,
                                      FontWeight.w500,
                                      'FontRegular'),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
            ],
          )),
    );
  }

  Widget addEmpUI() {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: CustomTheme.of(context).focusColor,
      child: Column(
        children: [
          const SizedBox(
            height: 25.0,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 40.0,
            margin: EdgeInsets.only(left: 15.0, right: 15.0),
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: CustomTheme.of(context).focusColor,
                border: Border.all(
                  color: CustomTheme.of(context).dividerColor,
                )),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/icon/user.svg'),
                const SizedBox(
                  width: 15.0,
                ),
                Flexible(
                  child: TextField(
                    controller: empName,
                    decoration: InputDecoration(
                      hintStyle: CustomWidget(context: context)
                          .CustomSizedTextStyle(
                              16.0,
                              CustomTheme.of(context).hintColor,
                              FontWeight.w400,
                              'FontRegular'),
                      hintText: AppLocalizations.instance.text("loc_emp_name"),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      contentPadding: EdgeInsets.only(bottom: 5.0),
                    ),
                    style: CustomWidget(context: context).CustomSizedTextStyle(
                        16.0,
                        CustomTheme.of(context).disabledColor,
                        FontWeight.w400,
                        'FontRegular'),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 15.0,
          ),
          Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(left: 15.0, right: 15.0),
              padding: EdgeInsets.only(
                  left: 10.0, right: 10.0, top: 8.0, bottom: 8.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: CustomTheme.of(context).focusColor,
                  border: Border.all(
                    color: CustomTheme.of(context).dividerColor,
                  )),
              child: GestureDetector(
                onTap: () {
                  chooseRole();
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset('assets/icon/role.svg'),
                    const SizedBox(
                      width: 15.0,
                    ),
                    Flexible(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Text(
                          role,
                          style: CustomWidget(context: context)
                              .CustomSizedTextStyle(
                                  16.0,
                                  role == "Select Role"
                                      ? CustomTheme.of(context).hintColor
                                      : CustomTheme.of(context).disabledColor,
                                  FontWeight.w500,
                                  'FontRegular'),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15.0,
                    ),
                    SvgPicture.asset('assets/icon/down.svg'),
                  ],
                ),
              )),
          const SizedBox(
            height: 15.0,
          ),
          Container(
            width: MediaQuery.of(context).size.width,

            margin: EdgeInsets.only(left: 15.0, right: 15.0),
            //  padding: EdgeInsets.only(left: 10.0, right: 10.0),
            child: Row(
              children: [
                Flexible(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        chooseDate(true);
                      },
                      child: Container(
                        padding:
                            EdgeInsets.only(left: 10.0, top: 8.0, bottom: 8.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: CustomTheme.of(context).focusColor,
                            border: Border.all(
                              color: CustomTheme.of(context).dividerColor,
                            )),
                        child: Row(
                          children: [
                            SvgPicture.asset('assets/icon/calend.svg'),
                            const SizedBox(
                              width: 15.0,
                            ),
                            Flexible(
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                child: Text(
                                  start_date == "Today"
                                      ? start_date
                                      : DateFormat('MMM dd  yyyy')
                                          .format(DateTime.parse(start_date))
                                          .toString(),
                                  style: CustomWidget(context: context)
                                      .CustomSizedTextStyle(
                                          16.0,
                                          CustomTheme.of(context).disabledColor,
                                          FontWeight.w500,
                                          'FontRegular'),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
                const SizedBox(
                  width: 10.0,
                ),
                SvgPicture.asset('assets/icon/arrow.svg'),
                const SizedBox(
                  width: 10.0,
                ),
                Flexible(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        chooseDate(false);
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                            left: 10.0, right: 10.0, top: 8.0, bottom: 8.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: CustomTheme.of(context).focusColor,
                            border: Border.all(
                              color: CustomTheme.of(context).dividerColor,
                            )),
                        child: Row(
                          children: [
                            SvgPicture.asset('assets/icon/calend.svg'),
                            const SizedBox(
                              width: 15.0,
                            ),
                            Flexible(
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                child: Text(
                                  end_date == "No date"
                                      ? end_date
                                      : DateFormat('MMM dd  yyyy')
                                          .format(DateTime.parse(end_date))
                                          .toString(),
                                  style: CustomWidget(context: context)
                                      .CustomSizedTextStyle(
                                          16.0,
                                          end_date == "No date"
                                              ? CustomTheme.of(context)
                                                  .hintColor
                                              : CustomTheme.of(context)
                                                  .disabledColor,
                                          FontWeight.w500,
                                          'FontRegular'),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }

  chooseDate(bool type) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
            backgroundColor: CustomTheme.of(context).focusColor,
            insetPadding: EdgeInsets.all(15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: DatePicker(
                      centerLeadingDate: true,
                      minDate: DateTime(2020),
                      maxDate: DateTime(2026),
                      initialDate: DateTime.now(),
                      currentDate: DateTime.now(),
                      onDateSelected: (date) {
                        setState(() {
                          if (type) {
                            start_date = date.toString().substring(0, 10);
                          } else {
                            end_date = date.toString().substring(0, 10);
                          }
                        });
                      },
                      disabledCellsDecoration: const BoxDecoration(
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                ],
              ),
            ));
      },
    );
  }

  chooseRole() {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        isDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter ssetState) {
            return Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(top: 10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0)),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: <Color>[
                      CustomTheme.of(context).focusColor,
                      CustomTheme.of(context).focusColor,
                    ],
                    tileMode: TileMode.mirror,
                  ),
                ),
                child: Expanded(
                  child: ListView.builder(
                      controller: controller,
                      itemCount: roleList.length,
                      shrinkWrap: true,
                      itemBuilder: ((BuildContext context, int index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 10.0,
                            ),
                            GestureDetector(
                              child: Text(
                                roleList[index].toString(),
                                style: CustomWidget(context: context)
                                    .CustomSizedTextStyle(
                                        16.0,
                                        Theme.of(context).disabledColor,
                                        FontWeight.w500,
                                        'FontRegular'),
                              ),
                              onTap: () {
                                setState(() {
                                  role = roleList[index].toString();
                                  Navigator.pop(context);
                                });
                              },
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Container(
                              height: 0.5,
                              color:
                                  Theme.of(context).hintColor.withOpacity(0.5),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                          ],
                        );
                      })),
                ));
          });
        });
  }
}
