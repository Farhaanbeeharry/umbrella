import 'package:uuid/uuid.dart';

class SideNavDayModel {
  late final String id;
  final String day;
  bool isSelected;

  SideNavDayModel({required this.day, required this.isSelected}) {
    id = const Uuid().v4();
  }
}
