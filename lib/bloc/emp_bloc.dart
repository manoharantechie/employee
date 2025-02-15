import 'package:bloc/bloc.dart';
import 'package:employee/bloc/emp_event.dart';
import 'package:employee/bloc/emp_state.dart';
import 'package:employee/model/emp_model.dart';
import 'package:employee/services/db_services.dart';
import 'package:equatable/equatable.dart';


class EmpBloc extends Bloc<EmpEvent, EmpState> {
  EmpBloc() : super(EmpInitial()) {
    List<EmpDetails> empDetails = [];
    on<AddEmp>((event, emit) async {
      await DatabaseService.instance.create(
        EmpDetails(
          createdTime: event.createdTime,
          endDate: event.endDate,
          startDate: event.startDate,
          isImportant: event.isImportant,
          role: event.role,
          empName: event.empName,
        ),
      );
    });

    on<UpdateEmp>((event, emit) async {
      await DatabaseService.instance.update(
        todo: event.empDetails,
      );
    });

    on<FetchEmps>((event, emit) async {
      empDetails = await DatabaseService.instance.readAllemp();
      emit(DisplayEmps(empDetails: empDetails));
    });

    on<FetchSpecificEmp>((event, emit) async {
      EmpDetails empDetails = await DatabaseService.instance.readTodo(id: event.id);
      emit(DisplaySpecificEmp(empDetails: empDetails));
    });

    on<DeleteEmp>((event, emit) async {
      await DatabaseService.instance.delete(id: event.id);
      add(const FetchEmps());
    });
  }
}