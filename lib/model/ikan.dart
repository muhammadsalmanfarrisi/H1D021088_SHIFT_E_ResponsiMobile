class Ikan {
  int? id;
  String? namaIkan;
  String? jenis;
  String? warna;
  String? habitat;

  Ikan({this.id, this.namaIkan, this.jenis, this.warna, this.habitat});

  factory Ikan.fromJson(Map<String, dynamic> obj) {
    return Ikan(
        id: int.parse(obj['id']),
        namaIkan: obj['nama'],
        jenis: obj['jenis'],
        warna: obj['warna'],
        habitat: obj['habitat']);
  }
}
