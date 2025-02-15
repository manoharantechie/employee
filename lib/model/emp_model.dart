const String empTable = 'empDetails';

class EmpDetailsFields {
  static final List<String> values = [
    /// Add all fields
    id, isImportant, empName, role, startDate, endDate,time
  ];

  static const String id = '_id';
  static const String isImportant = 'isImportant';
  static const String empName = 'empName';
  static const String role = 'role';
  static const String startDate = 'startDate';
  static const String endDate = 'endDate';
  static const String time = 'time';
}

class EmpDetails {
  final int? id;
  final bool isImportant;
  final String empName;
  final String role;
  final String startDate;
  final String endDate;
  final DateTime createdTime;


  const EmpDetails({
    this.id,
    required this.isImportant,
    required this.empName,
    required this.role,
    required this.startDate,
    required this.endDate,
    required this.createdTime,

  });

  EmpDetails copy({
    int? id,
    bool? isImportant,
    String? empName,
    String? role,
    String? startDate,
    String? endDate,
    DateTime? createdTime,

  }) =>
      EmpDetails(
        id: id ?? this.id,
        isImportant: isImportant ?? this.isImportant,
        empName: empName ?? this.empName,
        role: role ?? this.role,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        createdTime: createdTime ?? this.createdTime,

      );

  static EmpDetails fromJson(Map<String, Object?> json) => EmpDetails(
    id: json[EmpDetailsFields.id] as int?,
    isImportant: json[EmpDetailsFields.isImportant] == 1,
    empName: json[EmpDetailsFields.empName] as String,
    role: json[EmpDetailsFields.role] as String,
    startDate: json[EmpDetailsFields.startDate] as String,
    endDate: json[EmpDetailsFields.endDate] as String,
    createdTime: DateTime.parse(json[EmpDetailsFields.time] as String),

  );

  Map<String, Object?> toJson() => {
    EmpDetailsFields.id: id,
    EmpDetailsFields.empName: empName,
    EmpDetailsFields.isImportant: isImportant ? 1 : 0,
    EmpDetailsFields.role: role,
    EmpDetailsFields.startDate: startDate,
    EmpDetailsFields.endDate: endDate,
    EmpDetailsFields.time: createdTime.toIso8601String(),

  };
}