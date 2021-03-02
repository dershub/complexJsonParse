import 'hava.dart';
import 'sicaklik.dart';

class Anlik {
  Sicaklik sicaklik;
  int zaman;

  List<Hava> hava;

  Anlik.fromJson(Map json) {
    this.sicaklik = Sicaklik.fromJson(
        (json['temp'] is double) ? {'max': json['temp']} : json['temp']);
    this.zaman = json['dt'];
    this.hava = (json['weather'] ?? [])
        .map((eleman) => Hava.fromJson(eleman))
        .toList()
        .cast<Hava>();
  }
}
