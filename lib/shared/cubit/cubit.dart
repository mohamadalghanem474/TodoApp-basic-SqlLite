import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/screens/archived_tasks/archived_tasks_screen.dart';
import 'package:todo/screens/done_tasks/done_tasks_screen.dart';
import 'package:todo/screens/new_tasks/new_tasks_screen.dart';
import 'package:todo/shared/cubit/states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInstialState());
  static AppCubit get(context) => BlocProvider.of(context);
  late Database database;
  List<Map> newTasks = [];
  List<Map> donetTsks = [];
  List<Map> archivedTasks = [];

  void creatDatabase() async {
    database = await openDatabase(
      'todo.db',
      version: 1,
      onCreate: (db, version) {
        print('Database Created');
        //id int
        // title string
        // date string
        // time string
        //status string
        db
            .execute(
                'CREATE TABLE tasks (id INTEGER PRIMARY KEY , title TEXT , date TEXT , time TEXT ,status TEXT)')
            .then((value) {
          print('table create');
        }).catchError((error) {
          print('error when create');
        });
      },
      onOpen: (database) {
        getDataFromDatabase(database);
        print('Database Open');
      },
    );
  }

  //EndcreateDatabase
  //InsertToDatabase
  insertToDatabase({
    required String date,
    required String title,
    required String time,
  }) async {
    await database.transaction((txn) {
      return
          //id INTEGER PRIMARY KEY , title TEXT , date TEXT , time TEXT ,status TEXT
          txn
              .rawInsert(
                  'INSERT INTO tasks(title , date , time ,status) VALUES("$title" , "$date","$time","new")')
              .then((value) {
        print('$value inserted successfully');
        emit(AppInsartDataBase());
        getDataFromDatabase(database);
      }).catchError((error) {
        print('error when inserted new record${error.toString()}');
      });
    });
  }

//end insertToDatabase
//start get gateDataFromdatabase
  void getDataFromDatabase(database) {
    donetTsks = [];
    newTasks = [];
    archivedTasks = [];
    emit(AppGetLodingDataBase());
    database.rawQuery('SELECT * FROM tasks').then((value) {
      value.forEach(
        (element) {
          if (element['status'] == 'new') {
            newTasks.add(element);
          } else if (element['status'] == 'done') {
            donetTsks.add(element);
          } else {
            archivedTasks.add(element);
          }
        },
      );
      emit(AppGetDataBase());
    });
  }

//end get gateDataFromdatabase

//statrt upgate data
  void updateData({required status, required id}) {
    database.rawUpdate(
        'UPDATE tasks SET status=? WHERE id=?', ['$status', id]).then((value) {
      getDataFromDatabase(database);
      emit(AppUpdateDataBase());
    });
  }

  void deleteData({required id}) {
    database.rawDelete('DELETE FROM tasks WHERE id = ?', ['$id']).then((value) {
      getDataFromDatabase(database);
      emit(AppDeleteDataBase());
    });
  }

//end upgate data
  //==================================
  bool isButtonShetShow = false;
  IconData fabIcon = Icons.edit;

  int currentIndex = 0;

  List<Widget> screens = [
    const NewTasksScreen(),
    const DoneTasksScreen(),
    const ArchivedTasksScreen()
  ];

  List<String> titles = ['newTasks', 'DoneTasks', 'archivedTasks'];

  //==================================

  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeButtomNavBarState());
  }

  void changeButtomsheet({required bool isShow, required IconData icon}) {
    isButtonShetShow = isShow;
    fabIcon = icon;
    emit(AppChangeButtomsheetState());
  }
}
