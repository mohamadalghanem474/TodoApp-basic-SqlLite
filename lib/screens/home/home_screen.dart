import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/constant/main_material_app.dart';
import 'package:intl/intl.dart';
import 'package:todo/shared/cubit/cubit.dart';
import 'package:todo/shared/cubit/states.dart';

class NavHomeScreen extends StatelessWidget {
  NavHomeScreen({
    super.key,
  });
  //==================
  //keys
  final scaffoldkey = GlobalKey<ScaffoldState>();
  final formkey = GlobalKey<FormState>();
//==============================

  final TextEditingController titleController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  //==================
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..creatDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
          listener: (BuildContext context, state) {
        if (state is AppInsartDataBase) {
          Navigator.pop(context);
        }
      }, builder: (BuildContext context, Object? state) {
        AppCubit appCubit = AppCubit.get(context);
        return Scaffold(
          key: scaffoldkey,
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: appCubit.currentIndex,
              onTap: ((index) {
                appCubit.changeIndex(index);
              }),
              type: BottomNavigationBarType.fixed,
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Tasks'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.check_circle_outline), label: 'Done'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.archive_outlined), label: 'Archive'),
              ]),
          appBar: AppBar(title: Text(appCubit.titles[appCubit.currentIndex])),
          body: state is AppGetLodingDataBase
              ? const Center(child: CircularProgressIndicator())
              : appCubit.screens[appCubit.currentIndex],
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (appCubit.isButtonShetShow) {
                if (formkey.currentState!.validate()) {
                  appCubit.insertToDatabase(
                      date: dateController.text,
                      title: titleController.text,
                      time: timeController.text);
                  // appCubit
                  //     .insertToDatabase(
                  //         date: dateController.text,
                  //         time: timeController.text,
                  //         title: titleController.text)
                  //     .then((value) {
                  //   appCubit
                  //       .getDataFromDatabase(appCubit.database)
                  //       .then((value) {
                  //     Navigator.pop(context);

                  // setState(() {
                  //   isButtonShetShow = false;
                  //   fabIcon = Icons.edit;

                  //   tasks = value;
                  // });
                  //   });
                  // });
                }
              } else {
                scaffoldkey.currentState!
                    .showBottomSheet((context) => Container(
                          color: Colors.grey[100],
                          padding: const EdgeInsets.all(15),
                          child: Form(
                            key: formkey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                KMainTextFormFeld(
                                  prefixIcon: const Icon(Icons.title),
                                  label: const Text('Task title'),
                                  controller: titleController,
                                  keyboardType: TextInputType.text,
                                  functionontap: () {},
                                  coloroutlineinputborder: Colors.black,
                                  coloroutlinefocusedborder: Colors.black,
                                  coloroutlineerrorborder: Colors.black,
                                  coloroutlineenableborder: Colors.black,
                                  widthoutlineinputborder: 1.0,
                                  widthoutlinefocusedborder: 1.0,
                                  widthoutlineerrorborder: 1.0,
                                  widthoutlineenableborder: 1.0,
                                  borderradiusoutlineinputeborder:
                                      BorderRadius.circular(10),
                                  borderradiusoutlineenabledborder:
                                      BorderRadius.circular(10),
                                  borderradiusoutlinefocusedborder:
                                      BorderRadius.circular(10),
                                  borderradiusoutlineerrorborder:
                                      BorderRadius.circular(10),
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return ('this is empty');
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                KMainTextFormFeld(
                                    prefixIcon:
                                        const Icon(Icons.watch_later_outlined),
                                    label: const Text('Task time'),
                                    controller: timeController,
                                    keyboardType: TextInputType.datetime,
                                    functionontap: () {
                                      showTimePicker(
                                              context: context,
                                              initialTime: TimeOfDay.now())
                                          .then((value) {
                                        timeController.text =
                                            value!.format(context).toString();
                                      });
                                    },
                                    coloroutlineinputborder: Colors.black,
                                    coloroutlinefocusedborder: Colors.black,
                                    coloroutlineerrorborder: Colors.black,
                                    coloroutlineenableborder: Colors.black,
                                    widthoutlineinputborder: 1.0,
                                    widthoutlinefocusedborder: 1.0,
                                    widthoutlineerrorborder: 1.0,
                                    widthoutlineenableborder: 1.0,
                                    borderradiusoutlineinputeborder:
                                        BorderRadius.circular(10),
                                    borderradiusoutlineenabledborder:
                                        BorderRadius.circular(10),
                                    borderradiusoutlinefocusedborder:
                                        BorderRadius.circular(10),
                                    borderradiusoutlineerrorborder:
                                        BorderRadius.circular(10),
                                    validator: (String? val) {
                                      if (val!.isEmpty) {
                                        return 'this is empty';
                                      } else {
                                        return null;
                                      }
                                    }),
                                const SizedBox(
                                  height: 10,
                                ),
                                KMainTextFormFeld(
                                    prefixIcon: const Icon(Icons.cabin),
                                    label: const Text('Task time'),
                                    controller: dateController,
                                    keyboardType: TextInputType.datetime,
                                    functionontap: () {
                                      showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime.now(),
                                              lastDate:
                                                  DateTime.parse('2023-12-03'))
                                          .then((value) {
                                        dateController.text =
                                            DateFormat.yMMMd().format(value!);
                                      });
                                    },
                                    coloroutlineinputborder: Colors.black,
                                    coloroutlinefocusedborder: Colors.black,
                                    coloroutlineerrorborder: Colors.red,
                                    coloroutlineenableborder: Colors.black,
                                    widthoutlineinputborder: 1.0,
                                    widthoutlinefocusedborder: 1.0,
                                    widthoutlineerrorborder: 1.0,
                                    widthoutlineenableborder: 1.0,
                                    borderradiusoutlineinputeborder:
                                        BorderRadius.circular(10),
                                    borderradiusoutlineenabledborder:
                                        BorderRadius.circular(10),
                                    borderradiusoutlinefocusedborder:
                                        BorderRadius.circular(10),
                                    borderradiusoutlineerrorborder:
                                        BorderRadius.circular(10),
                                    validator: (String? val) {
                                      if (val!.isEmpty) {
                                        return 'this is empty';
                                      } else {
                                        return null;
                                      }
                                    }),
                              ],
                            ),
                          ),
                        ))
                    .closed
                    .then((value) {
                  appCubit.changeButtomsheet(isShow: false, icon: Icons.edit);
                });
                appCubit.changeButtomsheet(isShow: true, icon: Icons.add);
              }
            },
            child: Icon(appCubit.fabIcon),
          ),
        );
      }),
    );
  }
}
