import 'anlik.dart';

class AnlikGunlukSaatlik {
  double enlem;
  double boylam;
  String zamanDilimi;

  Anlik anlik;
  List<Anlik> saatlik;
  List<Anlik> gunluk;

  AnlikGunlukSaatlik.fromJson(Map json) {
    this.enlem = json['lat'];
    this.boylam = json['lon'];
    this.zamanDilimi = json['timezone'];
    this.anlik = Anlik.fromJson(json['current']);
    this.saatlik = (json['hourly'] ?? [])
        .map((eleman) => Anlik.fromJson(eleman))
        .toList()
        .cast<Anlik>();

    this.gunluk = (json['daily'] ?? [])
        .map((eleman) => Anlik.fromJson(eleman))
        .toList()
        .cast<Anlik>();
  }
}
