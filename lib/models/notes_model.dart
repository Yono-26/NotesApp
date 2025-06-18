import 'package:hive/hive.dart';
part 'notes_model.g.dart';

@HiveType(typeId: 1)
class NotesModel extends HiveObject{

  @HiveField(0)

  late String title;

  @HiveField(1)

  late String content;

  @HiveField(3)

  late DateTime date;

  NotesModel({required this.title, required this.content, required this.date});

}