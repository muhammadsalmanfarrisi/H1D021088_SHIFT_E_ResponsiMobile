import 'dart:convert';
import 'package:tokokita/helpers/api.dart';
import 'package:tokokita/helpers/api_url.dart';
import 'package:tokokita/model/ikan.dart';

class IkanBloc {
  static Future<List<Ikan>> getIkans() async {
    String apiUrl = ApiUrl.ListIkan;
    var response = await Api().get(apiUrl);
    var jsonObj = json.decode(response.body);
    List<dynamic> ListIkan = (jsonObj as Map<String, dynamic>)['data'];
    List<Ikan> ikans = [];
    for (int i = 0; i < ListIkan.length; i++) {
      ikans.add(Ikan.fromJson(ListIkan[i]));
    }
    return ikans;
  }

  static Future addIkan({Ikan? ikan}) async {
    String apiUrl = ApiUrl.createIkan;

    var body = {
      "nama": ikan!.namaIkan,
      "jenis": ikan.jenis,
      "warna": ikan.warna,
      "habitat": ikan.habitat,
      
    };

    var response = await Api().post(apiUrl, body);
    var jsonObj = json.decode(response.body);
    return jsonObj['status'];
  }

  static Future<bool> updateIkan({required Ikan ikan}) async {
    String apiUrl = ApiUrl.updateIkan(ikan.id!);
  print(apiUrl);
  print(ikan);
    var body = {
      "nama": ikan.namaIkan,
      "jenis": ikan.jenis,
      "warna": ikan.warna,
      "habitat": ikan.habitat,
    };
    print("Body : $body");
    var response = await Api().put(apiUrl, jsonEncode(body));
    print(response.body);
    var jsonObj = json.decode(response.body);
    return jsonObj['status'];
  }

  static Future<bool> deleteIkan({int? id}) async {
    String apiUrl = ApiUrl.deleteIkan(id!);

    var response = await Api().delete(apiUrl);
    var jsonObj = json.decode(response.body);
    return (jsonObj as Map<String, dynamic>)['data'];
  }
}
