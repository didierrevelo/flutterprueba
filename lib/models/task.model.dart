import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class TaskModel extends Equatable {
  final String title;
  final String description;
  final String date;
  final String date2;
  final String id;
  bool? isDone;
  bool? isDelete;
  bool? isFavorite;
  

  TaskModel({
    required this.title,
    required this.description,
    required this.date,
    required this.date2,
    required this.id,
    this.isDone,
    this.isDelete,
    this.isFavorite,
  }) {
    isDone = isDone ?? false;
    isDelete = isDelete ?? false;
    isFavorite = isFavorite ?? false;
  }

  TaskModel copyWith({
    String? title,
    String? description,
    String? date,
    String? date2,
    bool? isDone,
    bool? isDelete,
    bool? isFavorite,
  }) {
    return TaskModel(
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
      date2: date2 ?? this.date2,
      id: id,
      isDone: isDone ?? this.isDone,
      isDelete: isDelete ?? this.isDelete,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'date': date,
      'date2': date2,
      'id': id,
      'isDone': isDone,
      'isDelete': isDelete,
      'isFavorite': isFavorite,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      date: map['date'] ?? '',
      date2: map['date2'] ?? '',
      id: map['id'] ?? '',
      isDone: map['isDone'],
      isDelete: map['isDelete'],
      isFavorite: map['isFavorite'],
    );
  }

  @override
  List<Object?> get props => [
        title,
        description,
        date,
        date2,
        id,
        isDone,
        isDelete,
        isFavorite,
      ];
}
