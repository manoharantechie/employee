
import 'package:employee/model/emp_model.dart';
import 'package:equatable/equatable.dart';

abstract class EmpEvent extends Equatable {
  const EmpEvent();
}

class AddEmp extends EmpEvent {
  final String empName;
  final bool isImportant;
  final String role;
  final String startDate;
  final String endDate;
  final DateTime createdTime;

  const AddEmp(
      {required this.empName,
        required this.isImportant,
        required this.role,
        required this.startDate,
        required this.endDate,
        required this.createdTime});

  @override
  List<Object?> get props =>
      [empName, isImportant, role, startDate,endDate, createdTime];
}

class UpdateEmp extends EmpEvent {
  final EmpDetails empDetails;
  const UpdateEmp({required this.empDetails});
  @override
  List<Object?> get props => [empDetails];
}

class FetchEmps extends EmpEvent {
  const FetchEmps();

  @override
  List<Object?> get props => [];
}

class FetchSpecificEmp extends EmpEvent {
  final int id;
  const FetchSpecificEmp({required this.id});

  @override
  List<Object?> get props => [id];
}

class DeleteEmp extends EmpEvent {
  final int id;
  const DeleteEmp({required this.id});
  @override
  List<Object?> get props => [id];
}