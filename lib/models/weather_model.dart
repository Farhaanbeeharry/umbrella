import 'package:uuid/uuid.dart';

class WeatherModel {
  late final String id;
  final String day;
  bool isSelected;
  String? weatherAM;
  String? weatherPM;

  WeatherModel({required this.day, required this.isSelected}) {
    id = const Uuid().v4();
  }

  bool isRainingAM() {
    return weatherAM == 'Rainy' || weatherAM == 'Thunderstorm';
  }

  bool isRainingPM() {
    return weatherPM == 'Rainy' || weatherPM == 'Thunderstorm';
  }

  @override
  String toString() {
    return "id: $id, day: $day, weatherAM: $weatherAM, weatherPM: $weatherPM";
  }
}
