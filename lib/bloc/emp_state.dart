
import 'package:employee/model/emp_model.dart';
import 'package:equatable/equatable.dart';

abstract class EmpState extends Equatable {
  const EmpState();
}

class EmpInitial extends EmpState {
  @override
  List<Object> get props => [];
}

class DisplayEmps extends EmpState {
  final List<EmpDetails> empDetails;

  const DisplayEmps({required this.empDetails});
  @override
  List<Object> get props => [empDetails];
}

class DisplaySpecificEmp extends EmpState {
  final EmpDetails empDetails;

  const DisplaySpecificEmp({required this.empDetails});
  @override
  List<Object> get props => [empDetails];
}